# This file defines the Docker container that will contain the Flask app.

# From the source image
FROM python:3.6-slim

# Identify maintainer
LABEL maintainer = "anna.mamchyts18@gmail.com"

# Set the default working directory
WORKDIR /app/

# Copy requirements.txt outside the container
# to /app/ inside the container
COPY requirements.txt /app/

# Install required packages
RUN pip install -r ./requirements.txt

# Copy app.py, train.py and__init__.py outside the container
# to /app/ inside the container
COPY app.py __init__.py train.py /app/

# Run model.pkl outside the container
# to /app/ inside the container
Run python train.py

# Expose the container's port 3333
EXPOSE 3333

# When the container starts, run this
ENTRYPOINT python ./app.py
