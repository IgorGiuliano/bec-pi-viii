import { Injectable } from '@nestjs/common';
import { CreateConveyorDto } from './dto/create-conveyor.dto';
import { UpdateConveyorDto } from './dto/update-conveyor.dto';

@Injectable()
export class ConveyorService {
  async create(createConveyorDto: CreateConveyorDto) {
    const { name } = createConveyorDto;

    const conveyorExists = await prisma.conveyor.findFirst({
      where: {
        name,
      },
    });

    if (conveyorExists) {
      throw new Error('A esteira já existe');
    }

    const conveyor = await prisma.conveyor.create({
      data: {
        name,
      },
    });

    return conveyor;
  }

  async findAll() {
    const conveyor = await prisma.conveyor.findMany({
      select: {
        id_conveyor: true,
        name: true,
      },
    });
    return conveyor;
  }

  async findOne(id: string) {
    const conveyor = await prisma.conveyor.findFirst({
      where: {
        id_conveyor: id,
      },
    });

    if (!conveyor) {
      throw new Error('Esteira inexistente');
    }

    return conveyor;
  }

  async update(id: string, data: UpdateConveyorDto) {
    const { name } = data;

    const conveyor = await prisma.conveyor.update({
      where: {
        id_conveyor: id,
      },
      data: {
        name,
      },
    });

    return conveyor;
  }

  async remove(id: string) {
    const conveyor = await prisma.conveyor.delete({
      where: {
        id_conveyor: id,
      },
    });

    return conveyor;
  }
}
