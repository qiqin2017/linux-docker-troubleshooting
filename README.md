# Linux & Docker Troubleshooting Toolkit

A small collection of shell scripts for diagnosing common Linux and Docker server problems.

The toolkit provides simple read-only checks for Docker, disk usage, and TCP ports.

## Features

* Check Docker installation and daemon accessibility
* Check Docker socket and user permissions
* Check Docker container status
* Check filesystem and inode usage
* Check Docker disk usage
* Check large directories under `/var`
* Check whether a TCP port is in use
* Check Docker container port mappings
* No automatic destructive cleanup
* No configuration changes by default

## Requirements

* Linux
* Bash
* Docker for Docker-related checks
* `ss` or `netstat` for port checks

Some commands may require `sudo` to display complete information.

## Installation

Clone this repository:

git clone https://github.com/YOUR-USERNAME/linux-docker-troubleshooting-toolkit.git

Enter the project directory:

cd linux-docker-troubleshooting-toolkit

Make the scripts executable:

chmod +x scripts/*.sh

## 1. Docker Environment Check

Use this script when Docker commands are failing or you want to inspect the Docker environment.

Run:

./scripts/docker-check.sh

The script checks:

* Docker installation
* Docker version
* Docker daemon accessibility
* Docker service status
* Docker Unix socket
* Current Linux user
* Docker group membership
* Running and stopped containers

### Common Docker Permission Problem

If you see:

permission denied while trying to connect to the Docker daemon socket

the script can help you inspect:

* Docker socket permissions
* Current user
* Docker group membership
* Docker daemon accessibility

The script does not automatically change permissions.

## 2. Linux Disk Check

Use this script when a server is running out of storage or Docker applications unexpectedly stop working.

Run:

./scripts/disk-check.sh

It checks:

* Filesystem usage
* Inode usage
* Root filesystem usage
* Docker disk usage
* Large directories under `/var`

### Disk Usage Warning

The script reports a warning when the root filesystem becomes heavily used.

It does not automatically delete:

* Docker images
* Containers
* Volumes
* Logs
* User files

This is intentional.

Always review disk usage before performing cleanup operations.

## 3. Linux Port Check

Use this script when an application cannot start because a port may already be occupied.

Run:

./scripts/port-check.sh 3000

Other examples:

./scripts/port-check.sh 80

./scripts/port-check.sh 443

./scripts/port-check.sh 8080

The script checks:

* TCP listening services
* TCP connections using the specified port
* Docker container port mappings

This can be useful when an application reports:

Address already in use

or:

EADDRINUSE

## Recommended Troubleshooting Workflow

When a Docker application is not working, a simple first-pass workflow is:

1. Check Docker
2. Check containers
3. Check disk space
4. Check the required port
5. Inspect application logs

For example:

./scripts/docker-check.sh

Then:

./scripts/disk-check.sh

Then:

./scripts/port-check.sh 3000

Replace `3000` with the port used by your application.

## Safety

These scripts are primarily diagnostic.

They are designed to inspect the system rather than automatically modify it.

They do not intentionally:

* Delete Docker containers
* Delete Docker images
* Delete Docker volumes
* Restart applications
* Modify firewall rules
* Change file permissions
* Modify system configuration

Always review commands before running them on production systems.

## Contributing

Issues and pull requests are welcome.

If you find a bug or have an idea for another useful diagnostic check, feel free to open an issue.

Possible future additions include:

* Docker log inspection
* Nginx configuration checks
* SSL certificate checks
* Memory usage checks
* CPU load checks
* Docker Compose diagnostics
* Basic web service health checks

## Disclaimer

This project is provided for troubleshooting and educational purposes.

System administration commands can behave differently across Linux distributions and environments.

Always review diagnostic output and understand commands before using them on production systems.

## License

MIT License.
