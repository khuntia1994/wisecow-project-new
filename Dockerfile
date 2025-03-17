# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set the working directory
WORKDIR /app

# Install required dependencies
RUN apt update && apt install -y fortune cowsay netcat && rm -rf /var/lib/apt/lists/*

# Copy the script to the container
COPY wisecow.sh /app/wisecow.sh

# Grant execution permissions to the script
RUN chmod +x /app/wisecow.sh

# Expose the required port
EXPOSE 4499

# Run the script when the container starts
ENTRYPOINT ["/bin/bash", "/app/wisecow.sh"]

