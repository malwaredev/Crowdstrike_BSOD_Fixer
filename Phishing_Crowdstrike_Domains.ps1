# Ensure the script runs with appropriate execution policy
$currentPolicy = Get-ExecutionPolicy
if ($currentPolicy -ne 'Unrestricted' -and $currentPolicy -ne 'Bypass') {
    Write-Host "Setting execution policy to RemoteSigned for this session."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force
}

# List of malicious CrowdStrike domains
$domains = @(
    "crowdstrike.phpartners.org",
    "crowdstrike0day.com",
    "crowdstrikebluescreen.com",
    "crowdstrike-bsod.com",
    "crowdstrikeupdate.com",
    "crowdstrikebsod.com",
    "www.crowdstrike0day.com",
    "www.fix-crowdstrike-bsod.com",
    "crowdstrikeoutage.info",
    "www.microsoftcrowdstrike.com",
    "crowdstrikeodayl.com",
    "crowdstrike.buzz",
    "www.crowdstriketoken.com",
    "www.crowdstrikefix.com",
    "fix-crowdstrike-apocalypse.com",
    "microsoftcrowdstrike.com",
    "crowdstrikedoomsday.com",
    "crowdstrikedown.com",
    "whatiscrowdstrike.com",
    "crowdstrike-helpdesk.com",
    "crowdstrikefix.zip",
    "crowdstrike-scam.com",
    "crowdstrike-support.com",
    "crowdstrike-portal.com",
    "crowdstrike-verify.com",
    "crowdstrike-login.com",
    "crowdstrike-service.com",
    "crowdstrike-alert.com",
    "crowdstrike-technicalsupport.com",
    "crowdstrike-update.com",
    "crowdstrike-security.com",
    "crowdstrike-notice.com",
    "crowdstrike-claims.com",
    "crowdstrike-incident.com",
    "crowdstrike-customer.com",
    "crowdstrike-accounts.com",
    "crowdstrikeinfo.com",
    "crowdstrikesupport.com",
    "crowdstrikehelp.com",
    "crowdstrikeinfo.net",
    "crowdstrikeupdates.com",
    "crowdstrike-verify.net",
    "crowdstrike-portal.net",
    "crowdstrike-login.net",
    "crowdstrike-support.net",
    "crowdstrike-notice.net",
    "crowdstrike-claims.net",
    "crowdstrike-incident.net",
    "crowdstrike-customer.net",
    "secure-crowdstrike.com",
    "secure-crowdstrike.net",
    "crowdstrike-login.org",
    "crowdstrike-support.org",
    "crowdstrike-portal.org",
    "crowdstrike-update.org",
    "crowdstrike-alert.org",
    "crowdstrike-technicalsupport.org",
    "crowdstrike-notice.org",
    "crowdstrike-claims.org",
    "crowdstrike-incident.org",
    "crowdstrike-customer.org",
    "crowdstrike-accounts.org",
    "crowdstrike-safety.com",
    "crowdstrike-security.net",
    "crowdstrike-info.com",
    "crowdstrike-verify.org",
    "crowdstrike-portal.info",
    "crowdstrike-support.info",
    "crowdstrike-help.org",
    "crowdstrike-claims.info",
    "crowdstrike-incident.info",
    "crowdstrike-customer.info",
    "crowdstrike-scam.org",
    "crowdstrike-update.us",
    "crowdstrike-technicalsupport.us",
    "crowdstrike-notice.us",
    "crowdstrike-claims.us",
    "crowdstrike-incident.us",
    "crowdstrike-customer.us",
    "crowdstrike-accounts.us",
    "crowdstrike-safety.net",
    "crowdstrike-security.org",
    "crowdstrike-info.net",
    "crowdstrike-verify.us",
    "crowdstrike-portal.xyz",
    "crowdstrike-support.xyz",
    "crowdstrike-help.xyz",
    "crowdstrike-claims.xyz",
    "crowdstrike-incident.xyz",
    "crowdstrike-customer.xyz",
    "crowdstrike-scam.xyz",
    "crowdstrike-update.xyz",
    "crowdstrike-technicalsupport.xyz",
    "crowdstrikefake.com",
    "crowdstrikealerts.com",
    "crowdstrike-loginpage.com",
    "crowdstrike-verifyme.com",
    "crowdstrike-secure.com",
    "crowdstrike-supportteam.com",
    "crowdstrike-technical.com",
    "crowdstrike-customer-support.com",
    "crowdstrike-service.org",
    "crowdstrike-claims-support.com",
    "crowdstrike-incident-report.com",
    "crowdstrike-accounts-support.com",
    "crowdstrike-safety.org",
    "crowdstrike-securityteam.com",
    "crowdstrike-info.org",
    "crowdstrike-verifyonline.com",
    "crowdstrike-portalsecure.com",
    "crowdstrike-supportonline.com",
    "crowdstrike-helpdesk.org",
    "crowdstrike-claims-online.com",
    "crowdstrike-incident-report.org",
    "crowdstrike-customer-service.com",
    # Additional domains that may be relevant
    "crowdstrike-supports.com",
    "crowdstrike-notifications.com",
    "crowdstrike-portalsecure.com",
    "crowdstrike-verifysecure.com",
    "crowdstrike-safetycheck.com",
    "crowdstrike-technicalsupport.net",
    "crowdstrike-helpdesk.net",
    "crowdstrike-customerhelp.com",
    "crowdstrike-claimshelp.com",
    "crowdstrike-incidenthelp.com",
    "crowdstrike-accountsupport.com",
    "crowdstrike-safetycheck.org",
    "crowdstrike-securitycheck.com",
    "crowdstrike-verifycheck.com",
    "crowdstrike-supportcheck.com",
    "crowdstrike-portalcheck.com",
    "crowdstrike-notificationcheck.com"
)

# Path to the hosts file
$hostsFilePath = "C:\Windows\System32\drivers\etc\hosts"

# Backup the hosts file
Copy-Item -Path $hostsFilePath -Destination "$hostsFilePath.bak" -Force

# Block domains by adding them to the hosts file
foreach ($domain in $domains) {
    $entry = "127.0.0.1 $domain"
    if (-not (Get-Content $hostsFilePath | Select-String -Pattern [regex]::Escape($domain))) {
        Add-Content -Path $hostsFilePath -Value $entry
        Write-Host "Blocked domain: $domain"
    } else {
        Write-Host "Domain already blocked: $domain"
    }
}

Write-Host "Malicious domains have been blocked."
