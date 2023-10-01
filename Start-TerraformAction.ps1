[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)][ValidateSet("plan", "apply", "destroy")][String]$TerraformAction,    
    [Parameter(Mandatory = $false)][String]$TranscriptName
)
BEGIN {
    # Sets the Transcript Name if t
    if ([string]::IsNullOrEmpty($TranscriptName)) {
        $TranscriptName = "Start-TerraformAction.$(Get-Date -Format "MM-dd-yyyy").log"
    }
    # Stop-Transcript -ErrorAction SilentlyContinue
    Start-Transcript -Path ./$TranscriptName -Append
    Push-Location $PSScriptRoot

    $tfPlanName = "mealie-swag.plan"
}
PROCESS {
    switch ($TerraformAction) {
        "plan" {
            terraform init
            terraform plan -var-file="variables.tfvars" -out "$tfPlanName"
            (terraform output) | Out-File -Append -Path $TranscriptName
        }

        "apply" {
            terraform plan -var-file="variables.tfvars" -out "$tfPlanName"
            terraform apply "$tfPlanName"
            (terraform output) | Out-File -Append -Path $TranscriptName
            # terraform -chdir="$ProjectDirectory" plan -var-file="$ProjectVarFilename" -out "$ProjectName.plan"
        }
        "destroy" {
            terraform destroy -var-file="variables.tfvars" -auto-approve
        }
        

    }
}
END {
    Stop-Transcript
    Pop-Location
}



