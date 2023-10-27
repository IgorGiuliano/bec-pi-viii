import { Module } from '@nestjs/common';
import { UserModule } from '../user/user.module';
import { ConveyorModule } from '../conveyor/conveyor.module';
import { RoboticArmModule } from '../robotic-arm/robotic-arm.module';
import { AuthModule } from '../auth/auth.module';

@Module({
  imports: [AuthModule, UserModule, ConveyorModule, RoboticArmModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
