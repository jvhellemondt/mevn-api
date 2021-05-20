import './aliases'
import * as constants    from '$/application/setup/constants'
import initializeExpress from '$/application/setup/express'
import middlewareConfig  from '$/application/setup/middleware'

const initializeServer = (app) => {
  try {
    import('$/application/setup/redis.js')
    import('$/application/setup/mongodb.js')
    initializeExpress(app)
  } catch (error) {
    console.error(error)
  }
}

export default constants
export { middlewareConfig, initializeServer }
