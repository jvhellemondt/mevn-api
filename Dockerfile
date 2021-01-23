# Select version from https://hub.docker.com/_/node
FROM node:lts-alpine AS base

# Create a directory to hold the application code inside the image
WORKDIR /app

# Install and cache app dependencies
COPY package.json yarn.lock /app/

RUN yarn --production --frozen-lockfile

# Bundle app source
COPY . /app/

# On which port should the app be served
EXPOSE ${PORT}

# Set command to run the app
CMD ["node", "src/index.js"]

# dev image contains everything needed for testing, development and building
FROM base AS development
COPY package.json yarn.lock ./

# first set aside prod dependencies so we can copy in to the prod image
RUN yarn install --pure-lockfile --production
RUN cp -R node_modules /tmp/node_modules

# install all dependencies and add source code
RUN yarn install --pure-lockfile
COPY . .

# builder runs linter, then builds production code
FROM development as builder
RUN yarn lint
RUN yarn babel ./src --out-dir ./dist --copy-files

# release includes bare minimum required to run the app, copied from builder
FROM base AS release
COPY --from=builder /tmp/node_modules /app/node_modules
#COPY --from=builder /app/dist ./dist
#COPY --from=builder /app/package.json ./
CMD ["pm2-runtime", "/app/dist/index.js"]
