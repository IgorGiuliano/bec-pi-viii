import { Module } from '@nestjs/common';
import { RoboticArmService } from './robotic-arm.service';
import { RoboticArmController } from './robotic-arm.controller';

@Module({
  controllers: [RoboticArmController],
  providers: [RoboticArmService],
})
export class RoboticArmModule {}
