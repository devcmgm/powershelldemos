
if ($args.Count -gt 3) {
  $SSCBaseURL = $args[0]
  $token = $args[1]
  $AppName = $args[2]
  $AppVersion = $args[3]

  $projectVersionId = .\getPRojects.ps1 $SSCBaseURL ZjgwMzAxZjEtYzhjYi00YmNiLWI5ZmEtNmExMmM0NmYzZWVj $AppName $AppVersion

  #"" DEBUG" $projectVersion

  $Uri = "$SSCBaseURL/api/v1/dataExports?start=0&limit=200"
  # "DEBUG: $Uri"
  
  $params = @{
    Uri     = $Uri
    Headers = @{ 'Authorization' = "FortifyToken $token" }
    Method  = 'GET'
  }

  $results = Invoke-RestMethod @params
  # "DEBUG: $results.data"
  # "DEBUG: --------------------------------------------------"

  $checkname = "$AppName - $AppVersion"

  # DEBUG $checkname

  ForEach ($export in $results.data) {
    $checkname = "$AppName - $AppVersion"
    if ( $export.appVersionName -eq $checkname ) { 
      "{0}" -f  $export.id
      # DEBUG: $export.appVersionName
    }
  }

}
Else {

  "Usage: listSSCExports.ps1 <SSC Base URL> <SSC REST API Token> <Application Name> <Application Version>"

}