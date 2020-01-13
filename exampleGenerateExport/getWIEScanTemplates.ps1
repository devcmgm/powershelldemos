
if ($args.Count -gt 3) {
  $WIEBaseURL = $args[0]
  $token = $args[1]
  $AppName = $args[2]
  $AppVersion = $args[3]

  $params = @{
    Uri     = "$WIEBaseURL/api/v1/scanTemplates"
    Headers = @{ 'Authorization' = "FortifyToken $token" }
    Method  = 'GET'
  }

  
  $found = "-1"

  $scanTemplateID = ""
  $projectName = ""
  $projectVersion = ""

  $results = Invoke-RestMethod @params
  ForEach ($version in $results.data) {

     $scanTemplateID = $version[0].id
     $projectName = $version[0].project.name
     $projectVersion = $version[0].projectVersion.name
    # "Debug Project: ({0}) - Version: ({1})!" -f $projectName, $projectVersion
    if (  $projectName -eq $AppName -and $projectVersion -eq $AppVersion  ) {
      $found = $scanTemplateID
    }
    
  }
# $found
  if ( $found -eq "-1" ) {
    "Info: Application: ({0}) - Version: ({1}) Not Found !" -f $AppName, $AppVersion
  } Else {
    $found
  }
}
Else {

  "Usage: getApplicationId.ps1 <SSC Base URL> <SSC REST API Token> <Application Name> <Application Version> "
}