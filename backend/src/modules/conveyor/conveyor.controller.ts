import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { ConveyorService } from './conveyor.service';
import { ApiBody, ApiConsumes, ApiResponse, ApiTags } from '@nestjs/swagger';
import { CreateConveyorDto } from './dto/create-conveyor.dto';
import { UpdateConveyorDto } from './dto/update-conveyor.dto';

@ApiTags('Conveyor')
@Controller('conveyor')
export class ConveyorController {
  constructor(private readonly conveyorService: ConveyorService) {}

  @Post()
  create(@Body() createConveyorDto: CreateConveyorDto) {
    return this.conveyorService.create(createConveyorDto);
  }

  @Get()
  findAll() {
    return this.conveyorService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.conveyorService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateConveyorDto: UpdateConveyorDto) {
    return this.conveyorService.update(+id, updateConveyorDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.conveyorService.remove(+id);
  }
}
