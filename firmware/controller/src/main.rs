use std::io::Write;

use dialoguer::Select;
use sdl2::controller::{Axis, Button};
use sdl2::event::Event;
use sdl2::rwops::RWops;
use serialport::{ClearBuffer, SerialPort};

const BUTTONS: [Button; 8] = [
    Button::LeftShoulder,
    Button::RightShoulder,
    Button::Back,
    Button::Start,
    Button::A,
    Button::B,
    Button::X,
    Button::Y,
];

const TRIGGERS: [Axis; 2] = [
    Axis::TriggerLeft,
    Axis::TriggerRight,
];


fn send_msg_arduino(serial_port: &mut Box<dyn SerialPort>, msg: &str) -> Result<(), String> {
    let mut buf = msg.as_bytes().to_vec();
    let mut end_msg = "/".as_bytes().to_vec();
    buf.append(&mut end_msg);

    serial_port.write_all(buf.as_slice()).unwrap();
    serial_port.flush().unwrap();
    serial_port.clear(ClearBuffer::All).unwrap();

    Ok(())
}

fn run(mut serial_port: Box<dyn SerialPort>) -> Result<(), String> {
    let sdl = sdl2::init()?;
    let joystick = sdl.game_controller()?;
    let rw = RWops::from_file("controller_mapping.txt", "rb")?;
    joystick.load_mappings_from_rw(rw).map_err(|e| e.to_string())?;
    let _game_controller = joystick.open(0).map_err(|e| e.to_string())?;
    let mut event_pump = sdl.event_pump()?;

    loop {
        let event = match event_pump.poll_event() {
            Some(event) => event,
            None => continue
        };

        if let Event::ControllerButtonDown { button: button_down, .. } = event {
            if BUTTONS.contains(&button_down) {
                send_msg_arduino(&mut serial_port, &button_down.string())?;
            }

            loop {
                let event = match event_pump.poll_event() {
                    Some(event) => event,
                    None => continue
                };

                if let Event::ControllerButtonUp { button: button_up, .. } = event {
                    if button_up == button_down {
                        break;
                    }
                }

                println!("Segurando botão");
            }

            println!("Saiu do loop");
            if BUTTONS.contains(&button_down) {
                send_msg_arduino(&mut serial_port, &button_down.string())?;
            }
        }
        if let Event::ControllerAxisMotion { axis: axis_down, .. } = event {
            if TRIGGERS.contains(&axis_down) {
                send_msg_arduino(&mut serial_port, &axis_down.string())?;
            }

            loop {
                let event = match event_pump.poll_event() {
                    Some(event) => event,
                    None => continue
                };

                if let Event::ControllerAxisMotion { axis: axis_up, .. } = event {
                    if axis_up == axis_down {
                        break;
                    }
                }

                println!("Segurando botão");
            }

            println!("Saiu do loop");
            if TRIGGERS.contains(&axis_down) {
                send_msg_arduino(&mut serial_port, &axis_down.string())?;
            }
        }
    }
}

fn main() -> Result<(), String> {
    let ports: Vec<String> = serialport::available_ports()
        .map_err(|e| e.to_string())?
        .iter()
        .map(|p| p.port_name.clone())
        .collect();

    if ports.is_empty() {
        return Err("Nenhuma porta disponivel".to_owned());
    }

    let selection = Select::new()
        .with_prompt("Escolha uma porta:")
        .items(&ports)
        .interact()
        .unwrap();

    let serial_port = serialport::new(&ports[selection], 115200)
        .open()
        .map_err(|e| e.to_string())?;

    run(serial_port)
}
