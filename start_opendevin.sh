
#!/bin/bash

# Check if user exists and create if not
if ! id -u enduser > /dev/null 2>&1; then
    useradd -u 1000 -m enduser
fi

# Start OpenDevin without Docker socket dependency
exec /opt/opendevin/start.sh
