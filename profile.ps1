# Vars
$hostFile = "c:\Windows\System32\Drivers\etc\hosts"
$networkTemp = "\\jb-files\Groups\IT\Temporary File Storage"
$code = "$home\myComp\code"
$myComp = "C:\Users\chris\myComp"
$htdocs = "C:\xampp\htdocs\"
$powershellModuleFiles = "C:\Program Files\WindowsPowerShell\Modules"
$webDrive = "H:\Web"
$googleDev = "https://console.developers.google.com"
$quickEditCommand = 'Set-ItemProperty -path “HKCU:\Console” -name QuickEdit -value 1'
$vscode = "C:\Users\chris\AppData\Local\Programs\Microsoft VS Code\Code.exe";
$brackets = "C:\Program Files (x86)\Brackets\Brackets.exe"
$bmark = "$code\php\bmark"
$setReadlineColor = "Set-PSReadLineOption -Colors @{ String = 'white' }"
$powerdir = "C:\Users\chris\Documents\WindowsPowerShell\"
$killexcel = "taskkill /f /im excel.exe"

function setReadlineColor() 
{
    & Set-PSReadLineOption -Colors @{ String = 'white' }
}
setReadlineColor

function bmark($cat = "BS4", $name = "headings (huge font, super small font, etc...)", $url = "https://www.w3schools.in/bootstrap4/typography/")
{
  & php "$bmark\index.php" -c"$cat" -n"$name" -u"$url"
}

function mysql()
{
  & C:\xampp\mysql\bin\mysql -uroot -p
}

# Notes Vars
$sass = "sass --watch C:\assets\css\_bootstrap.scss:C:\assets\css\bootstrap.min.css"

# Git Helpers
$git_stash = "https://mijingo.com/blog/saving-changes-with-git-stash"
$git_add_local_branch_to_remote = "git push -u origin branchName"
$git_add_local_branch_from_remote = "git fetch origin && git checkout groups"
$git_create_new_branch_based_off_master = "git checkout branchName && git rebase master"
$git_merge_changes_to_master = "git checkout master && git merge branchName"
$git_diff_between_staged_and_previous_commit = "git diff --staged .\specific-file.txt"
$git_get_file_from_commit = "git checkout c5f567 -- file1/to/restore file2/to/restore"
$git_oneline = "git log --oneline"

# Web Dev Helpers
$placeholdit = "http://placehold.it/150x50?text=Logo"

# Aliases 
New-Alias -Name kets -Value $brackets
New-Alias -Name subby -Value "C:\Program Files (x86)\Sublime Text 3\sublime_text.exe"
New-Alias -Name snip -Value "C:\Windows\system32\SnippingTool.exe"
New-Alias -Name vs -Value "C:\Users\clemmer\AppData\Local\Programs\Microsoft VS Code\Code.exe"

# Functions
# function q($mult, $comma = false) {
#     foreach $mult as 
#     # if($comma)
#     # q.strtrplace(qstr, " ", ", ")
#     # qstr = '"" "" ""'

# }


function newPHP_project($name = "newPHP-project")
{
    $root = "$htdocs/$name"
    $index = "$root/index.php"
    mkdir $root
    mkdir "$root/classes"
    ni "$index"
    ni "$root/includes.php"
    ni "$root/classes/first.php"
    $indexContent = @"
<?php
error_reporting(E_ALL); 
require_once 'vendor/autoload.php';
require_once 'includes.php';
require_once 'classes/first.php';

// Script Start
// ------------
`$options = getopt("p:");

// Create helper for logging messages to the terminal
// `$helper = new Sample();
// eval(\Psy\sh());
// `$helper->log("Start Time");
?>
"@
    Add-Content -Value $indexContent -Path $index
}


function newWeb_project($name = "newWeb-project")
{
    $root = "$htdocs/$name"
    mkdir $root
    mkdir "$root/css"
    mkdir "$root/sass"
    mkdir "$root/js"
    mkdir "$root/assets"
    ni "$root/index.php"
    ni "$root/css/style.css"
    ni "$root/sass/style.scss"
    ni "$root/js/script.js"
    $indexContent = @"
<?php

?>
"@
    Add-Content -Value $indexContent -Path $index
}


function findStringInFile($pattern, $ext, $path = "./") {
  Get-ChildItem -Path $path -Include *.$ext -Recurse | Select-String -Pattern $pattern
}


function rne($ext, $newExt) {
  Dir *.$ext | rename-item -newname { [io.path]::ChangeExtension($_.name, ".$newExt") }
}

function ref {
  cls
  ls -force
}

function lscol($numCol) 
{
  if ($numCol) 
  {
    ls | Sort-Object | Format-Wide -Column $numCol       
  }
  else 
  {
    ls | Sort-Object | Format-Wide
  }
}

function comp {
  start $myComp;
}

function htdocs {
  start $htdocs;
}

function gfSize {
[CmdletBinding()]
Param (
[Parameter(Mandatory=$true,ValueFromPipeline=$true)]
$Path,
[ValidateSet("KB","MB","GB")]
$Units = "GB"
)
  if ( (Test-Path $Path) -and (Get-Item $Path).PSIsContainer ) {
    $Measure = Get-ChildItem $Path -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum
    $Sum = $Measure.Sum / "1$Units"
    [PSCustomObject]@{
      "Path" = $Path
      "Size($Units)" = $Sum
    }
  }
}

function getSizes ($path, $units) {
  if ($path) {
    $files = gci $path    
  }
  else {
    $files = gci "."
  }
  foreach ($f in $files) {
    gfSize $f.FullName $units
  }
}

function clipDir($folderName) {
  $current_dir = (pwd).path
  $toReplace = $folderName.substring(0,1)
  $folderName = $folderName.replace($toReplace,"")
  $dir_to_clip = "$current_dir$folderName"
  scb $dir_to_clip
}

function rmItems_in_folder($path) {
    # if ($path) 
    # {
    #     $items = gci $path
    # }
    # else 
    # {
    #     $items = gci .
    # }
    $items = gci .
    foreach($item in $items) 
    {
        rm $item -Recurse -Force
    }
}

function cssAdd($functionName, $code) {
  $code = $code.Insert(0, '$value = @''' + "`n")
  $strLength = $code.length
  $code = $code.Insert($strLength, "`n" + '''@' + "`n" + 'echo $value')
  $heredoc = @"

function css$functionName() { 
$code
}
"@ 
  Add-Content -Value $heredoc -Path $PROFILE
}

function phpAdd($functionName, $code) {
  $code = $code.Insert(0, '$value = @''' + "`n")
  $strLength = $code.length
  $code = $code.Insert($strLength, "`n" + '''@' + "`n" + 'echo $value')
  $heredoc = @"

function php$functionName() { 
$code
}
"@ 
  Add-Content -Value $heredoc -Path $PROFILE
}

function phpTernary() {
  echo 'echo isset($var) ? $var : "if false, echo this string instead #!"'
}

function jsAdd($functionName, $code) {
  $code = $code.Insert(0, '$value = @''' + "`n")
  $strLength = $code.length
  $code = $code.Insert($strLength, "`n" + '''@' + "`n" + 'echo $value')
  $heredoc = @"

function js$functionName() { 
$code
}
"@ 
  Add-Content -Value $heredoc -Path $PROFILE
}

function jqueryAdd($functionName, $code) {
  $code = $code.Insert(0, '$value = @''' + "`n")
  $strLength = $code.length
  $code = $code.Insert($strLength, "`n" + '''@' + "`n" + 'echo $value')
  $heredoc = @"

function jquery$functionName() { 
$code
}
"@ 
  Add-Content -Value $heredoc -Path $PROFILE
}
  
function jqueryReady() { 
$value = @'
// Standard.
jQuery(document).ready(function () { 
    alert('DOM is ready!'); 
});

// Shortcut, but same thing as above.
jQuery(function () { 
    alert('No really, the DOM is ready!'); 
});
// Shortcut with fail-safe usage of $. Keep in mind that a reference
// to the jQuery function is passed into the anonymous function.

jQuery(function ($) {
    alert('Seriously it\'s ready!');
    // Use  without fear of conflicts.
});

jQuery(document).ready(function($) {
    alert('Super duper ready beyond comparison');
});
'@
echo $value
}

function jqueryEach() { 
$value = @'
$(".js-lazytube").each(function(index, element) {
  if (element.children[1] !== undefined) {
    if (element.children[1].src !== undefined) {
      console.log(element.children[1]);
    }
  }
});
'@
echo $value
}

function jsArray() { 
$value = @'
const attendees = ["John", "Jennifer", "Blane"];
'@
echo $value
}

function jsArrayPush() { 
$value = @'
const grades = [10, 8, 13, 15];
grades.push(20); //returns 5
'@
echo $value
}

function phpJsonDecode() { 
$value = @'
json_decode takes a json string and makes it into an object or associative array
'@
echo $value
}

function phpJsonEncode() { 
$value = @'
json_encode makes an array or object into a json string
// example
echo "<script>var options = " . json_encode($array) . ';</script>';
'@
echo $value
}

function jsArrowfunction() { 
$value = @'
const sum = (a, b) => {
    return a + b;
}
'@
echo $value
}

function jsForeach() { 
$value = @'
const loopThroughElements = (elements) => {
    elements.forEach( (element) => {
        console.log(element);
    });
};
'@
echo $value
}

function jsHeredocInterpolation() { 
$value = @'
const a = "test";
str = `---
   a is: ${a}
---`;
'@
echo $value
}

function jsArrowfunction() { 
$value = @'
const double = (num) => {
    return num * 2;
}
'@
echo $value
}

function jsSum() { 
$value = @'
function sum(grades){
    let total = 0;
    grades.forEach( (grade) => {
        total = total + grade;
    });
    return total;
}
'@
echo $value
}

function jsArrayfilter() { 
$value = @'
const friends = [
  { name: "Abby", age: 22 },
  { name: "Boby", age: 16 },
  { name: "Coel", age: 20 },
  { name: "Dany", age: 15 }
];

//who can drink?
friends.filter(friend => friend.age >= 18);
'@
echo $value
}

function jsArraymap() { 
$value = @'
const ages = [18, 20, 21, 30];

const agesPlusOne = ages.map(age => age + 1); //[19, 21, 22, 31]
'@
echo $value
}

function jsForloop() { 
$value = @'
    for(let i = 0; i < youtubes.length; i++) {
        console.log("ok");
    }
'@
echo $value
}

function phpRemoveEverythingAfter() { 
$value = @'
function removeEverythingAfter($stringToAlter) {
    $newString = substr($stringToAlter, 0, strpos($stringToAlter, " |"));
    return $newString;
}
'@
echo $value
}


function cssLineclamp() { 
$value = @'
.vid-info {
    display: -webkit-box;
    /* max-height: 3.2rem; */
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    -webkit-line-clamp: 2;
    /* line-height: 1.6rem;
    line-height: 2.2rem;
    max-height: 4.4rem; */
}
'@
echo $value
}

function cssTransformToCenter() { 
$value = @'
    top: 50%;
    left: 50%;
    transform: translate3d(-50%, -50%, 0);
'@
echo $value
}

function phpcreateDir() { 
$value = @'
function checkPlaylistFolder($playlist_title) 
{
    //The name of the directory that we need to create.
    $directoryName = PLAYLISTS_DIR . $playlist_title;
    
    //Check if the directory already exists.
    if( !is_dir($directoryName) )
    {
        //Directory does not exist, so lets create it.
        mkdir($directoryName, 0755);
    }
}
'@
echo $value
}

function phpDirname() { 
$value = @'
require( dirname( __FILE__ ) . '/wp-blog-header.php' );
'@
echo $value
}

function phpCurlNoSSL() { 
$value = @'
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
'@
echo $value
}

function phpForLoop() { 
$value = @'
for ($x = 0; $x <= 10; $x++) {
    echo "The number is: $x <br>";
}
'@
echo $value
}

function phpArrayPush() { 
$value = @'
$array1 = array(1, 2, 3);

$array2 = array("a", "b", "c");

$array3 = array();

array_push($array3, $array1, $array2);

print_r($array3);
'@
echo $value
}

function phpArrayCombine() { 
$value = @'
$array1 = array(1, 2, 3);

$array2 = array("a", "b", "c");

$array3 = array();

$array3 = array_combine($array1, $array2);

print_r($array3);
'@
echo $value
}

function phpBuildArrByLooping() { 
$value = @'
$id_guid = array();

// Loop 1
$guid = array(
    "guid" => "https://one"
);
$id = array(
    "id" => "5"
);
$merged = array_merge($guid, $id);

$id_guid[] = $merged;

// Loop 2
$guid2 = array(
    "guid" => "https://one"
);
$id2 = array(
    "id" => "5"
);
$merged2 = array_merge($guid2, $id2);

$id_guid[] = $merged2;
print_r($id_guid);
'@
echo $value
}

function phpPregReplaceString() { 
$value = @'
function normalizeString( = '')
{
    $str = strip_tags($str); 
    $str = preg_replace('/[\r\n\t ]+/', ' ', $str);
    $str = preg_replace('/[\"\*\/\:\<\>\?\'\|]+/', ' ', $str);
    $str = strtolower($str);
    $str = html_entity_decode( $str, ENT_QUOTES, "utf-8" );
    $str = htmlentities($str, ENT_QUOTES, "utf-8");
    $str = preg_replace('/\s\s+/', ' ', $str);
    $str = preg_replace('/&.*?;/', '', $str); 
    $str = str_replace(' ', '_', $str);
    $str = rawurlencode($str);
    $str = str_replace('%', '-', $str);
    return $str;
}
'@
echo $value
}

function phpSTDIN() { 
$value = @'
echo "enter screen size:";
$ss = trim(fgets(STDIN, 1024));
echo $ss;

'@
echo $value
}

function phpHeredoc() { 
$value = @'
$foo = "bar";
echo <<<EOT
Hello $foo
Goodbye!
EOT;
'@
echo $value
}

function phpNowdoc() { 
$value = @'
$foo = "bar";
echo <<<'EOT'
Hello $foo
Goodbye!
EOT;
'@
echo $value
}


function phpJsonCreate() { 
$value = @'
$bmark = array(
    "BS4" => array(
        "Headings (Huge Font or small)" => "https://www.w3schools.in/bootstrap4/typography/",
        "Name" => "url"
    ),
    "Investments" => array(
        "Name" => "url"
    ) 
); 

// create json file
$fh = fopen("bmark.json", "w+") or die("cant open file");
$bmark_json = json_encode($bmark);
fwrite($fh, $bmark_json); 
fclose($fh);

// Get the uploaded file
$jsonstring = file_get_contents("bmark.json");
$bmark = json_decode($jsonstring, true);
print_r($bmark);
'@
echo $value
}

function phpPsyShell() { 
$value = @'
Psy\sh()
'@
echo $value
}

function phpComposerPsySh() { 
$value = @'
composer require psy/psysh:~0.1
'@
echo $value
}

function rmFiles_BaseName_contains()
{
    $i = 0
    $files = gci .
    foreach ($file in $files)
    {
        $toCheck = $file.BaseName
        if ($toCheck -match '\d\d?x\d\d?')
        {
            rm $file.FullName
        }
        $i++
    }
}


function createWorkbook($filepath)
{
    # Create an Object Excel.Application using Com interface
    $excel = New-Object -ComObject Excel.Application

    # Disable the 'visible' property so the document won't open in excel
    $excel.Visible = $true

    # Open the Excel file and save it in $WorkBook
    $workBook = $excel.Workbooks.add()
    $workbook.Worksheets.Item(3).Delete()
    $workbook.Worksheets.Item(2).Delete()

    #saving & closing the file
    $workbook.SaveAs($FilePath)
}

function gitlog() {
  & git log --oneline
}

function addtoPowershellProfile($val) {& add-content -Path $PROFILE -Value $val}
