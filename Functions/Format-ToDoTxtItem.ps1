function Format-ToDoTxtItem {
    <#
        .SYNOPSIS
            Formats an array, or signle item, created using New-ToDoTxtItem
        .DESCRIPTION
            Uses the fiels provided by New-ToDoTxtItem to create a String for each ToDo Item
        .PARAMETER ToDoTxtItems
            Items formatted with New-ToDoTxtItem
        .EXAMPLE
            Format-ToDoTxtItem -ToDoTxtItems (New-ToDoTxtItem -ToDo "This is a Test" -StartDate (Get-Date -Format yyyy-MM-dd) -Completed 'x' -CompletionDate (Get-Date ((Get-Date).AddDays(-6)) -Format yyyy-MM-dd) -ProjectTags '+Tag','+Tag2' -ContextTags '@Tag','@Tag2' -Priority '(A)')
        .EXAMPLE
            $Array = @()
            $Array += (New-ToDoTxtItem -ToDo "This is a Test" -StartDate (Get-Date -Format yyyy-MM-dd) -Completed 'x' -CompletionDate (Get-Date ((Get-Date).AddDays(-6)) -Format yyyy-MM-dd) -ProjectTags '+Tag','+Tag2' -ContextTags '@Tag','@Tag2' -Priority '(A)')
            $Array += (New-ToDoTxtItem -ToDo "This is a Test as well" -StartDate (Get-Date -Format yyyy-MM-dd) -Completed 'x' -CompletionDate (Get-Date ((Get-Date).AddDays(-6)) -Format yyyy-MM-dd) -ProjectTags '+Tag','+Tag2' -ContextTags '@Tag','@Tag2' -Priority '(A)')
            Format-ToDoTxtItem -ToDoTxtItems $Array
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]$ToDoTxtItems
    ) 
    BEGIN { 
        $ToDoTxtItemsFormatted = @()
    } #BEGIN

    PROCESS {
        foreach ($ToDoTxtItem in $ToDoTxtItems) {
            if ($NULL -ne $ToDoTxtItem.completed){
                $ToDoTxtItemFormatted = ($ToDoTxtItem.Completed).Trim()
            }
            if ($NULL -ne $ToDoTxtItem.Priority) {
                $ToDoTxtItemFormatted = ($ToDoTxtItemFormatted + " " + $ToDoTxtItem.Priority).Trim()
            }
            
            if ($NULL -ne $ToDoTxtItem.CompletionDate) {
                $ToDoTxtItemFormatted = ($ToDoTxtItemFormatted + " " + $ToDoTxtItem.CompletionDate).Trim()
            }
            if ($NULL -ne $ToDoTxtItem.StartDate) {
                $ToDoTxtItemFormatted = ($ToDoTxtItemFormatted + " " + $ToDoTxtItem.StartDate).Trim()
            }
            $ToDoTxtItemFormatted = ($ToDoTxtItemFormatted + " " + $ToDoTxtItem.ToDo).Trim()
            if ($NULL -ne $ToDoTxtItem.ProjectTags) {
                $ToDoTxtItemFormatted = ($ToDoTxtItemFormatted + " " + $ToDoTxtItem.ProjectTags).Trim()
            }
            if ($NULL -ne $ToDoTxtItem.ContextTags) {
                $ToDoTxtItemFormatted = ($ToDoTxtItemFormatted + " " + $ToDoTxtItem.ContextTags).Trim()
            }

                        $ToDoTxtItemsFormatted += $ToDoTxtItemFormatted
            $ToDoTxtItemFormatted = $Null
        }
    } #PROCESS
    END { 
        $ToDoTxtItemsFormatted
    } #END
} #FUNCTION