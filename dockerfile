FROM node:16.13.1-alpine3.14 AS development
WORKDIR /nest-api
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build




FROM node:16.13.1-alpine3.14 AS production
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /nest-api
COPY package*.json ./

RUN npm install --only=prod
COPY . .
COPY --from=development /nest-api/dist ./dist

CMD [ "node", "dist/main" ]