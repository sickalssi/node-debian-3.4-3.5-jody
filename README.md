
## Here we are building our own Debian image from scratch, installing the required binaries into it and containerizing it. 

### 1.  Building the Debian image

Run a base debian image and run the container and since there is no services running within this container we run it with 'sleep 99999' to prevent it from closing upon creation
``` sh
docker build . -t debian:bookworm
docker run -d debian:bookworm sleep 99999
```

Get into the container with shell 
```bash
docker exec -it <container_id> sh
```

We want to have 'ping' and 'curl' to be installed on this Debian mage so we install them as they are not included.

``` bash
apt update
apt install -y curl
apt install -y iputils-ping
curl --version
ping --version
```
### 2. Building the Dockerfile
### 3. Introducing the environment variables

Within index.js, we will replace msg variable with:
``` js
const msg = `Hello from ${ENV} environment`;
```

and replace the ENV variable with:
``` js
const ENV = process.env.APP_ENVIRONMENT || 'production';
```

Now we can rebuild the image. 

---

## Uploading to AWS Elastic Container Registry 

1. Through the AWS Console > ECR > 'Create a Repository/get started'
2. Create a private repository, name it, leaving other settings as default 
3. Take the following steps to authenticate and push image to your ECR repository:

- Retrieve an authentication token and authenticate your Docker client to your registry.

```
aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin <CHANGE ME>
```

- Build your Docker image using the following command.

```
docker build -t <YOUR IMAGE NAME>
```

- After the build completes, tag your image so you can push the image to this repository
-
```
docker tag <YOUR LOCAL IMAGE NAME>:<YOUR LOCAL TAG> <YOUR ECR URI>:<YOUR TAG IN ECR>
```

- Run the following command to push this image to your newly created AWS repository:

```
docker push <YOUR ECR URI>:<YOUR TAG IN ECR>
```