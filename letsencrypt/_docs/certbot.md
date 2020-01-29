# Certbot notes

## Overview

Notes on running certbot on Linux server to obtain certs for sites on other servers.
This is the so-call `manual` method (as compared to `standalone`)

## Install certbot on Linux

```bash
wget https://dl.eff.org/certbot-auto
sudo mv certbot-auto /usr/local/bin/certbot-auto
sudo chown root /usr/local/bin/certbot-auto
sudo chmod 0755 /usr/local/bin/certbot-auto
```

## CLI

This is the command-line for running certbot for standalone mode:

sudo /usr/local/bin/certbot-auto certonly --standalone

This is the command line for manual mode

sudo /usr/local/bin/certbot-auto certonly --manual


