
if ($args.Count -gt 3) {
  $SSCBaseURL = $args[0]
  $token = $args[1]
  $AppName = $args[2]
  $AppVersion = $args[3]

  $exportids = .\listGeneratedExports.ps1 $SSCBaseURL $token $AppName $AppVersion
  $exportids
  ForEach ( $exportId in $exportids) {
    $params = @{
      Uri     = "$SSCBaseURL/api/v1/dataExports/$exportId"
      Headers = @{ 'Authorization' = "FortifyToken $token" }
      Method  = 'DELETE'
    }

  
    $found = -1
    $results = Invoke-RestMethod @params
    $results
  }
 
}
Else {

  "Usage: getApplicationId.ps1 <SSC Base URL> <SSC REST API Token> <Application Name> <Application Version> "
}