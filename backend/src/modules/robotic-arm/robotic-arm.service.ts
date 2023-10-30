import { Injectable } from '@nestjs/common';
import { CreateRoboticArmDto } from './dto/create-robotic-arm.dto';
import { UpdateRoboticArmDto } from './dto/update-robotic-arm.dto';

@Injectable()
export class RoboticArmService {
  async create(createRoboticArmDto: CreateRoboticArmDto) {
    const { name } = createRoboticArmDto;

    const roboticArmExists = await prisma.roboticArm.findFirst({
      where: {
        name,
      },
    });

    if (roboticArmExists) {
      throw new Error('A esteira já existe');
    }

    const roboticArm = await prisma.roboticArm.create({
      data: {
        name,
      },
    });

    return roboticArm;
  }

  async findAll() {
    const roboticArm = await prisma.roboticArm.findMany({
      select: {
        id_roboticArm: true,
        name: true,
      },
    });
    return roboticArm;
  }

  async findOne(id: string) {
    const roboticArm = await prisma.roboticArm.findFirst({
      where: {
        id_roboticArm: id,
      },
    });

    if (!roboticArm) {
      throw new Error('Esteira inexistente');
    }

    return roboticArm;
  }

  async update(id: string, data: UpdateRoboticArmDto) {
    const { name } = data;

    const roboticArm = await prisma.roboticArm.update({
      where: {
        id_roboticArm: id,
      },
      data: {
        name,
      },
    });

    return roboticArm;
  }

  async remove(id: string) {
    const roboticArm = await prisma.roboticArm.delete({
      where: {
        id_roboticArm: id,
      },
    });

    return roboticArm;
  }
}
