
if ($args.Count -gt 3) {
  $SSCBaseURL = $args[0]
  $token = $args[1]
  $AppName = $args[2]
  $AppVersion = $args[3]

  $params = @{
    Uri     = "$SSCBaseURL/api/v1/projectVersions?start=0&limit=200&fulltextsearch=false&includeInactive=false&myAssignedIssues=false&onlyIfHasIssues=false"
    Headers = @{ 'Authorization' = "FortifyToken $token" }
    Method  = 'GET'
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