//  Bibliotecas:  https://github.com/laurb9/StepperDriver
//                https://github.com/bblanchon/ArduinoJson

#define BAUD_RATE          115200
#define DIR_PIN 12
#define STEP_PIN 14
#define MICROSTEPS 1
#define MOTOR_STEPS 200
#define RPM 120
#define SERVO_PIN 13

#include <Servo.h> // para os motores do braço
#include "BasicStepperDriver.h" // para o motor da esteira


BasicStepperDriver stepper(MOTOR_STEPS, DIR_PIN, STEP_PIN);
Servo servo;

void setup() {
  servo.attach(SERVO_PIN);
  stepper.begin(RPM, MICROSTEPS);
}

void loop() {
  turnServoOrigin();
  delay(1000);

  turnServoLeft();
  delay(1000);
  
  turnServoOrigin();
  delay(1000);

  turnServoRight();
  delay(1000);

  stepperTurn();
  delay(5000);
}

void stepperTurn() {
  stepper.rotate(-90);
}

void turnServoLeft() {
  servo.write(30);
}

void turnServoRight() {
  servo.write(130);
}

void turnServoOrigin() {
  servo.write(80);
}