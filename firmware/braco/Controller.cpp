#include "Controller.h"

void ArmServo::update_status(const char* msg) {
  if (!msg) {
    return;
  }

  if (msg == foward_msg) {
    move_foward = !move_foward;
    move_backward = false;
  } else if (msg == backward_msg) {
    move_backward = !move_backward;
    move_foward = false;
  }

  move();
}

void ArmServo::move() {
  if (move_foward && position < 179) {
    position += 2;
  }
  if (move_backward && position > 1) {
    position -= 2;
  }

  servo.write(position);
}

bool ArmServo::is_stopped() {
  return !(move_foward && position < 179)
         && !(move_backward && position > 1);
}

void ArmServo::set_position(uint8_t pos) {
  if (pos > position) {
    for (uint8_t i = position; i <= pos && i <= 180; i++) {
      servo.write(i);
    }
  }
  else {
    for (uint8_t i = position; i >= pos && i >= 0; i--) {
      servo.write(i);
    }
  }
}
