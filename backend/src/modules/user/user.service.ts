import { Injectable } from '@nestjs/common';
import { RegisterUserDto } from './dto/register-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { prisma } from '../../database/database';
import bcrypt from 'bcrypt';

@Injectable()
export class UserService {
  async register(userData: RegisterUserDto) {
    const {
      email,
      password,
      passwordConfirmation,
      cpf,
      name,
      lastName,
      role,
      enable,
    } = userData;

    if (role != 'NORMAL' && role != 'ADMIN') {
      throw new Error('Posição inválida');
    }

    if (password != passwordConfirmation) {
      throw new Error('As senhas não são iguais');
    }

    const existsUser = await prisma.user.findFirst({
      where: {
        email,
      },
    });

    if (!existsUser) {
      const salt = await bcrypt.genSalt(13);
      const hash = await bcrypt.hash(password, salt);

      const user = await prisma.user.create({
        data: {
          email,
          password: hash,
          name,
          last_name: lastName,
          cpf,
          role,
          enable,
        },
      });

      return user;
    }

    throw new Error(`O email ${email} já está sendo utilizado`);
  }

  async findAll() {
    const users = await prisma.user.findMany({
      where: {
        role: 'ADMIN',
      },
      select: {
        id_user: true,
        name: true,
        last_name: true,
        email: true,
      },
    });

    return users;
  }

  async findOne(id: string) {
    const user = await prisma.user.findFirst({
      where: {
        id_user: id,
      },
      select: {
        id_user: true,
        name: true,
        last_name: true,
        email: true,
        role: true,
      },
    });

    if (!user) {
      throw new Error('Usuário inexistente');
    }

    return user;
  }

  async update(id: string, data: UpdateUserDto) {
    const { name, lastName, email } = data;

    const user = await prisma.user.update({
      where: {
        id_user: id,
      },
      data: {
        name: name,
        last_name: lastName,
        email: email,
      },
      select: {
        name: true,
        last_name: true,
        email: true,
      },
    });

    return user;
  }

  async disable(id: string) {
    const user = await prisma.user.delete({
      where: {
        id_user: id,
      },
    });

    return user;
  }
}
