import { Injectable } from '@nestjs/common';
import { CreateConveyorDto } from './dto/create-conveyor.dto';
import { UpdateConveyorDto } from './dto/update-conveyor.dto';

@Injectable()
export class ConveyorService {
  create(createConveyorDto: CreateConveyorDto) {
    return 'This action adds a new conveyor';
  }

  findAll() {
    return `This action returns all conveyor`;
  }

  findOne(id: number) {
    return `This action returns a #${id} conveyor`;
  }

  update(id: number, updateConveyorDto: UpdateConveyorDto) {
    return `This action updates a #${id} conveyor`;
  }

  remove(id: number) {
    return `This action removes a #${id} conveyor`;
  }
}
