import {
  Controller,
  Get,
  Post,
  Body,
  HttpCode,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { UserService } from './user.service';
import { ApiBody, ApiConsumes, ApiResponse, ApiTags } from '@nestjs/swagger';
import { RegisterUserDto } from './dto/register-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';

@ApiTags('User')
@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @ApiConsumes('application/json')
  @ApiBody({ type: RegisterUserDto })
  @ApiResponse({ status: 200, description: 'Sucesso ao registrar' })
  @Post('/register-user')
  @HttpCode(200)
  register(@Body() user: RegisterUserDto) {
    return this.userService.register(user);
  }

  @Get('/list-users')
  findAll() {
    return this.userService.findAll();
  }

  @Get('/find-user/:id')
  findOne(@Param('id') id: string) {
    return this.userService.findOne(id);
  }

  @Patch('/update-user/:id')
  update(@Param('id') id: string, @Body() data: UpdateUserDto) {
    return this.userService.update(id, data);
  }

  @Delete('/disable-user/:id')
  remove(@Param('id') id: string) {
    return this.userService.disable(id);
  }
}
