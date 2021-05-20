import { graphqlHTTP } from 'express-graphql';

import schema from '$/application/graphql/schemas';
import config from '$/application/setup';

export default graphqlHTTP(async request => ({
  schema,
  graphiql: config.IS_DEV ? { headerEditorEnabled: true } : false,
  context: { request },
}));
