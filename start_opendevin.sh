
#!/bin/bash

# Check if user exists and create if not
if ! id -u enduser > /dev/null 2>&1; then
    useradd -u 1000 -m enduser
fi

# Start OpenDevin
docker run -it --pull=always -e SANDBOX_USER_ID=$(id -u) -e WORKSPACE_MOUNT_PATH=$WORKSPACE_BASE -v $WORKSPACE_BASE:/opt/workspace_base -p 3000:3000 --add-host host.docker.internal:host-gateway ghcr.io/opendevin/opendevin:0.5
