# PSToDo
PowerShell Implementation of ToDo.Txt Management


# Get-ToDoTxt
Used to gather a list of ToDo Items from the ToDo.Txt File and process them as a PowerShell Object.

```PowerShell
Get-ToDoTxt "ToDo.txt"

# Outputs the following
Completed      : x
CompletionDate : 2021-04-04
StartDate      : 2021-04-10
ProjectTags    : {+Tag, +Tag2}
ContextTags    : {@Tag, @Tag2}
Priority       :
ToDo           : (A) This is a Test

Completed      : x
CompletionDate : 2021-04-04
StartDate      : 2021-04-10
ProjectTags    : {+Tag, +Tag2}
ContextTags    : {@Tag, @Tag2}
Priority       :
ToDo           : (A) This is a Test as well
```

# Format-ToDoTxtItem
Formats New-ToDoTxtItem entries into a ToDo.Txt Entry that can be placed into a ToDo.txt File.

```PowerShell
$Array = @()
$Array += (New-ToDoTxtItem -ToDo "This is a Test" -StartDate (Get-Date -Format yyyy-MM-dd) -Completed 'x' -CompletionDate (Get-Date ((Get-Date).AddDays(-6)) -Format yyyy-MM-dd) -ProjectTags '+Tag','+Tag2' -ContextTags '@Tag','@Tag2' -Priority '(A)')
$Array += (New-ToDoTxtItem -ToDo "This is a Test as well" -StartDate (Get-Date -Format yyyy-MM-dd) -Completed 'x' -CompletionDate (Get-Date ((Get-Date).AddDays(-6)) -Format yyyy-MM-dd) -ProjectTags '+Tag','+Tag2' -ContextTags '@Tag','@Tag2' -Priority '(A)')
Format-ToDoTxtItem -ToDoTxtItems $Array

# Outputs the following
x (A) 2021-04-04 2021-04-10 This is a Test +Tag +Tag2 @Tag @Tag2
x (A) 2021-04-04 2021-04-10 This is a Test as well +Tag +Tag2 @Tag @Tag2
```






# New-ToDoTxtItem
Creates a New ToDo.txt PowerShell Object that can be processed with Format-ToDoTxtItem into something that can be placed into a ToDo.Txt formatted file.

```PowerShell
New-ToDoTxtItem -ToDo "This is a Test" -StartDate (Get-Date -Format yyyy-MM-dd) -Completed 'x' -CompletionDate (Get-Date ((Get-Date).AddDays(-6)) -Format yyyy-MM-dd) -ProjectTags '+Tag','+Tag2' -ContextTags '@Tag','@Tag2' -Priority '(A)'

# Outputs the following
Completed      : x
CompletionDate : 2021-04-04
StartDate      : 2021-04-10
ProjectTags    : {+Tag, +Tag2}
ContextTags    : {@Tag, @Tag2}
Priority       : (A)
ToDo           : This is a Test
```
