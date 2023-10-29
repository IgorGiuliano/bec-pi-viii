import { ApiProperty } from '@nestjs/swagger';

export class UpdateConveyorDto {
  @ApiProperty()
  name: string;
}
