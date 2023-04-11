//%attributes = {}
C_TEXT:C284($1; $Expression)
C_TEXT:C284($2; $decseparator)
C_TEXT:C284($3; $thoussep)
C_TEXT:C284($0; $postfix)
C_LONGINT:C283($len; $stacksize; $i; $j)
C_TEXT:C284($popfromstack; $currnumber)
C_BOOLEAN:C305($keeppoping; $leftassoc; $rightassoc; $innumber)

$Expression:=$1
$postfix:=""
$len:=Length:C16($Expression)

If (Count parameters:C259>1)
	$decseparator:=$2
	If (Count parameters:C259>2)
		$thoussep:=$3
	Else 
		$thoussep:="."
	End if 
Else 
	$decseparator:=","
	$thoussep:="."
End if 

C_TEXT:C284($operators; $presedence)
$operators:="+*/-^\\"
$presedence:="122132"

ARRAY TEXT:C222($operatorstack; 0)

$i:=1

While ($i<=$len)
	
	
	If (Position:C15($Expression[[$i]]; $operators)>0)  // token is operator
		
		Repeat 
			
			$stacksize:=Size of array:C274($operatorstack)
			
			If ($stacksize>0)
				
				$keeppoping:=(Position:C15($operatorstack{1}; $operators)>0)
				$leftassoc:=SY_IsAssocaiativeLeft($Expression[[$i]]) & (SY_GetPresedence($operatorstack{1}; $operators; $presedence)>=SY_GetPresedence($Expression[[$i]]; $operators; $presedence))
				$rightassoc:=SY_IsAssociativeRight($Expression[[$i]]) & (SY_GetPresedence($operatorstack{1}; $operators; $presedence)>SY_GetPresedence($Expression[[$i]]; $operators; $presedence))
				
				$keeppoping:=$keeppoping & ($leftassoc | $rightassoc)
				
				If ($keeppoping)
					
					$popfromstack:=$operatorstack{1}
					$postfix:=$postfix+$popfromstack+" "
					DELETE FROM ARRAY:C228($operatorstack; 1)
					$stacksize:=$stacksize-1
					
				End if 
				
			End if 
			
		Until (($stacksize=0) | Not:C34($keeppoping))
		
		INSERT IN ARRAY:C227($operatorstack; 1)
		$operatorstack{1}:=$Expression[[$i]]
		
		
	Else 
		
		
		If ($Expression[[$i]]="(")  // token is left bracket?
			// push to stack
			
			INSERT IN ARRAY:C227($operatorstack; 1)
			$operatorstack{1}:="("
			
		Else 
			
			If ($Expression[[$i]]=")")  // token is right bracket?
				
				// pop from stack and write to output until left bracket is reached. Pop left bracket from stack
				// but don't write it to the output
				
				$stacksize:=Size of array:C274($operatorstack)
				$keeppoping:=True:C214
				
				While (($stacksize>0) & $keeppoping)
					
					$popfromstack:=$operatorstack{1}
					
					If ($popfromstack#"(")
						$postfix:=$postfix+$popfromstack+" "
					Else 
						$keeppoping:=False:C215
					End if 
					
					DELETE FROM ARRAY:C228($operatorstack; 1)
					$stacksize:=Size of array:C274($operatorstack)
					
				End while 
				
				
			Else 
				
				// add token to output buffer
				
				$currnumber:=""
				$j:=$i
				$innumber:=True:C214
				
				While ($innumber)
					
					If ((Position:C15($Expression[[$j]]; "01234567890"+$thoussep+$decseparator)>0))
						$currnumber:=$currnumber+$Expression[[$j]]
						$j:=$j+1
						$innumber:=($j<=$len)
					Else 
						$innumber:=False:C215
					End if 
					
				End while 
				
				$i:=$i+Length:C16($currnumber)-1
				$postfix:=$postfix+$currnumber+" "
				
			End if   // token is right bracket?
			
			
		End if   // token is left bracket?
		
		
	End if   // token is operator?
	
	$i:=$i+1
	
End while 

Repeat 
	
	$stacksize:=Size of array:C274($operatorstack)
	
	If ($stacksize>0)
		$popfromstack:=$operatorstack{1}
		$postfix:=$postfix+$popfromstack+" "
		DELETE FROM ARRAY:C228($operatorstack; 1)
		
	End if 
	
Until ($stacksize=0)

$0:=$postfix
