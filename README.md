# Linux & Docker Troubleshooting Toolkit

A small collection of practical shell scripts for diagnosing common Linux and Docker server problems.

This project provides simple, read-only diagnostic tools that help identify common issues with Docker, disk usage, ports, and Linux server environments.

The goal is to make basic server troubleshooting easier for developers, website owners, and Linux beginners.

## Features

* Check Docker installation and daemon accessibility
* Check Docker socket and user permissions
* Check Docker container status
* Check filesystem and inode usage
* Check Docker disk usage
* Check large directories under `/var`
* Check whether a TCP port is in use
* Check Docker container port mappings
* Simple command-line interface
* Read-only diagnostics
* No automatic destructive cleanup
* No automatic system configuration changes

## Project Structure

```text
linux-docker-troubleshooting-toolkit/
├── README.md
├── LICENSE
├── scripts/
│   ├── docker-check.sh
│   ├── disk-check.sh
│   └── port-check.sh
└── examples/
    └── .gitkeep
```

## Requirements

The scripts are designed for common Linux environments.

Recommended environment:

* Linux
* Bash
* Docker for Docker-related checks
* `systemctl` where available
* `ss` or `netstat` for port inspection

Some commands may require `sudo` to display complete system information.

## Installation

Clone the repository:

```bash
git clone https://github.com/qiqin2017/linux-docker-troubleshooting-toolkit.git
```

Enter the project directory:

```bash
cd linux-docker-troubleshooting-toolkit
```

Make the scripts executable:

```bash
chmod +x scripts/*.sh
```

You can then run the scripts directly.

---

# 1. Docker Environment Check

Use this script when Docker commands are failing or you want to quickly inspect the Docker environment.

Run:

```bash
./scripts/docker-check.sh
```

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

```text
permission denied while trying to connect to the Docker daemon socket
```

the script can help you inspect:

* Docker socket permissions
* Current user
* Docker group membership
* Docker daemon accessibility

The script does not automatically change permissions.

---

# 2. Linux Disk Check

Use this script when a server is running out of storage or Docker applications unexpectedly stop working.

Run:

```bash
./scripts/disk-check.sh
```

The script checks:

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

---

# 3. Linux Port Check

Use this script when an application cannot start because a port may already be occupied.

Run:

```bash
./scripts/port-check.sh 3000
```

Other examples:

```bash
./scripts/port-check.sh 80
```

```bash
./scripts/port-check.sh 443
```

```bash
./scripts/port-check.sh 8080
```

The script checks:

* TCP listening services
* TCP connections using the specified port
* Docker container port mappings

This can be useful when an application reports:

```text
Address already in use
```

or:

```text
EADDRINUSE
```

---

# Recommended Troubleshooting Workflow

When a Docker application is not working, a simple first-pass workflow is:

```text
1. Check Docker
       |
       v
2. Check containers
       |
       v
3. Check disk space
       |
       v
4. Check the required port
       |
       v
5. Inspect application logs
```

For example:

```bash
./scripts/docker-check.sh
```

Then:

```bash
./scripts/disk-check.sh
```

Then:

```bash
./scripts/port-check.sh 3000
```

Replace `3000` with the port used by your application.

---

# Safety

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

Always review commands before using them on production systems.

---

# Related Linux, Docker and Server Resources

This toolkit is part of a broader collection of practical technical resources covering Linux servers, Docker, AI tools, and developer workflows.

### Server & Docker Guides

[Press.Yueke.Cloud](https://press.yueke.cloud/)

Practical Linux server, Docker, deployment, and server troubleshooting guides.

### AI Tools & Troubleshooting

[AI.Yueke.Cloud](https://ai.yueke.cloud/)

AI tools, AI software guides, troubleshooting, and practical AI workflows.

### Side Hustle & Developer Guides

[Work.Yueke.Cloud](https://work.yueke.cloud/)

Practical side-hustle tutorials, developer resources, and online project ideas.

### International How-To Resources

[EasyHowly](https://easyhowly.com/)

English-language how-to guides covering technology, software, Linux, Docker, and practical online tools.

---

# Contributing

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
* Web server health checks

---

# Disclaimer

This project is provided for troubleshooting and educational purposes.

System administration commands can behave differently across Linux distributions and environments.

Always review diagnostic output and understand commands before using them on production systems.

The authors are not responsible for damage caused by improper use of system administration commands.

---

# License

MIT License.
