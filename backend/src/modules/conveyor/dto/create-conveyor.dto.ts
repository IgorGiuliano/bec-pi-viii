import { ApiProperty } from '@nestjs/swagger';

export class CreateConveyorDto {
  @ApiProperty()
  name: string;
}
