
function webRequest($url)
{
    try
    {
        $response = Invoke-WebRequest $url -ErrorAction Stop -UseBasicParsing 
        # This will only execute if the Invoke-WebRequest is successful.
        $statusCode = $response.StatusCode
    }
    catch
    {
        $StatusCode = $_.Exception.Response.StatusCode.value__
    }
    return $statusCode
}

function createHash($catnum)
{
    $path = 'C:\Users\chris\Desktop\migAssets\json\' + $catnum + 'feats.json'
    $json = Get-Content $path
    $jsonObj = $json | ConvertFrom-Json
    $theHash = @{}
    foreach ($property in $jsonObj.PSObject.Properties) {
        $theHash[$property.Name] = $property.Value
    }
    return $thehash
}

function testImgs($catnum)
{
    $hashed = createHash($catnum)
    $i = 1
    foreach ($h in $hashed.GetEnumerator()) {
        $theid = $h.Name
        $theurl = $h.Value
        $statusCode = webRequest($theurl)
        if ($statusCode -ne 200)
        {
            echo "$i : $theid"
            $i = $i + 1
        }
    }
}

testImgs("367")




