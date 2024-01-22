FROM debian:bookworm

# install app dependencies 'ping' & 'curl'
RUN apt update && apt install -y\ 
    curl\
    iputils-ping

# install node
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - &&\
    apt install -y nodejs
WORKDIR /app

# install app, copy explicitly what you need
COPY index.js package-lock.json package.json /app 
RUN npm install

# Configuration to specify which port the container listers to at runtime
EXPOSE 8080

# when the container runs it will run "node index.js"
CMD ["node", "index.js"] 






