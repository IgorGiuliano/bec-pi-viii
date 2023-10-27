import { Module } from '@nestjs/common';
import { ConveyorService } from './conveyor.service';
import { ConveyorController } from './conveyor.controller';

@Module({
  controllers: [ConveyorController],
  providers: [ConveyorService],
})
export class ConveyorModule {}
