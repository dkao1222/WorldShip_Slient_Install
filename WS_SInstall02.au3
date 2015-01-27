#include <MsgBoxConstants.au3>
#include <File.au3>
;Now only for X86
if @OSArch ="X86" Then
   Local $sVar = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\UPS\Installation", "WSVersion")
;MsgBox($MB_SYSTEMMODAL, "Program files are in:", $sVar)
   Local $sTestPath = _PathFull(@ScriptDir & "\PIF\IM\")
;MsgBox($MB_SYSTEMMODAL, "", @ScriptDir & @CRLF & $sTestPath)
   $file = FileOpen($sTestPath & "Profile.ini")
;~ $file = FileOpen("\PIF\IM\Profile.ini,0)
   $line1 = FileReadLine($file,6)
   $NewVer = StringRight($line1,7)
   FileClose($file)
   if sVar = NULL  Then
	  ;MsgBox(0,"","Do not Install")
	  SplashTextOn("Slient Install","WorldShip install will to your Desktop",300,100)
	  Sleep(3000)
	  SplashOff()
	  Install_Check_New()
   ElseIf $sVar = $NewVer Then
	  ;MsgBox(0,"","Cover Install")
	  SplashTextOn("Slient Install","WorldShip install will cover your WorldShip",300,100)
	  Sleep(3000)
	  SplashOff()
	  Install_Check_Cover()
   ElseIf $NewVer - $sVar  <=2  Then
	  ;MsgBox(0,"","Upsdate Install")
	  SplashTextOn("Slient Install","WorldShip install will Update your WorldShip",300,100)
	  Sleep(3000)
	  SplashOff()
	  Install_Check_Update()
   ElseIf $NewVer - $sVar >2 Then ;$NewVer - $sVar
	  ;MsgBox(0,"","New Install")
;~ 	  SplashTextOn("Slient Install","WorldShip install will to your Desktop",300,100)
;~ 	  Sleep(3000)
;~ 	  SplashOff()
;~ 	  Install_Check_New()
	  SplashTextOn("Slient Install","WorldShip could not install" &@CRLF & "!!!!Please Install WorldShip" & $sVar + 2 & " first.!!!!",300,100)
	  Sleep(5000)
	  SplashOff()
	  Exit
;~    Else
;~ 	  ;MsgBox(0,"","New Install")
;~ 	  SplashTextOn("Slient Install","WorldShip install will to your Desktop",300,100)
;~ 	  Sleep(3000)
;~ 	  SplashOff()
;~ 	  Install_Check_New()
   EndIf
Else
   MsgBox(0,"","X64 system slient install not support")
   Exit
EndIf

Func Install_Check_Cover()
   $file = FileOpen("settings.ini",0)
   $line = FileReadLine($file,28)
   if $line1 = "PreInstallRebootInAnHour=1" =True Then
	  FileClose($file)
	  FileOpen("settings.ini",1)
	  ;MsgBox(0,"","Lin28 will Change")
	  _FileWriteToLine("settings.ini",28,"PreInstallRebootInAnHour=0",1)
	  FileClose("settings.ini")
   Endif
   FileClose($file)
   Run("Setup.exe")
   Install_Check_Program()
   ;SelectLanguage()
   SelectLanguang_UC()
   Install_Check()

EndFunc
Func Install_Check_Update()
   $file = FileOpen("settings.ini",0)
   $line = FileReadLine($file,28)
   if $line1 = "PreInstallRebootInAnHour=1" =True Then
	  FileClose($file)
	  FileOpen("settings.ini",1)
	  ;MsgBox(0,"","Lin28 will Change")
	  _FileWriteToLine("settings.ini",28,"PreInstallRebootInAnHour=0",1)
	  FileClose("settings.ini")
   Endif
   FileClose($file)
   Run("Setup.exe")
   Install_Check_Program()
   ;SelectLanguage()
   SelectLanguang_UC()
   License_Agree_Haveinstall()
EndFunc
Func Install_Check_New()
   $file = FileOpen("settings.ini",0)
   $line = FileReadLine($file,28)

   if $line1 = "PreInstallRebootInAnHour=1" =True Then
	  FileClose($file)
	  FileOpen("settings.ini",1)
	  ;MsgBox(0,"","Lin28 will Change")
	  _FileWriteToLine("settings.ini",28,"PreInstallRebootInAnHour=0",1)
	  FileClose("settings.ini")
   Endif
   FileClose($file)
   Run("Setup.exe")
   Install_Check_Program()
   SelectLanguage()
   WinWait("UPS WorldShip")
   WinActive("UPS WorldShip")
   License_Agree()
   Install_Type01()
EndFunc

Func Install_Check_Program()
   WinWait("UPS WorldShip")
   if WinActive("UPS WorldShip","WorldShip 或 WorldShip 安裝程式目前正在執行") = True Then
	  WinActivate("UPS WorldShip","WorldShip 或 WorldShip 安裝程式目前正在執行")
	  Send("{ENTER}")
	  MsgBox(0,"WorldShip Slient Install","You have WorldShip install or Running")
	  WinClose
   ElseIf WinActive("UPS WorldShip","WorldShip or WorldShip Setup is currently running") = True Then
	  WinWaitActive("UPS WorldShip","WorldShip or WorldShip Setup is currently running")
	  Send("{ENTER}")
	  MsgBox(0,"WorldShip Slient Install","You have WorldShip install or Running")
	  WinClose
   Endif
EndFunc
Func SelectLanguang_UC()
   If WinActive("UPS WorldShip","強烈推薦您在繼續前退出所有程式並關閉所有防毒軟體") Then
	  Chinese_INS_UC()
   ElseIf WinActive("UPS WorldShip Setup","Please remember to re-enable virus software after the setup has completed") Then
	  English_INS_UC()
   EndIf
EndFunc
Func SelectLanguage()
   If WinActive("UPS WorldShip","強烈推薦您在繼續前退出所有程式並關閉所有防毒軟體") Then
	  Chinese_INS()
   ElseIf WinActive("UPS WorldShip Setup","Please remember to re-enable virus software after the setup has completed") Then
	  English_INS()
   EndIf
EndFunc

Func Chinese_INS()
   $file = FileOpen("Settings.ini",0)
   $line3 = FileReadLine($file,40)
   $varc = DriveSpaceFree("C:\")
   $vard = DriveSpaceFree("D:\")
   $cc = $varc/1000
   $dd = $vard /1000
   if $line3 = "EnableAppDataInstall=0" = True Then
	  WinWaitActive("UPS WorldShip","強烈推薦您在繼續前退出所有程式並關閉所有防毒軟體")
	  WinActivate("UPS WorldShip")
	  Send("繁體中文國語")
	  ;Send("{TAB}")
	  Send("{TAB}")
	  if if $CC > 20 And $dd > 5 Then
		 Send("C:\UPS\WSTD")
	  ElseIf $cc <= 20 And $dd > 5 Then
		 Send("D:\UPS\WSTD")
	  Else
		 Send("D:\UPS\WSTD")
	  EndIf
		 Send("{TAB}{TAB}")
		 Send("臺灣")
   ;~    ControlClick("UPS WorldShip","","安裝")
   ;~    ControlClick("UPS WorldShip","","下一步")
		 Send("!N")
	  ElseIf
   ElseIf $line3 = "EnableAppDataInstall=1" = True Then
	  WinWaitActive("UPS WorldShip","強烈推薦您在繼續前退出所有程式並關閉所有防毒軟體")
	  WinActivate("UPS WorldShip")
	  Send("繁體中文國語")
	  Send("!C")
	  Send("{TAB 4}")
	  if if $CC > 20 And $dd > 5 Then
		 Send("C:\UPS\WSTD")
	  ElseIf $cc <= 20 And $dd > 5 Then
		 Send("D:\UPS\WSTD")
	  Else
		 Send("D:\UPS\WSTD")
	  EndIf
	  ;Send("C:\UPS\WSTD")
	  Send("{TAB}{TAB}")
	  Send("{SPACE}")
	  Send("{TAB}")
	  Send("臺灣")
	  Send("!N")
   EndIf
FileClose($file)
EndFunc
Func English_INS()
   $file = FileOpen("Settings.ini",0)
   $line3 = FileReadLine($file,40)
   if $line3 = "EnableAppDataInstall=0" = True Then
	  WinWaitActive("UPS WorldShip Setup","Please remember to re-enable virus software after the setup has completed")
	  WinActivate("UPS WorldShip")
	  Send("English")
	  ;Send("{TAB}")
	  Send("{TAB}")
	  Send("C:\UPS\WSTD")
	  Send("{TAB}{TAB}")
	  Send("United States")
	  ;ControlClick("UPS WorldShip","","安裝")
	  ;ControlClick("UPS WorldShip","","下一步")
	  Send("!N")
   ElseIf $line3 = "EnableAppDataInstall=1" = True Then
	  WinWaitActive("UPS WorldShip Setup","Please remember to re-enable virus software after the setup has completed")
	  WinActivate("UPS WorldShip")
	  Send("English")
	  Send("!C")
	  Send("{TAB 4}")
	  Send("C:\UPS\WSTD")
	  Send("{TAB}{TAB}")
	  Send("{SPACE}")
	  Send("{TAB}")
	  Send("United States")
	  Send("!N")
   EndIf
EndFunc
Func English_INS_UC()
   $file = FileOpen("Settings.ini",0)
   $line3 = FileReadLine($file,40)
   if $line3 = "EnableAppDataInstall=0" = True Then
	  WinWaitActive("UPS WorldShip Setup","Please remember to re-enable virus software after the setup has completed")
	  WinActivate("UPS WorldShip")
	  Send("English")
	  ;Send("{TAB}")
;~ 	  Send("{TAB}")
;~ 	  Send("C:\UPS\WSTD")
;~ 	  Send("{TAB}{TAB}")
;~ 	  Send("United States")
;~ 	  ControlClick("UPS WorldShip","","安裝")
;~ 	  ControlClick("UPS WorldShip","","下一步")
	  Send("!N")
   ElseIf $line3 = "EnableAppDataInstall=1" = True Then
	  WinWaitActive("UPS WorldShip Setup","Please remember to re-enable virus software after the setup has completed")
	  WinActivate("UPS WorldShip")
	  Send("English")
;~ 	  Send("!C")
;~ 	  Send("{TAB 4}")
;~ 	  Send("C:\UPS\WSTD")
;~ 	  Send("{TAB}{TAB}")
;~ 	  Send("{SPACE}")
;~ 	  Send("{TAB}")
;~ 	  Send("United States")
	  Send("!N")
   EndIf
EndFunc
Func Chinese_INS_UC()
   $file = FileOpen("Settings.ini",0)
   $line3 = FileReadLine($file,40)
   if $line3 = "EnableAppDataInstall=0" = True Then
	  WinWaitActive("UPS WorldShip","強烈推薦您在繼續前退出所有程式並關閉所有防毒軟體")
	  WinActivate("UPS WorldShip")
	  Send("繁體中文國語")
;~ 	  ;Send("{TAB}")
;~ 	  Send("{TAB}")
;~ 	  Send("C:\UPS\WSTD")
;~ 	  Send("{TAB}{TAB}")
;~ 	  Send("臺灣")
;~    ControlClick("UPS WorldShip","","安裝")
;~    ControlClick("UPS WorldShip","","下一步")
	  Send("!N")
   ElseIf $line3 = "EnableAppDataInstall=1" = True Then
	  WinWaitActive("UPS WorldShip","強烈推薦您在繼續前退出所有程式並關閉所有防毒軟體")
	  WinActivate("UPS WorldShip")
	  Send("繁體中文國語")
;~ 	  Send("!C")
;~ 	  Send("{TAB 4}")
;~ 	  Send("C:\UPS\WSTD")
;~ 	  Send("{TAB}{TAB}")
;~ 	  Send("{SPACE}")
;~ 	  Send("{TAB}")
;~ 	  Send("臺灣")
	  Send("!N")
   EndIf
FileClose($file)
EndFunc
Func License_Agree()
;MsgBox(0,"TEST","PAGE2")
;;許可合約申告
Sleep(1000)
WinWait("UPS WorldShip")
   if WinActive("UPS WorldShip","許可合約") Then
	  Sleep(1000)
	  WinWait("UPS WorldShip")
	  WinWaitActive("UPS WorldShip","許可合約")
	  Sleep(200)
	  ;MsgBox(0,"","send key to agree")
	  ControlClick("UPS WorldShip","","我同意並接受協議中的條款")
	  Sleep(200)
	  Send("!N")
   ElseIf WinActive("UPS WorldShip Setup","License Agreement") Then
	  Sleep(1000)
	  WinWait("UPS WorldShip")
	  WinWaitActive("UPS WorldShip Setup","License Agreement")
	  Sleep(200)
	  ;MsgBox(0,"","License")
	  ;ControlClick("UPS WorldShip","","I accept terms in the license agreement")
	  Send("!A")
	  Sleep(200)
	  ;MsgBox(0,"","Send N")
	  Send("!N")
   EndIf
EndFunc
Func Install_Type01()
   $varc = DriveSpaceFree("C:\")
   $vard = DriveSpaceFree("D:\")
   $cc = $varc/1000
   $dd = $vard /1000
   WinWait("UPS WorldShip")
   if WinActive("UPS WorldShip","請選擇所需的安裝程式語言") = True Then
	  WinWaitActive("UPS WorldShip","請選擇所需的安裝程式語言")
	  Sleep(200)
	  ControlClick("UPS WorldShip","","工作組管理員")
	  Sleep(200)
	  Send("{TAB}{TAB}")
	  if $CC > 20 And $dd > 5 Then
		 Send("C:\UPS\WSTD_DB")
   ;~ 	  SplashTextOn("","WorldShip Install Procee startup")
   ;~ 	  Sleep(1000)
   ;~ 	  SplashOff()
		 ;Send("!I")
	  ElseIf $cc <= 20 And $dd > 5 Then
		 Send("D:\UPS\WSTD_DB")
		 ;Send("!I")
	  Else
		 Send("D:\UPS\WSTD_DB")
		 ;Send("!I")
	  EndIf
	  ;Send("!I")
   ElseIf WinActive("UPS WorldShip","Installation Type Selection") = True Then
	  WinWaitActive("UPS WorldShip","Installation Type Selection")
	  Sleep(200)
	  ControlClick("UPS WorldShip","","Workgroup Admin")
	  Sleep(200)
	  Send("{TAB}{TAB}")
	  if $CC > 20 And $dd > 5 Then
		 Send("C:\UPS\WSTD_DB")
   ;~ 	  SplashTextOn("","WorldShip Install Procee startup")
   ;~ 	  Sleep(1000)
   ;~ 	  SplashOff()
		 ;Send("!I")
	  ElseIf $cc <= 20 And $dd > 5 Then
		 Send("D:\UPS\WSTD_DB")
		 ;Send("!I")
	  Else
		 Send("D:\UPS\WSTD_DB")
		 ;Send("!I")
	  EndIf
	  ;Send("!I")
   EndIf
EndFunc
Func Install_Check()
   WinWait("UPS WorldShip")
   if WinActive("UPS WorldShip","版本已安裝")= True Then
	  WinWaitActive("UPS WorldShip","版本已安裝")
	  ;ControlClick("UPS WorldShip","","安裝")
	  ;ControlClick("UPS WorldShip","","下一步")
	  Send("!N")
	  WinWait("UPS WorldShip")
	  WinActivate("UPS WorldShip")
	  License_Agree_Haveinstall()
	  WinWait("UPS WorldShip")
	  WinActivate("UPS WorldShip")
   ElseIf WinActive("UPS WorldShip Setup","UPS WorldShip version is already installed") = True Then
	  WinWaitActive("UPS WorldShip Setup","UPS WorldShip version is already installed")
	  Send("!N")
	  WinWait("UPS WorldShip")
	  WinActivate("UPS WorldShip")
	  License_Agree_Haveinstall()
	  WinWait("UPS WorldShip")
	  WinActivate("UPS WorldShip")
   EndIf
EndFunc

Func License_Agree_Haveinstall()
;MsgBox(0,"TEST","PAGE2")
;;許可合約申告
Sleep(1000)
WinWait("UPS WorldShip")
WinActivate("UPS WorldShip")
   if WinActive("UPS WorldShip 安裝","許可合約") = True Then
	  Sleep(1000)
	  WinWait("UPS WorldShip")
	  WinWaitActive("UPS WorldShip","許可合約")
	  ;Sleep(200)
	  ControlClick("UPS WorldShip","","我同意並接受協議中的條款")
	  ;Sleep(200)
	  Send("!I")
	  WinWait("UPS WorldShip")
	  if WinActive("UPS WorldShip","UPS WorldShip 升級") = True Then
		 WinWaitActive("UPS WorldShip","UPS WorldShip 升級")
		 Send("!O")
	  EndIf
   ElseIf WinActive("UPS WorldShip Setup","License Agreement") = True Then
	  Sleep(1000)
	  WinWait("UPS WorldShip")
	  WinWaitActive("UPS WorldShip Setup","License Agreement")
	  ;Sleep(200)
	  ;MsgBox(0,"","License")
	  ;ControlClick("UPS WorldShip","","I accept terms in the license agreement")
	  Send("!A")
	  ;Sleep(200)
	  ;ControlClick("UPS WorldShip","","Install")
	  ;MsgBox(0,"","Send I")
	  ;WinWaitActive("UPS WorldShip Setup","License Agreement")
	  ;WinActivate("UPS WorldShip")
	  Send("!I")
	  WinWait("UPS WorldShip")
	  if WinActive("UPS WorldShip","UPS WorldShip Upgrade") = True Then
		 WinWaitActive("UPS WorldShip","UPS WorldShip Upgrade")
		 Send("!O")
	  EndIf

   EndIf
EndFunc
;EndFunc