//%attributes = {}
C_REAL:C285($r1)
C_TEXT:C284($expression)

// $r1:=SY_Evaluate("12/5")

$expression:="15 *(22 +11)-\t18"

$r1:=SY_Evaluate($expression)
