function Get-ToDoTxt {
    <#
        .SYNOPSIS
            Gets a ToDo.txt formatted File's Contents and converts it to a PowerShell Object
        .DESCRIPTION
            Converts ToDo.txt formatting to a PowerShell Object with the aim of producing an Object that can be rendered out to a usable ToDo.txt File
        .PARAMETER ToDoTxt
            Path to the ToDo.txt formatted File
        .EXAMPLE
            Get-ToDoTxt 'C:\Temp\ToDo.txt'
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]$ToDoTxt
    ) 
    BEGIN { 
        $ToDotxtContent = Get-Content $ToDoTxt
        $ToDotxtFormatted = @()
    } #BEGIN

    PROCESS {
        $Completed = $NULL
        $CompletionDate = $NULL
        $StartDate = $NULL
        $ProjectTags = $NULL
        $ContextTags = $NULL
        $Priority = $NULL
        $ToDo = $NULL

        foreach ($ToDo in $ToDotxtContent) {
            #Project Tags
            $ProjectTagMatch = $ToDo | Select-String -Pattern "\+([^\s]+)" -AllMatches
            $ProjectTags = $ProjectTagMatch.matches.value

            foreach ($ProjectTag in $ProjectTags) {
                $ToDo = $ToDo.replace($ProjectTag, '')
            }

            # Context Tags
            $ContextTagMatch = $ToDo | Select-String -Pattern "\@([^\s]+)" -AllMatches
            $ContextTags = $ContextTagMatch.matches.value

            foreach ($ContextTag in $ContextTags) {
                $ToDo = $ToDo.replace($ContextTag, '')
            }

            # Priority
            $PriorityMatch = $ToDo | Select-String -Pattern "^\(([^\s]+)"
            $Priority = $PriorityMatch.matches.value

            if ($NULL -ne $Priority) {
                $ToDo = $ToDo.replace($Priority, '')
                $Priority = $Priority.ToUpper()
            }
            
            #Completion Status
            $CompletedMatch = $ToDo | Select-String -Pattern "^[x]" -CaseSensitive
            $Completed = $CompletedMatch.matches.value
            if ($NULL -ne $Completed) {
                $ToDo = $ToDo.replace($Completed, '')
            }


            # Completion and Creation Date
            $DateMatch = $ToDo | Select-String -Pattern "([\d]+)([\-])([\d]+)([\-])([\d]+)[^\w\:]" -AllMatches
            $Dates = $DateMatch.matches.value
            foreach ($Date in $Dates) {
                $ToDo = $ToDo.replace($Date, '')
            }

            ## Completion Date and Creation Date Specified
            if (($Dates.count -gt '1') -and ($Completed -eq 'x')) {
                $CompletionDate = $Dates[0]
                $StartDate = $Dates[1]
            }

            ## Creation Date Only
            if (($Dates.count -eq '1') -and ($Completed -ne 'x')) {
                $StartDate = $Dates
            }
            $Dates = $NULL

            # Trim excess White Space
            $ToDo = $ToDo.Trim()

            $Row = New-Object PSObject
            $Row | Add-Member -MemberType noteproperty -Name "Completed" -Value $Completed
            $Row | Add-Member -MemberType noteproperty -Name "CompletionDate" -Value $CompletionDate
            $Row | Add-Member -MemberType noteproperty -Name "StartDate" -Value $StartDate 
            $Row | Add-Member -MemberType noteproperty -Name "ProjectTags" -Value $ProjectTags
            $Row | Add-Member -MemberType noteproperty -Name "ContextTags" -Value $ContextTags
            $Row | Add-Member -MemberType noteproperty -Name "Priority" -Value $Priority
            $Row | Add-Member -MemberType noteproperty -Name "ToDo" -Value $ToDo
            $ToDotxtFormatted += $Row


            $Completed = $NULL
            $CompletionDate = $NULL
            $StartDate = $NULL
            $ProjectTags = $NULL
            $ContextTags = $NULL
            $Priority = $NULL
            $ToDo = $NULL
        }
    } #PROCESS

    END { 
        $ToDotxtFormatted
    } #END

} #FUNCTION