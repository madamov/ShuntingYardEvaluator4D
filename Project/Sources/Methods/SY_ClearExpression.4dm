//%attributes = {}
// clears expression of spaces, whitespace, special characters, anything that can't be processed

C_TEXT:C284($0; $resultingExpression)
C_TEXT:C284($1; $cleanMe; $allowedCharacters)

C_LONGINT:C283($i; $pos)

$cleanMe:=$1

$allowedCharacters:="01234567890.,+*-/()"
$resultingExpression:=""

For ($i; 1; Length:C16($cleanMe))
	
	$pos:=Position:C15($cleanMe[[$i]]; $allowedCharacters)
	
	If ($pos>0)
		$resultingExpression:=$resultingExpression+$cleanMe[[$i]]
	End if 
	
End for 

$0:=$resultingExpression
