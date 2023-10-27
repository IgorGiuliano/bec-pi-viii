import { Controller, Post, Body, HttpCode } from '@nestjs/common';
import { ApiBody, ApiConsumes, ApiResponse, ApiTags } from '@nestjs/swagger';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';

@ApiTags('Auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @ApiConsumes('application/json')
  @ApiBody({ type: LoginDto })
  @ApiResponse({ status: 200 })
  @Post('/auth')
  @HttpCode(200)
  auth(@Body() loginDto: LoginDto) {
    return this.authService.login(loginDto);
  }
}
