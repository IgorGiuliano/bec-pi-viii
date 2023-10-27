import { PartialType } from '@nestjs/mapped-types';
import { CreateRoboticArmDto } from './create-robotic-arm.dto';

export class UpdateRoboticArmDto extends PartialType(CreateRoboticArmDto) {}
