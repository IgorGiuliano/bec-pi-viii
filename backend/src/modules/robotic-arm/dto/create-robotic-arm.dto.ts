import { ApiProperty } from '@nestjs/swagger';

export class CreateRoboticArmDto {
  @ApiProperty()
  name: string;
}
