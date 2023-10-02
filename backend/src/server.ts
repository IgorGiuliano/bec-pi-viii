import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import { errorHandler } from '@middlewares/errorHandler';

const app = express();

app.use(cors());
app.use(express.json());
app.use(errorHandler);

app.listen((process.env.PORT || 80), () => {
    console.log(`Server running on port ${process.env.PORT || 80}`);
});