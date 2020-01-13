
if ($args.Count -gt 3) {
  $WIEBaseURL = $args[0]
  $token = $args[1]
  $AppName = $args[2]
  $AppVersion = $args[3]

  $jsonData = '{ "fileTokenType": "REPORT_FILE" }'  

  $params = @{
    Uri     = "$WIEBaseURL/api/v1/scans"
    Headers = @{ 'Authorization' = "FortifyToken $token" }
    Method  = 'POST'
    Body        = $jsonData
    ContentType = 'application/json'
  }

  
  $found = -1
  $results = Invoke-RestMethod @params
  ForEach ($version in $results.data) {
    if (  $version.project.name -eq $AppName -and $version.name -eq $AppVersion ) {
      $found = $version.id
    }
    
  }
  if ( $found -eq "-1" ) {
    "Info: Application: ({0}) - Version: ({1}) Not Found !" -f $AppName, $AppVersion
  } Else {
    $found
  }
}
Else {

  "Usage: getApplicationId.ps1 <SSC Base URL> <SSC REST API Token> <Application Name> <Application Version> "
}