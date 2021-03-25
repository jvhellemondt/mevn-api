import express                                from 'express'
import { initializeServer, middlewareConfig } from './application/setup'

const app = express()
middlewareConfig(app)
initializeServer(app)
