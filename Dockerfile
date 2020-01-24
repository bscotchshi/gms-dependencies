# escape=`

FROM mcr.microsoft.com/windows:1903

# Add rubber
# COPY C:\\WebProgramming\rubber-simplified C:\rubber-simplified

# Add vs install file
ADD AdminDeployment.xml C:\AdminDeployment.xml

# Add Chocolatey
RUN powershell Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Build Tools excluding workloads and components with known issues.
RUN choco install nodejs-lts -y
RUN choco install VisualStudio2015Community -packageParameters "--AdminFile c:\\AdminDeployment.xml" -y --execution-timeout=36000

# Default to PowerShell if no other command specified.
CMD ["powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass"]