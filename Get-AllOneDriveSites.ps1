$AdminSiteURL="https://<TENANT-NAME>-admin.sharepoint.com"
 
#Get Credentials to connect to the SharePoint Admin Center
$Cred = Get-Credential
 
#Connect to SharePoint Online Admin Center
Connect-SPOService -Url $AdminSiteURL –credential $Cred
 
#Get all Personal Site collections and export to a Text file
$OneDriveSites = Get-SPOSite -Template "SPSPERS" -Limit ALL -includepersonalsite $True
 
$Result=@()
# Get storage quota of each site
Foreach($Site in $OneDriveSites)
{
    $Result += New-Object PSObject -property @{
    URL = $Site.URL
    Owner= $Site.Owner
    Size_inGB = $Site.StorageUsageCurrent/1024
    #Size_inMB = $Site.StorageUsageCurrent
    StorageQuota_inGB = $Site.StorageQuota/1024
    }
}
 
$Result | Format-Table
 
#Export the data to CSV
$Result | Export-Csv "E:\Temp\GulfTechGroup\OneDrive-Details.csv" -NoTypeInformation
