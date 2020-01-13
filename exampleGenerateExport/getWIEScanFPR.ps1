
if ($args.Count -gt 2) {
  $WIEBaseURL = $args[0]
  $token = $args[1]
  $scanId = $args[2]
 

  $params = @{
    Uri     = "$WIEBaseURL/api/v1/scans/{$scanId}/export?type=FPR" 
    Headers = @{ 'Authorization' = "FortifyToken $token" }
    Method  = 'GET'
  }


  $results = Invoke-RestMethod @params -OutFile "WIEScan.fpr"
  
 
}
Else {

  "Usage: getWIEScanFPR.ps1 <SSC Base URL> <SSC REST API Token>  "
}