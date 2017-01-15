FROM microsoft/dotnet:latest

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y build-essential nodejs

# Create directory for the app source code
RUN mkdir -p /opt/intek/app
WORKDIR /opt/intek/app

# Copy the source and restore dependencies
COPY . /opt/intek/app
RUN dotnet restore

# Expose the port and start the app
EXPOSE 5000
CMD [ "dotnet", "run" ]