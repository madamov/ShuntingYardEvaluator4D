//%attributes = {}
C_TEXT:C284($1; $Expression)
C_LONGINT:C283($len; $stacksize; $i)
C_TEXT:C284($operators; $currentnumasstring)
C_REAL:C285($0; $operand1; $operand2; $result)

$Expression:=$1

$operators:="+*/-^\\"

ARRAY TEXT:C222($operandstack; 0)

$len:=Length:C16($Expression)
$currentnumasstring:=""

For ($i; 1; $len)
	
	
	If (Position:C15($Expression[[$i]]; $operators)>0)  // token is operator
		
		$stacksize:=Size of array:C274($operandstack)
		
		If ($stacksize>1)
			
			// pop last two operands and apply operator
			
			$operand1:=Num:C11($operandstack{1})
			DELETE FROM ARRAY:C228($operandstack; 1)
			$operand2:=Num:C11($operandstack{1})
			DELETE FROM ARRAY:C228($operandstack; 1)
			
			Case of 
					
				: ($Expression[[$i]]="+")
					
					$result:=$operand2+$operand1
					
				: ($Expression[[$i]]="-")
					
					$result:=$operand2-$operand1
					
				: ($Expression[[$i]]="*")
					
					$result:=$operand2*$operand1
					
				: ($Expression[[$i]]="/")
					
					$result:=$operand2/$operand1
					
				: ($Expression[[$i]]="\\")
					
					$result:=$operand2\$operand1
					
			End case 
			
			INSERT IN ARRAY:C227($operandstack; 1)
			$operandstack{1}:=String:C10($result)
			
			
		End if 
		
		
	Else 
		
		If ($Expression[[$i]]#" ")
			
			$currentnumasstring:=$currentnumasstring+$Expression[[$i]]
			
		Else 
			
			// delimiter reached, new number
			
			If ($currentnumasstring#"")
				INSERT IN ARRAY:C227($operandstack; 1)
				$operandstack{1}:=$currentnumasstring
				$currentnumasstring:=""
			End if 
			
		End if 
		
	End if 
	
	
End for 

$0:=Num:C11($operandstack{1})
