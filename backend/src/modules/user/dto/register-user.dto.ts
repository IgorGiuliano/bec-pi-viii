import { IsEmail, MinLength, MaxLength } from '@nestjs/class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class RegisterUserDto {
  @ApiProperty()
  @IsEmail()
  email: string;

  @ApiProperty()
  @MinLength(8)
  @MaxLength(20)
  password: string;

  @ApiProperty()
  @MinLength(8)
  @MaxLength(20)
  passwordConfirmation: string;

  @ApiProperty()
  @MinLength(11)
  @MaxLength(11)
  cpf: string;

  @ApiProperty()
  name: string;

  @ApiProperty()
  lastName: string;

  @ApiProperty()
  role: 'ADMIN' | 'NORMAL';

  @ApiProperty()
  enable: boolean;
}
