function createWorkbook($filepath)
{
    # Create an Object Excel.Application using Com interface
    $excel = New-Object -ComObject Excel.Application

    # Disable the 'visible' property so the document won't open in excel
    $excel.Visible = $false

    # Open the Excel file and save it in $WorkBook
    $workBook = $excel.Workbooks.add()
    $workbook.Worksheets.Item(3).Delete()
    $workbook.Worksheets.Item(2).Delete()

    #saving & closing the file
    $workbook.SaveAs($filePath)
}

function migExcel($catname, $catnum)
{
    # Specify the path to the Excel file and the WorkSheet Name
    $FilePath_1 = "C:\Users\chris\Desktop\migAssets\$catname" + "Content.xlsx"
    $FilePath_2 = "C:\Users\chris\Desktop\migAssets\$catnum" + "Content.xlsx"
    $filePaths = ($filePath_1, $filePath_2)

    foreach ($file in $filePaths)
    {
        createWorkbook($file)
    }

}

$worlditems = @{
    85 = 'faith-and-morals'
    83 = 'education'
    84 = 'family'
    252 = 'history'
    82 = 'biography'
}


foreach ($w in $worlditems.GetEnumerator()) {
    $thekey = $w.Name
    $theval = $w.Value
    migExcel "$theval" "$thekey"
}