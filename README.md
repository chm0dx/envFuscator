## envFuscator  
  
![envFuscator](https://i.redd.it/iib2ote3l4d11.png)
  
#### Reconstructs command text by referencing env value character indexes. Can be run live and pull values directly from a host's env variables or alternatively by importing a csv file export of env variables from a target system.  
  
##### Parameter cmd  
Indicates the command being obfuscated.  
  
##### Parameter csvFile  
Optionally specifies a csv file to read env variables from.  
  
##### Example  
```powershell
.\envFuscator.ps1 -cmd Get-Service  
  
${env:ENV_PATH}[24] + ${env:PUBLIC}[5] + ${env:TOOLSEXT_PATH}[31] + ${env:Path}[255] + ${env:Path}[3] + ${env:CommonProgramFiles(x86)}[4] + ${env:ELGO_PATH_V11_0}[5] + ${env:Path}[13] + ${env:USERPROFILE}[5] + ${env:LOCALAPPDATA}[4] + ${env:USERNAME}[2]  
```
  
##### Example  
```powershell
.\envFuscator.ps1 -cmd Invoke-MimiDogz -csvFile C:\Data\env.csv  
  
${env:APP_PROFILE_STRING}[0] + ${env:DriverData}[5] + ${env:JRECOREROOT}[47] + ${env:IMGSOURCE}[5] + ${env:OBO_PATH}[42] + ${env:ChocolateyInstall}[23] + ${env:Path}[255] + ${env:PATHEXT}[3] + ${env:SetaBase}[12] + ${env:ChocolateyInstall}[9] + ${env:DABASAMPLES_ROOT}[30] + ${env:ChocolateyInstall}[10] + ${env:OneDrive}[12] + ${env:DABA_PATH}[6] + 'z'  

```
  
The resulting obfuscated output can be used to run commands on the target machine by wrapping with Invoke-Expression or a similar method.  
  
```powershell
iex ( ${env:APP_PROFILE_STRING}[0] + ${env:DriverData}[5] + ${env:JRECOREROOT}[47] + ${env:IMGSOURCE}[5] + ${env:OBO_PATH}[42] + ${env:ChocolateyInstall}[23] + ${env:Path}[255] + ${env:PATHEXT}[3] + ${env:SetaBase}[12] + ${env:ChocolateyInstall}[9] + ${env:DABASAMPLES_ROOT}[30] + ${env:ChocolateyInstall}[10] + ${env:OneDrive}[12] + ${env:DABA_PATH}[6] + 'z' )  
```
