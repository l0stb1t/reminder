#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>
#include <GuiToolTip.au3>

#pragma compile(Icon, ./clock.ico)

AutoItSetOption ("TrayAutoPause", 0)

HotKeySet("!=", "up")
HotKeySet("!-", "down")
HotKeySet("!\", "reset")

Func reset()
   Global $reset
   $reset = 1
EndFunc

Func up()
   $limit +=5
   ToolTip($limit & " minutes")
   Sleep($tooltip_delay)
   ToolTip("")
EndFunc

Func down()
   If $limit > 5 Then $limit -= 5
   ToolTip($limit & " minutes")
   Sleep($tooltip_delay)
   ToolTip("")
EndFunc

Func timer()
   Global $limit
   $htimer = TimerInit()
   While $reset == 0
	  $timediff = TimerDiff($htimer)
	  If ($timediff > $limit*$MINUTE) Then
		 ExitLoop
	  EndIf
	  Sleep(1000)
   WEnd
   If $reset == 1 Then
	  $reset = 0
	  Return 0 ;reset
   EndIf
   Return 1 ;normal timeout
EndFunc

Const $tooltip_delay = 1500
Const $MINUTE = 1000*60
$limit = 45
$reset = 0
Global $tooltip


Func main()
   While 1:
	  $r = timer()
	  If $r == 1 Then
		 MsgBox($MB_SYSTEMMODAL, "reminder", "Hey It's been a while, take a break !")
		 MsgBox($MB_SYSTEMMODAL, "reminder", "Press OK when you come back")
	  Else
		 MsgBox($MB_SYSTEMMODAL, "reminder", "Timer has been resetted")
	  EndIf
   WEnd
EndFunc

main()