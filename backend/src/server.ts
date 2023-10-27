import 'dotenv/config';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './modules/app/app.module';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  const config = new DocumentBuilder()
    .setTitle('Projeto Brasteira (braço-esteira)')
    .setDescription('API do projeto Brasteira (nome a definir)')
    .setVersion('0.01')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('doc', app, document);

  app.enableCors();
  await app.listen(process.env.PORT || 80, () => {
    console.log(`Server running on port ${process.env.PORT || 80}`);
  });
}
bootstrap();
