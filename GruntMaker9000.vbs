'----------------'
'-GRUNTMAKER9000-'
'------v2.6------'
'---James Park---'
'------2014------'
'----------------'

'Questions user for project root folder
pRoot = InputBox("Please enter a new/existing root folder for your new Project:", "GruntMaker9000")

If Len(pRoot) = 0 Then
	Wscript.Quit
End If

'Questions user for project theme name (also used for Project name)
pName = InputBox("Now please enter the name for your new Project theme:", "GruntMaker9000")

If Len(pName) = 0 Then
	Wscript.Quit
End If

'Asks user if they want a full Wordpress install, or the base folders for manual download
fullWP = _
    Msgbox("Do you want a full Wordpress install? (All WP files will be copied to directory).", _
        vbYesNo, "Full WP Install")

'Opens a connection to the Windows file editing functionality
Const Overwrite = True
Dim oFSO
Set oFSO = CreateObject("Scripting.FileSystemObject")

'Main Folder Structure
rootFolder = "C:\xampp\htdocs\" & pRoot & "\"
themeFolder = "C:\xampp\htdocs\" & pRoot & "\wp-content\themes\" & pName & "\"

Do While oFSO.FolderExists(themeFolder)
	errorThree = msgbox("This theme exists! Try another project name.", 0, "GruntMaker9000 - Error!")
	pName = InputBox("Please enter the name for your new Project theme:", "GruntMaker9000")
	themeFolder = "C:\xampp\htdocs\" & pRoot & "\wp-content\themes\" & pName & "\"
Loop

'Get GruntMaker Directory
thisDir = oFSO.GetAbsolutePathName(".")
wpZip = thisDir & "\Source\wordpress.zip"
wpZipFull = thisDir & "\Source\wordpress-full.zip"
tZip = thisDir & "\Source\theme.zip"
wpExtract = rootFolder
tExtract = themeFolder

If fullWP = vbYes Then
	'If the entered Root folder doesn't exist, then create it
	If Not oFSO.FolderExists(rootFolder) Then
		oFSO.CreateFolder rootFolder
		'If the root folder doesn't exist, extract the basic WP Structure
		set wpUnzip = CreateObject("Shell.Application")
		set wpFilesInZip = wpUnzip.NameSpace(wpZipFull).Items()
		wpUnzip.NameSpace(wpExtract).CopyHere(wpFilesInZip)
		set wpUnzip = Nothing
	End If
Else
	If Not oFSO.FolderExists(rootFolder) Then
		oFSO.CreateFolder rootFolder
		'If the root folder doesn't exist, extract the basic WP Structure
		set wpUnzip = CreateObject("Shell.Application")
		set wpFilesInZip = wpUnzip.NameSpace(wpZip).Items()
		wpUnzip.NameSpace(wpExtract).CopyHere(wpFilesInZip)
		set wpUnzip = Nothing
	End If
End If

'Create the new Theme folder
oFSO.CreateFolder themeFolder

'Extract the base Foundation theme
set tUnzip = CreateObject("Shell.Application")
set tFilesInZip = tUnzip.NameSpace(tZip).Items()
tUnzip.NameSpace(tExtract).CopyHere(tFilesInZip)
set tUnzip = Nothing

'Check for the style.txt file in the Gruntmaker Source folder
If oFSO.FileExists(thisDir & "\Source\style.txt") Then
	'Copy the file to the theme directory
	oFSO.CopyFile thisDir & "\Source\style.txt", themeFolder
End If

'Check for the package.txt file in the Gruntmaker Source folder
If oFSO.FileExists(thisDir & "\Source\package.txt") Then
	'Copy the file to the theme directory
	oFSO.CopyFile thisDir & "\Source\package.txt", themeFolder
End If

If Not oFSO.FolderExists(rootFolder) Then
	'Check for the htaccess.txt file in the Gruntmaker Source folder
	If oFSO.FileExists(thisDir & "\Source\htaccess.txt") Then
		'Copy the file to the theme directory
		oFSO.CopyFile thisDir & "\Source\htaccess.txt", rootFolder
	End If
End IF

'Allow reading and writing of files
Const ForReading = 1
Const ForWriting = 2

'Read the contents of style.txt
Set grunt = oFSO.OpenTextFile(themeFolder & "style.txt", ForReading)

strText = grunt.ReadAll
grunt.Close

'Replace all instances of XXXXX with the Project Name
strNewText = Replace(strText, "XXXXX", pName)

Set grunt = oFSO.OpenTextFile(themeFolder & "style.txt", ForWriting)
grunt.WriteLine strNewText
grunt.Close

'Change the file from .txt to .css
oFSO.MoveFile themeFolder & "style.txt", themeFolder & "style.css"

'Read the contents of package.txt
Set grunt = oFSO.OpenTextFile(themeFolder & "package.txt", ForReading)

strText = grunt.ReadAll
grunt.Close

'Replace all instances of XXXXX with the Project Name
strNewText = Replace(strText, "XXXXX", pName)

Set grunt = oFSO.OpenTextFile(themeFolder & "package.txt", ForWriting)
grunt.WriteLine strNewText
grunt.Close

'Change the file from .txt to .json
oFSO.MoveFile themeFolder &"package.txt", themeFolder &"package.json"

If Not oFSO.FolderExists(rootFolder) Then
	'Read the contents of htaccess.txt
	Set grunt = oFSO.OpenTextFile(rootFolder & "htaccess.txt", ForReading)

	strText = grunt.ReadAll
	grunt.Close

	'Replace all instances of XXXXX with the Project Name
	strNewText = Replace(strText, "XXXXX", pName)

	Set grunt = oFSO.OpenTextFile(rootFolder & "htaccess.txt", ForWriting)
	grunt.WriteLine strNewText
	grunt.Close

	'Change the file from .txt to the .htaccess file
	oFSO.MoveFile rootFolder &"htaccess.txt", rootFolder & ".htaccess"
End If

'Alert completion message
finished = msgbox("Done and done.", 0,"GruntMaker9000")

'Get the hell out of here
Wscript.Quit