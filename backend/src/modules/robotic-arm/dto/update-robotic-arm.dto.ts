import { ApiProperty } from '@nestjs/swagger';

export class UpdateRoboticArmDto {
  @ApiProperty()
  name: string;
}
