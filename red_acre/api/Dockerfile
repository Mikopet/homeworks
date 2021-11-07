# Using a latest python basically can be a good idea. Lets see, is that working here, or not.
# Im usually using alpine, because of the small footprint and few bootstrap elements.
FROM python:3.10-alpine

# Just syntactic sugar
ENV APP_PATH /app
WORKDIR $APP_PATH

# Installing needed build dependencies
RUN apk add --no-cache --virtual .build-deps gcc musl-dev linux-headers

# copying the dependency file to the workdir
COPY requirements.txt $APP_PATH

# build software
RUN pip install -r requirements.txt

# delete build dependencies (well, I know these are still present in previous layers, but we can use squashing if we want)
RUN apk del .build-deps

# Copy the application files to workdir
COPY . $APP_PATH

# run software with defaults
CMD ["python", "app.py"]
