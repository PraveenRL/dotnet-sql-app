# To build the application
FROM mcr.microsoft.com/dotnet/sdk:6.0 as build
WORKDIR /source

# Copy project file
COPY *.csproj ./
# Restore all the packages
RUN dotnet restore

# After restore we can again copy everything
COPY . .
# Publish - it will create new out folder inside source folder
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
# Copy artifacts from build stage
COPY --from=build /source/out .
EXPOSE 80
ENTRYPOINT ["dotnet", "sqlapp.dll"]