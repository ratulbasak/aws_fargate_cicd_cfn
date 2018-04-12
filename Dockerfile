FROM microsoft/dotnet:latest

RUN \
  apt-get update && \
  #add-apt-repository -y ppa:nginx/stable && \
  #apt-get update && \
  apt-get install -y nginx && \
  chown -R www-data:www-data /var/lib/nginx

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

COPY . /app

# Set the working directory as "app" directory
WORKDIR /app

# Run the following commands in Linux Terminal to restore .NET Core packages
#RUN ["dotnet", "restore"]
RUN dotnet restore

# Build the application
RUN dotnet publish -c Release -o out /app

RUN ls /app/
RUN ls /app/WebApplication1/bin/Release/netcoreapp2.0/


# Expose a port number from the container to outside world
ENV port=5000
ENV ASPNETCORE_URLS=http://+:$port

EXPOSE 80

#ENTRYPOINT ASPNETCORE_URLS='http://*:'$port dotnet /app/WebApplication1/bin/Release/netcoreapp2.0/WebApplication1.dll

#CMD ["/usr/bin/dotnet", "NotebookAppApi.dll"]

RUN update-rc.d nginx defaults
CMD ["sh", "/app/startup.sh"]
