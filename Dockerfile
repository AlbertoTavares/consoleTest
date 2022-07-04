FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

WORKDIR /usr/src/app

RUN dotnet restore

RUN dotnet build --no-restore

EXPOSE 5000

CMD ["dotnet" , "run" , "./bin/Debug/netcoreapp3.1/consoletest"]
