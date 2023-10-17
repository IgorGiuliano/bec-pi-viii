import { PartialType } from '@nestjs/mapped-types';
import { CreateConveyorDto } from './create-conveyor.dto';

export class UpdateConveyorDto extends PartialType(CreateConveyorDto) {}
