# Idea is the same as in the python container, just in this case I cannot use the most recent version.
FROM node:16-alpine

# The syntactic sugar
ENV APP_PATH /app
WORKDIR $APP_PATH

# The installation of needed build dependencies
#RUN apk add --no-cache --virtual .build-deps gcc musl-dev linux-headers

# The copying the dependency file to the workdir
COPY package.* yarn.* $APP_PATH

# The software build
RUN npm install

# delete build dependencies (well, I know these are still present in previous layers, but we can use squashing if we want)
# RUN apk del .build-deps

# And finally copy the application files to workdir
COPY . $APP_PATH

# run the software with defaults
CMD ["npm", "start"]

