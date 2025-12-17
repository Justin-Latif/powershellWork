Set-StrictMode -Version Latest

$myList = New-Object -TypeName System.Collections.ArrayList


[void]$myList.add("1")
[void]$myList.add("2")

$myList.RemoveAt(1)
[void]$myList.Add("3")
[void]$myList.Add("4")

$myList.Remove("1")

$myList.AddRange(@("4","6"))

$myList

$array=@()
$arrayList = New-Object -TypeName System.Collections.ArrayList

Measure-Command -Expression {@(0..100000).ForEach({$array+=$_})}

Measure-Command -Expression {@(0..100000).ForEach({$arrayList.Add($_)})}

