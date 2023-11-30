#ifndef Controller_h
#define Controller_h

#include <ESP32Servo.h>

class ArmServo {
  Servo servo;
  bool move_foward;
  bool move_backward;
  std::string foward_msg;
  std::string backward_msg;
  uint8_t pin;
  uint8_t position;

public:
  ArmServo(uint8_t pin, const char* bwd_msg, const char* fwd_msg)
    : servo{}, move_foward{ false }, move_backward{ false }, foward_msg{ fwd_msg }, backward_msg{ bwd_msg }, pin{ pin }, position{ 0 } {
    servo.attach(pin);
    servo.write(0);
  }

  void update_status(const char* msg);
  void move();
  bool is_stopped();
  void set_position(uint8_t pos);
};

#endif