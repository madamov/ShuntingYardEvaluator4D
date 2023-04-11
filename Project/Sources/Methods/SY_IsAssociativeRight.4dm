//%attributes = {}

// ----------------------------------------------------
// User name (OS): Milan Adamov
// Date and time: 18/03/17, 15:07:03
// ----------------------------------------------------
// Method: SY_IsAssociativeRight
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($0)
C_TEXT:C284($1; $operator)

$operator:=$1

If ($operator="^")
	
	$0:=True:C214
	
Else 
	
	$0:=False:C215
	
End if 

