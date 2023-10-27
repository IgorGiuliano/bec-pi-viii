import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { RoboticArmService } from './robotic-arm.service';
import { ApiBody, ApiConsumes, ApiResponse, ApiTags } from '@nestjs/swagger';
import { CreateRoboticArmDto } from './dto/create-robotic-arm.dto';
import { UpdateRoboticArmDto } from './dto/update-robotic-arm.dto';

@ApiTags('Robotic Arm')
@Controller('robotic-arm')
export class RoboticArmController {
  constructor(private readonly roboticArmService: RoboticArmService) {}

  @Post()
  create(@Body() createRoboticArmDto: CreateRoboticArmDto) {
    return this.roboticArmService.create(createRoboticArmDto);
  }

  @Get()
  findAll() {
    return this.roboticArmService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.roboticArmService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateRoboticArmDto: UpdateRoboticArmDto) {
    return this.roboticArmService.update(+id, updateRoboticArmDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.roboticArmService.remove(+id);
  }
}
