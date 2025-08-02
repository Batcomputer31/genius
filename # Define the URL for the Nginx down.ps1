# Define the URL for the Nginx download
$nginxUrl = "http://nginx.org/download/nginx-1.25.2.zip"
$destinationPath = "C:\nginx"

# Create the destination folder
New-Item -ItemType Directory -Path $destinationPath -Force

# Download the Nginx zip file
Invoke-WebRequest -Uri $nginxUrl -OutFile "$destinationPath\nginx.zip"

# Extract the zip file
Expand-Archive -Path "$destinationPath\nginx.zip" -DestinationPath $destinationPath -Force

# Clean up the zip file
Remove-Item "$destinationPath\nginx.zip"

# Navigate to the Nginx folder
Set-Location "$destinationPath\nginx-1.25.2"

# Start Nginx
Start-Process -FilePath ".\nginx.exe"

# Stop Nginx gracefully
Start-Process -FilePath ".\nginx.exe" -ArgumentList "-s stop"

# Path to the Nginx configuration file
$configPath = "$destinationPath\nginx-1.25.2\conf\nginx.conf"

# Example: Add a new server block
Add-Content -Path $configPath -Value @"
server {
    listen       8080;
    server_name  localhost;

    location / {
        root   html;
        index  index.html index.htm;
    }
}
"@
