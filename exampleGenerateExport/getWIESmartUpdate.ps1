
if ($args.Count -gt 1) {
  $WIEBaseURL = $args[0]
  $token = $args[1]
 

  $params = @{
    Uri     = "$WIEBaseURL/api/v1/smartupdate"
    Headers = @{ 'Authorization' = "FortifyToken $token" }
    Method  = 'GET'
  }


  $results = Invoke-RestMethod @params
  ForEach ($version in $results.data) {
    "$version"
  }

  
}
Else {

  "Usage: getSmartUpdate.ps1 <SSC Base URL> <SSC REST API Token>  "
}