import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  HttpCode,
} from '@nestjs/common';
import { RoboticArmService } from './robotic-arm.service';
import { ApiBody, ApiConsumes, ApiResponse, ApiTags } from '@nestjs/swagger';
import { CreateRoboticArmDto } from './dto/create-robotic-arm.dto';
import { UpdateRoboticArmDto } from './dto/update-robotic-arm.dto';

@ApiTags('Robotic Arm')
@Controller('robotic-arm')
export class RoboticArmController {
  constructor(private readonly roboticArmService: RoboticArmService) {}

  @ApiConsumes('application/json')
  @ApiBody({ type: CreateRoboticArmDto })
  @ApiResponse({ status: 200, description: 'Sucesso ao registrar' })
  @Post('/create-roboticarm')
  @HttpCode(200)
  create(@Body() createRoboticArmDto: CreateRoboticArmDto) {
    return this.roboticArmService.create(createRoboticArmDto);
  }

  @Get('/list-roboticarm')
  findAll() {
    return this.roboticArmService.findAll();
  }

  @Get('/find-roboticarm/:id')
  findOne(@Param('id') id: string) {
    return this.roboticArmService.findOne(id);
  }

  @Get('/count-day-records/:id')
  countDayReccords(@Param('id') id: string) {
    return this.roboticArmService.countDayRecords(id);
  }

  @Get('/get-last-twenty/:id')
  lastTwetyRecords(@Param('id') id: string) {
    return this.roboticArmService.lastTwentyRecords(id);
  }

  @Patch('/update-roboticarm/:id')
  update(
    @Param('id') id: string,
    @Body() updateRoboticArmDto: UpdateRoboticArmDto,
  ) {
    return this.roboticArmService.update(id, updateRoboticArmDto);
  }

  @Delete('/disable-roboticarm/:id')
  remove(@Param('id') id: string) {
    return this.roboticArmService.remove(id);
  }
}
