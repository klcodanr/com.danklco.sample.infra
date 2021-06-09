[![Deploy](https://github.com/klcodanr/com.danklco.sample.infra/actions/workflows/deploy.yml/badge.svg)](https://github.com/klcodanr/com.danklco.sample.infra/actions/workflows/deploy.yml)

# Sling CMS Infrastructure

This project is used to manage the infrastructure for a Sling CMS standalone instance running as a Docker service.

There are four main components:

 - feature - builds the Sling OSGi Feature Model for the web application
 - images - builds the Docker images for running the website
 - compose - the Docker Compose configuration for running this website
 - server - utilities and scripts to setup the host server

The build process is executed by the GitHub Actions script [deploy.yaml](blob/main/.github/workflows/deploy.yml) which executes each step in order to deploy updates on request or push to `main`.
 
## Setup

To set up this service, you must configure the following:

### Github Secrets

Create the following [Github secrets](https://docs.github.com/en/actions/reference/encrypted-secrets):

 - GH_PAT - a Github [Personal Access Token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token), must have commit privileges
 - SSH_HOST - the hostname of the SSH server to deploy the images
 - SSH_USERNAME - the username to connect with
 - SSH_KEY - the ssh key to use to connect

### Github Actions Configrations

Update the Github Action YAML files:

 - Replace the following Environment variables:
    - GH_OWNER - the owner of the Github repository, e.g. github.com/[owner]
    - GROUP_ID - the group id (maven coordionate), used to generate the ID's for the docker containers and Maven repositories
    - ARTIFACT_ID - the artifact id for this project, for example ${GROUP_ID}.infra
 - Update the maven-settings-action servers array to add any additional Maven repositries from which to retrieve artifacts

### Customize Feature

 - Add shared configurations, dependencies or RepoInit scripts in `feature/src/main/features/config.json`
 - Add any additional features to the custom aggregate in `feature/pom.xml`
 - Add a version property for each additional features `feature/versions.properties`

### Configure Apache httpd

Update the Apache httpd config files at `images/web/conf.d` and/or add custom config files for your application.

### Update Docker Compose

Set the `IMAGE_NAME_BASE` variable in `compose/.env` to the same pattern created by the image name.

### Setup Server

 - Use the `server/setup.sh` script as a guide to configure the server for hosting the Docker containers.
 - Set any secrets to pass to the containers, specifically:
    - cms-creds - a feature model JSON with the secret configuration values
    - cms-passwd - a password file for Sling Commons Crypto
    - web-cert - the certificate for SSL support in Apache httpd
    - web-chain - the certificate chain for SSL support in Apache httpd 
    - web-private - the certificate private file for SSL support in Apache httpd

