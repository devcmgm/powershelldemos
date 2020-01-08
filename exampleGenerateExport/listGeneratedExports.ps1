
if ($args.Count -gt 3) {
  $SCCBaseURL = $args[0]
  $token = $args[1]
  $AppName = $args[2]
  $AppVersion = $args[3]

  $projectVersion = .\getPRojects.ps1 $SCCBaseURL ZjgwMzAxZjEtYzhjYi00YmNiLWI5ZmEtNmExMmM0NmYzZWVj $AppName $AppVersion

  #"" DEBUG" $projectVersion

  $Uri = "$SCCBaseURL/api/v1/dataExports?start=0&limit=200"
  # "DEBUG: $Uri"
  
  $params = @{
    Uri     = $Uri
    Headers = @{ 'Authorization' = "FortifyToken $token" }
    Method  = 'GET'
  }

  $results = Invoke-RestMethod @params
  # "DEBUG: $results.data"
  # "DEBUG: --------------------------------------------------"
  ForEach ($export in $results.data) {
    "{0}" -f  $export.id
  }

}
Else {

  "Usage: listSSCExports.ps1 <SSC Base URL> <SSC REST API Token> <Application Name> <Application Version>"

}