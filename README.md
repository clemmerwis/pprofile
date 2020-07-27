# customize-powershell
Powershell file that contains useful functions and variables

Put the code from profile.ps1 into your "Microsoft.Powershell_profile.ps1" file

Location:
C:\Users\{replace-with-userprofile-name}\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1


# How to Use Add functions
1. Copy the code you want to use as template: 
function writeMsg() {
    echo "Hello world!";
}

2. Create a variable in powershell
PS C:\> $a = 'paste the copied code in between the quotes and press enter'

3. Call the add function and enter a "function name" for the first parameter, the second parameter should be the previously created variable.
PS C:\> phpAdd "echoToScreen" $a

# "Windows PowerShell" Properties
	# Options
	Cursor Size: Small

	Command History:
		Buffer Size: 50
		Number of Buffers: 4

	Edit Options:
		(checked)    Quick Edit Mode
		(checked) 	 Insert Mode
		(checked) 	 Enable Ctrl key shortcuts
		(un-checked) Filter clipboard Contents on Paste
		(un-checked) Use Ctrl+Shift+C/V as Copy/Paste

	Text Selection:
		(checked) 	 Enable line wrapping selection (checked)
		(checked) 	 Extended text selection keys (checked)
					
		(un-checked)  Use legacy console

	# Font
	Size: 16
	Font: Consolas

	# Layout
	Screen Buffer Size:
		(checked)  Wrap text output on resize

	Window Position:
		(un-checked)  Let System position window
	
	# Colors
		Screen Background: rgb(60,80,90, 0.95)
		Screen Text: lightblue




