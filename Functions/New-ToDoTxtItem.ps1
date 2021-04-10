function New-ToDoTxtItem {
    <#
        .SYNOPSIS
            Creates a new ToDo.Txt Item as a PowerShell Object
        .DESCRIPTION
            Creates a PSObject ToDo.Txt Item that can then be fed into Format-ToDoTxtItem in order to output to a Text File
        .PARAMETER Completed
            Completed notes whether task has been completed and is denoted by a lowercase x
        .PARAMETER CompletionDate
            Date Task was Completed as YYYY-MM-DD
        .PARAMETER StartDate
            Date Task was started as YYYY-MM-DD
        .PARAMETER ProjectTags
            Tags denoting the Project of the task. a Single word or array of words preceded by + Symbols
        .PARAMETER ContextTags
            Tags denoting the context of the task. a Single word or array of words preceded by @ Symbols
        .PARAMETER Priority
            Priority of the Task as represented by a Capital Letter in parentheses - (A)
        .PARAMETER ToDo
            The Only required Item. This is the actual todo list entry
        .EXAMPLE
            New-ToDoTxtItem -ToDo "This is a Test"
        .EXAMPLE
            New-ToDoTxtItem -ToDo "This is a Test" -StartDate (Get-Date -Format yyyy-MM-dd) -Completed 'x' -CompletionDate (Get-Date ((Get-Date).AddDays(-6)) -Format yyyy-MM-dd) -ProjectTags '+Tag','+Tag2' -ContextTags '@Tag','@Tag2' -Priority '(A)'
    #>
    [CmdletBinding()]
    Param(
        [Parameter()]$Completed,
        [Parameter()]$CompletionDate,
        [Parameter()]$StartDate,
        [Parameter()]$ProjectTags,
        [Parameter()]$ContextTags,
        [Parameter()]$Priority,
        [Parameter(Mandatory = $true)]$ToDo
    ) 
    BEGIN { 
        $ToDoItemObject = @()
    } #BEGIN

    PROCESS {
      
        $Row = New-Object PSObject
        $Row | Add-Member -MemberType noteproperty -Name "Completed" -Value $Completed
        $Row | Add-Member -MemberType noteproperty -Name "CompletionDate" -Value $CompletionDate
        $Row | Add-Member -MemberType noteproperty -Name "StartDate" -Value $StartDate 
        $Row | Add-Member -MemberType noteproperty -Name "ProjectTags" -Value $ProjectTags
        $Row | Add-Member -MemberType noteproperty -Name "ContextTags" -Value $ContextTags
        $Row | Add-Member -MemberType noteproperty -Name "Priority" -Value $Priority
        $Row | Add-Member -MemberType noteproperty -Name "ToDo" -Value $ToDo
        $ToDoItemObject += $Row

    } #PROCESS

    END { 
        $ToDoItemObject
    } #END

} #FUNCTION
