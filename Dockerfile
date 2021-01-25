# Select version from https://hub.docker.com/_/node
FROM node:lts-alpine AS base
# Create a directory to hold the application code inside the image
WORKDIR /app
# Install and cache app dependencies
COPY package.json yarn.lock /app/
# Treat the install as if NODE_ENV=production (overwrite) and do not generate a yarn.lock-file (fail if an update is required)
RUN yarn --production --frozen-lockfile
# Copy everything (except .dockerignore) to the container
COPY . /app/
# On which port should the app be served
EXPOSE ${PORT}
# Set command to run the app
CMD ["node", "src/index.js"]

# Development image contains everything needed for testing, development and building
FROM base AS development
COPY package.json yarn.lock ./
# First set aside prod dependencies so we can copy in to the prod image
RUN yarn install --pure-lockfile --production
# Copy all modules including sub-directores to tmp
RUN cp -R node_modules /tmp/node_modules
# Install all dependencies
RUN yarn install --pure-lockfile
# Add source code
COPY . .

# Builder runs linter, then builds production code
FROM development as builder
RUN yarn lint
RUN yarn babel ./src -d ./dist --copy-files --no-copy-ignored --minified true --comment false --ignore "src/**/*.spec.js","src/**/*.test.js"

# release includes bare minimum required to run the app, copied from builder
FROM base AS release
COPY --from=builder /tmp/node_modules /app/node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./
CMD ["pm2-runtime", "./dist/index.js"]
