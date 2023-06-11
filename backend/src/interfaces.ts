import { Request, Response } from 'express';

export interface controller {
  getUsers?(req: Request, res: Response): void;
}

export interface Iresponse {
  success: boolean;
  status?: number;
  message?: any;
  data?: any;
  error?: any;
}
