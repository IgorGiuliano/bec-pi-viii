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
import { ConveyorService } from './conveyor.service';
import { ApiBody, ApiConsumes, ApiResponse, ApiTags } from '@nestjs/swagger';
import { CreateConveyorDto } from './dto/create-conveyor.dto';
import { UpdateConveyorDto } from './dto/update-conveyor.dto';

@ApiTags('Conveyor')
@Controller('conveyor')
export class ConveyorController {
  constructor(private readonly conveyorService: ConveyorService) {}

  @ApiConsumes('application/json')
  @ApiBody({ type: CreateConveyorDto })
  @ApiResponse({ status: 200, description: 'Sucesso ao registrar' })
  @Post('/create-conveyor')
  @HttpCode(200)
  create(@Body() createConveyorDto: CreateConveyorDto) {
    return this.conveyorService.create(createConveyorDto);
  }

  @Get('/list-conveyor')
  @HttpCode(200)
  findAll() {
    return this.conveyorService.findAll();
  }

  @Get('/find-conveyor/:id')
  findOne(@Param('id') id: string) {
    return this.conveyorService.findOne(id);
  }

  @Patch('/find-conveyor/:id')
  update(
    @Param('id') id: string,
    @Body() updateConveyorDto: UpdateConveyorDto,
  ) {
    return this.conveyorService.update(id, updateConveyorDto);
  }

  @Delete('/disable-conveyor/:id')
  remove(@Param('id') id: string) {
    return this.conveyorService.remove(id);
  }
}
