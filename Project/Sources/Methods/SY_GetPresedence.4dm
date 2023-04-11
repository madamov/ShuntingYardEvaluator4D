//%attributes = {}
C_LONGINT:C283($0)
C_TEXT:C284($1; $operator)
C_TEXT:C284($2; $operatorstring)
C_TEXT:C284($3; $presedencestring)

$operator:=$1
$operatorstring:=$2
$presedencestring:=$3

C_LONGINT:C283($pos)


$pos:=Position:C15($operator; $operatorstring)

If ($pos>0)
	
	$0:=Num:C11($presedencestring[[$pos]])
	
End if 

