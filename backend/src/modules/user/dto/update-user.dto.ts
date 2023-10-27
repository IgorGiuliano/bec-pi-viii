import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, MaxLength, MinLength } from '@nestjs/class-validator';

export class UpdateUserDto {
  @ApiProperty()
  @IsEmail()
  email: string;

  @ApiProperty()
  @MinLength(8)
  @MaxLength(20)
  password: string;

  @ApiProperty()
  name: string;

  @ApiProperty()
  lastName: string;

  @ApiProperty()
  role: 'ADMIN' | 'USER';
}
