//%attributes = {"shared":true,"preemptive":"capable"}
// Evaluates expression using Shunting Yard algorithm
//
// It parses experession and builds postfix notation string from it
// Then applies the rest of algorithm to calculate the value of expression
//

C_REAL:C285($0)
C_TEXT:C284($1; $Expression)
C_TEXT:C284($postfix)

$Expression:=SY_ClearExpression($1)

$postfix:=SY_MakePostfix($Expression)

$0:=SY_EvaluatePostfix($postfix)
