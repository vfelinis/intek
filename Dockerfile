FROM microsoft/dotnet:latest

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y build-essential nodejs

# Create directory for the app source code
RUN mkdir -p /opt/intek/app
WORKDIR /opt/intek/app

# Copy the source and restore dependencies
COPY . /opt/intek/app
RUN npm install
RUN node node_modules/webpack/bin/webpack.js --config webpack.config.vendor.js --env.prod
RUN node node_modules/webpack/bin/webpack.js --env.prod
RUN ["dotnet", "restore"]
RUN ["dotnet", "build"]

# Expose the port and start the app
EXPOSE 5000/tcp
CMD ["dotnet", "run", "--server.urls", "http://*:5000"]