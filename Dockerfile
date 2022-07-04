FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
ARG DIRECTORY

WORKDIR /usr/src/app


# To make use of caching, and therefore make builds faster we'll copy the .sln and .csproj files, then do a dotnet restore.
# Since we're likely to change the code more often than the packages we'll be able to reuse the cached layers,
# ie, no need to restore the packages again unless they change!
#COPY ./${DIRECTORY}/*.sln ./${DIRECTORY}/**/*.csproj ./


RUN for file in $(ls *.csproj); do mkdir -p ${file%.*}/ && mv $file ${file%.*}/; done
RUN dotnet restore

# Copy all the source code across
COPY ./${DIRECTORY}/. ./

RUN dotnet restore

RUN dotnet build --no-restore

EXPOSE 5000

CMD ["dotnet" , "run" , "./bin/Debug/netcoreapp3.1/consoletest"]
