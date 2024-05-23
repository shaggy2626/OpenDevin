
FROM ghcr.io/opendevin/opendevin:0.5

# Set environment variables
ENV SANDBOX_USER_ID=1000
ENV WORKSPACE_MOUNT_PATH=/opt/workspace_base

# Create workspace directory
RUN mkdir -p /opt/workspace_base

# Copy custom startup script
COPY start_opendevin.sh /usr/local/bin/start_opendevin.sh
RUN chmod +x /usr/local/bin/start_opendevin.sh

# Expose the port OpenDevin runs on
EXPOSE 3000

# Start OpenDevin using custom startup script
CMD ["/usr/local/bin/start_opendevin.sh"]
