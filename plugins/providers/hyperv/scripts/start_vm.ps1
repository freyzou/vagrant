#Requires -Modules VagrantMessages

param (
    [parameter (Mandatory=$true)]
    [string]$VmId
)

$ErrorActionPreference = "Stop"

try {
    $vm = Hyper-V\Get-VM -Id $VmId
    Hyper-V\Start-VM $vm
    $state = $vm.state
    $status = $vm.status
    $name = $vm.name
    $resultHash = @{
        state = "$state"
        status = "$status"
        name = "$name"
    }
    $result = ConvertTo-Json $resultHash
    Write-Output-Message $result
} catch {
    Write-Error-Message "Failed to start VM ${PSItem}"
    exit 1
}
