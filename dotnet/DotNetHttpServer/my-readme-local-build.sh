# DATE: 20-October-2025
# Local Build and run

# NOTE: For local build in VS Code: open this folder (DotNetHttpServer)

# Asp.Net
# Create the app
app="DotNetHttpServer"
dotnet new webapp -n $app --framework net9.0
cd $app

# dotnet commands
dotnet clean
dotnet restore
dotnet build

## Creates folder bin/publish
dotnet publish

dotnet run

## Test
http://localhost:5087/health
http://localhost:5087/environment
http://localhost:5087/variables
http://localhost:5087/request

http://localhost:5087/postjson