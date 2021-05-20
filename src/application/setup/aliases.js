import moduleAlias  from 'module-alias';
import { ROOT_DIR } from './constants';

moduleAlias.addAliases({
  '$': `${ROOT_DIR}/src`,
  '~': `${ROOT_DIR}/src/modules`,
});
