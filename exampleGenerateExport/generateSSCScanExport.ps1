

if ($args.Count -gt 3) {
    $SSCBaseURL = $args[0]
    $token = $args[1]
    $AppName = $args[2]
    $AppVersion = $args[3]
    
    $projectVersionId = .\getProjects.ps1 $SSCBaseURL $token $AppName $AppVersion


    $jsonData = @"
    { "type":"EXPORT_TO_CSV",
    "actionResponse":true,
    "values": { "datasetname": "Audit","appversionid":$projectVersionId,"start":0,"limit":-1,
                "filterset":"a243b195-0a59-3f8b-1403-d55b7a7d78e6","filename":"SSCExport.csv","note":"Generated Export"}
     }
     
"@


        $jsonData

    $params = @{
        Uri         = "$SSCBaseURL/api/v1/dataExports/action"
        Headers     = @{ 'Authorization' = "FortifyToken $token"; "Pragma"="no-cache"; "Accept"="application/json, text/plain, */*"; }
        Method      = 'POST'
        Body        = $jsonData
        ContentType = 'application/json'
    }

    $results = Invoke-RestMethod @params

    $results

} Else {

    "Usage: exportSSCScanData.ps1 <SSC REST API Token> <Project Version Id> "
}