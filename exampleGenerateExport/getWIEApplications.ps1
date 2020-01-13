
if ($args.Count -gt 3) {
  $WIEBaseURL = $args[0]
  $token = $args[1]
  $AppName = $args[2]
  $AppVersion = $args[3]

  $params = @{
    Uri     = "$WIEBaseURL/api/v1/projectVersions"
    Headers = @{ 'Authorization' = "FortifyToken $token" }
    Method  = 'GET'
  }

  
  $found = "-1"

  $scanTemplateID = ""
  $projectName = ""
  $projectVersion = ""

  $results = Invoke-RestMethod @params
  ForEach ($version in $results.data) {

     $projectId = $version[0].id
     $projectName = $version[0].project.name
     $projectVersion = $version[0].name
     "Debug Id:({0}) - Project: ({1}) - Version: ({2})!" -f $projectId, $projectName, $projectVersion
    
  }

  
}
Else {

  "Usage: getApplicationId.ps1 <SSC Base URL> <SSC REST API Token> <Application Name> <Application Version> "
}