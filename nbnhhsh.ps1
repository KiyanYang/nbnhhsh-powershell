param(
    [Parameter(HelpMessage = '输入缩写的内容，可以使用逗号隔开，例如：yyds,hhsh,yysy。')]
    [string]$Text = ''
)

$HhshGuessUrl = 'https://lab.magiconch.com/api/nbnhhsh/guess'

function BuildTable {
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
                '翻译    ' = $_
            }
            $list.Add($tmp)
        }
    }
    $list.RemoveAt(0)
    return $list
}

if ($Text -eq '') {
    $Text = Read-Host '输入缩写的内容，可以使用逗号隔开，例如：yyds,hhsh,yysy'
}

do {
    $Body = @{
        text = $Text
    }
    $Response = Invoke-WebRequest $HhshGuessUrl -Body $Body -Method 'POST'
    $Json = $Response.Content | ConvertFrom-Json
    $Table = BuildTable $Json
    $table | Format-Table
    $Text = Read-Host '输入缩写的内容，可以使用逗号隔开，例如：yyds,hhsh,yysy [回车则退出]'
} while ($Text -ne '')
