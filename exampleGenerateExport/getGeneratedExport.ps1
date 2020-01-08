


if ($args.Count -gt 3) {
    $SCCBaseURL = $args[0]
    $token = $args[1]
    $AppName = $args[2]
    $AppVersion = $args[3]

    $timestamp = Get-Date -Format o | ForEach-Object { $_ -replace ":", "." }
    $outputfilename = "SSCExport_$timestamp.csv" 

    $reportid = .\listGeneratedExports.ps1 $SCCBaseURL ZjgwMzAxZjEtYzhjYi00YmNiLWI5ZmEtNmExMmM0NmYzZWVj $AppName $AppVersion                        

    # "DEBUG $reportid"

    $jsonData = '{ "fileTokenType": "REPORT_FILE" }'  
   
    $sscapiurl = "$SCCBaseURL/api/v1/fileTokens"

    $sscapiurl

    $params = @{
        Uri         = $sscapiurl
        Headers     = @{ 'Authorization' = "FortifyToken $token" }
        Method      = 'POST'
        Body        = $jsonData
        ContentType = 'application/json'
    }

    $results = Invoke-RestMethod @params

    $row = $results.data | Select token

    $exporttoken = $row.token

    $ReportUri = "$SCCBaseURL/transfer/dataExportDownload.html?mat=$exporttoken&id=$reportId"
  
    # Debug - 
    $ReportUri

    $params = @{
        Uri         = $ReportUri
        Headers     = @{ 'Authorization' = "FortifyToken $token" }
        Method      = 'GET'
        ContentType = 'application/pdf'
    }

    Invoke-RestMethod @params -OutFile $outputfilename
    
}
Else {

    "Usage: getSSCGeneratedExport <SSC Base URL> <SSC REST API Token> <Application Name> <Application Version>"
}