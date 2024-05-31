# We use this stage to build/prepare the dotnet app
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-stage
WORKDIR /samzure
COPY . ./
RUN dotnet restore
RUN dotnet publish -c Release -o out

# We use this stage to serve the app
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /samzure
COPY --from=build-stage /samzure/out .
ENTRYPOINT ["dotnet", "samzure.dll"]