#  Copyright (c) Kiyan Yang. All rights reserved.
#  Licensed under the MIT License.
#  See LICENSE file in the project root for full license information.

param(
    [Parameter(HelpMessage = '输入含有缩写词的文本。')]
    [string]$Text = ''
)

$HhshGuessUrl = 'https://lab.magiconch.com/api/nbnhhsh/guess'

function Get-MatchString {
    param (
        [string]$Text
    )
    return ($Text | Select-String -Pattern '[a-z0-9]+' -AllMatches).Matches -join ','
}

function ConvertTo-Table {
    param (
        [PSCustomObject]$Content
    )
    $list = [System.Collections.Generic.List[PSCustomObject]]::new()
    foreach ($item in $Content) {
        $tmp = [PSCustomObject]@{
            '名称    ' = ''
            '翻译    ' = ''
        }
        $list.Add($tmp)
        $item.trans | ForEach-Object {
            $tmp = [PSCustomObject]@{
                '名称    ' = $item.name
                '翻译    ' = if ($_ -ne $null) { $_ } else { '暂未收录' }
            }
            $list.Add($tmp)
        }
    }
    if ($list.Count -gt 0) {
        $list.RemoveAt(0)
    }
    return $list
}

if ($Text -eq '') {
    $Text = Read-Host '输入含有缩写词的文本'
}

do {
    $Body = @{
        text = Get-MatchString $Text
    }
    if ($Body.text -ne '') {
        $Response = Invoke-WebRequest $HhshGuessUrl -Body $Body -Method 'POST'
        $Json = $Response.Content | ConvertFrom-Json
        $Table = ConvertTo-Table $Json
        $table | Format-Table
    }
    else {
        Write-Host "输入的文本「$Text」不包含缩写词。"
    }
    $Text = Read-Host '输入含有缩写词的文本 [回车则退出]'
} while ($Text -ne '')
