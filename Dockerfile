
FROM ghcr.io/opendevin/opendevin:0.5

# Set environment variables
ENV SANDBOX_USER_ID=1000
ENV WORKSPACE_MOUNT_PATH=/opt/workspace_base

# Create workspace directory
RUN mkdir -p /opt/workspace_base

# Check if user exists and create if not
RUN if ! id -u enduser > /dev/null 2>&1; then useradd -u 1000 -m enduser; fi

# Expose the port OpenDevin runs on
EXPOSE 3000

# Start OpenDevin
CMD ["bash", "-c", "if ! id -u enduser > /dev/null 2>&1; then useradd -u 1000 -m enduser; fi && docker run -it --pull=always -e SANDBOX_USER_ID=$(id -u) -e WORKSPACE_MOUNT_PATH=$WORKSPACE_BASE -v $WORKSPACE_BASE:/opt/workspace_base -p 3000:3000 --add-host host.docker.internal:host-gateway ghcr.io/opendevin/opendevin:0.5"]
