# Define the base image using a build argument
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

WORKDIR /app

# Copy files into the container
COPY ./test_assets /app/

COPY openformat-to-obj.py ShaderManager.xml /app/
