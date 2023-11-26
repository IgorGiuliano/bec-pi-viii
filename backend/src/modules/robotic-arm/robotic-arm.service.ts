import { Injectable } from '@nestjs/common';
import { CreateRoboticArmDto } from './dto/create-robotic-arm.dto';
import { UpdateRoboticArmDto } from './dto/update-robotic-arm.dto';
import { prisma } from '../../database/database';

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

  async countDayRecords() {
    const total = await prisma.collectedStuff.aggregate({
      _sum: {
        count: true,
      },
    });

    const records = await prisma.collectedStuff.groupBy({
      by: ['color'],
      _sum: {
        count: true,
      },
      orderBy: {
        color: 'asc',
      },
    });

    return [total, records];
  }

  async lastTwentyRecords() {
    const lastRecords = await prisma.collectedStuff.findMany({
      select: {
        count: true,
        color: true,
        robotic_arm: true,
        collect_timestamp: true,
      },
      orderBy: {
        collect_timestamp: 'asc',
      },
      take: 20,
    });

    return lastRecords;
  }
}
