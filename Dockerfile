# Stage 1: Build Stage
FROM ghcr.io/msd-live/jupyter/python-notebook:latest as builder

USER root

RUN apt-get update

# Install tell
RUN pip install --upgrade pip
RUN pip install tell

# Stage 2: Final Stage
FROM ghcr.io/msd-live/jupyter/python-notebook:latest 

USER root

# Copy python packages installed/built from the builder stage
COPY --from=builder /opt/conda/lib/python3.11/site-packages /opt/conda/lib/python3.11/site-packages

# To test this container locally, run:
# docker build -t tell .
# docker run --rm -p 8888:8888 tell

# copy the notebooks to the container
COPY notebooks /home/jovyan/notebooks