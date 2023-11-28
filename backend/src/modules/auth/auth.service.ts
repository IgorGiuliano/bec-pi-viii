import { Injectable, UnauthorizedException } from '@nestjs/common';
import { LoginDto } from './dto/login.dto';
import { sign } from 'jsonwebtoken';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  async login(loginDto: LoginDto) {
    const { email, password } = loginDto;

    const existsUser = await prisma.user.findFirst({
      where: {
        email,
      },
    });

    if (!existsUser) {
      throw new UnauthorizedException('O usuário não foi cadastrado');
    }

    if (!(await bcrypt.compare(password, existsUser.password))) {
      throw new UnauthorizedException('Usuário ou senha incorretos');
    }

    const accessToken = sign(
      { user: { name: existsUser.name, role: existsUser.role } },
      process.env.JWT_SECRET,
      { subject: existsUser.id_user, expiresIn: '1d' },
    );

    return {
      accessToken,
      data: {
        id: existsUser.id_user,
        name: existsUser.name,
        email: existsUser.email,
      },
    };
  }
}
