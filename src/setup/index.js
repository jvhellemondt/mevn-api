import * as constants from './constants';
import './aliases';
import middlewareConfig from './middleware';
import initializeExpress from './express';

const initializeServer = (app) => {
  try {
    import('./redis.js');
    import('./mongodb.js');
    initializeExpress(app);
  } catch (error) {
    console.error(error);
  }
};

export default constants;
export { middlewareConfig, initializeServer };
