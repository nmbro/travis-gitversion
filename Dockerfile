FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as builder  
WORKDIR /app

COPY . .
RUN dotnet publish -c Release -o published travis-gitversion.csproj

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 as publish

WORKDIR /var/app/
COPY --from=builder /app/published .
ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000/tcp
CMD ["dotnet", "./travis-gitversion.dll"]