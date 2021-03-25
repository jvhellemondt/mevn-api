import { schemaComposer } from 'graphql-compose'

import 'src/application/graphql/types.js'

import AuthenticationSchema from '~/authentication/schemas'

schemaComposer.merge(AuthenticationSchema)

export default schemaComposer.buildSchema()
