import * as constants    from 'src/application/setup/constants';
import 'src/application/setup/aliases';
import middlewareConfig  from 'src/application/setup/middleware';
import initializeExpress from 'src/application/setup/express';

const initializeServer = (app) => {
  try {
    import('src/application/setup/redis.js');
    import('src/application/setup/mongodb.js');
    initializeExpress(app);
  } catch (error) {
    console.error(error);
  }
};

export default constants;
export { middlewareConfig, initializeServer };
