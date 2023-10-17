import { Injectable } from '@nestjs/common';
import { CreateRoboticArmDto } from './dto/create-robotic-arm.dto';
import { UpdateRoboticArmDto } from './dto/update-robotic-arm.dto';

@Injectable()
export class RoboticArmService {
  create(createRoboticArmDto: CreateRoboticArmDto) {
    return 'This action adds a new roboticArm';
  }

  findAll() {
    return `This action returns all roboticArm`;
  }

  findOne(id: number) {
    return `This action returns a #${id} roboticArm`;
  }

  update(id: number, updateRoboticArmDto: UpdateRoboticArmDto) {
    return `This action updates a #${id} roboticArm`;
  }

  remove(id: number) {
    return `This action removes a #${id} roboticArm`;
  }
}
