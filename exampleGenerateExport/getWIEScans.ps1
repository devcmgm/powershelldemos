
if ($args.Count -gt 1) {
  $WIEBaseURL = $args[0]
  $token = $args[1]
 

  $params = @{
    Uri     = "$WIEBaseURL/api/v1/scans"
    Headers = @{ 'Authorization' = "FortifyToken $token" }
    Method  = 'GET'
  }


  $results = Invoke-RestMethod @params
  ForEach ($scan in $results.data) {
    $scanId = $scan.id
    $scanType = $scan.scanEndTime
    $scanName = $scan.name
    $scanPolicy = $scan.scanStateText
    "Debug Id:({0}) - End Time: ({1}) - Name: ({2}) - Scan State: ({3}) !" -f $scanId, $scanType, $scanName , $scanPolicy
  }

 
}
Else {

  "Usage: getSmartUpdate.ps1 <SSC Base URL> <SSC REST API Token>  "
}