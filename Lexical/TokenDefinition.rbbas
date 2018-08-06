#tag Class
Protected Class TokenDefinition
	#tag Method, Flags = &h0
		Sub Constructor(name as String, regexPattern as String, matchNumber as Integer = 0)
		  Self.name = name
		  Self.regex = regexPattern
		  Self.matchNumber = matchNumber
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function FromLiteral(tokenName as String, literal as String) As Lexical.TokenDefinition
		  ' Convenience method.
		  ' Returns a new TokenDefinition constructed from a single literal text value.
		  ' Used to quickly build regex pattern required to match a single piece of text.
		  ' @param tokenName: The name of this token definition
		  ' @return: TokenDefinition
		  
		  if literal = "" then raise new LexicalException("TokenDefinition.FromLiteral: No literal value specified.", _
		  LexicalException.ERROR_WRONG_PARAMETERS)
		  
		  dim pattern as String
		  
		  pattern = pattern + "\b" + literal + "\b"
		  
		  return new TokenDefinition(tokenName, pattern)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function FromLiterals(tokenName as String, literals() as String) As TokenDefinition
		  ' Convenience method.
		  ' Returns a new TokenDefinition constructed from the passed array of literals.
		  ' Used to quickly build regex pattern required to match a list of words.
		  ' @param tokenName: The name of this token definition
		  ' @return: TokenDefinition
		  
		  if literals.Ubound < 0 then raise new LexicalException("TokenDefinition.FromLiterals: No literals specified.", _
		  LexicalException.ERROR_WRONG_PARAMETERS)
		  
		  dim pattern, literal as String
		  dim i as Integer
		  
		  for i = 0 to literals.Ubound
		    literal = literals(i)
		    pattern = pattern + "\b" + literal + "\b" + Iif(i = literals.Ubound, "", "|")
		  next i
		  
		  return new TokenDefinition(tokenName, pattern)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		#tag Note
			The Tokenizer's regex object has a single search pattern which is an 'or' concatenation of the
			individual regexes for each token definition. In order to know which type of token has been found
			when a match is made, we need to know the 'match number' for this definition. The match number depends
			on the order in which token definitions are added to the regex object.
		#tag EndNote
		matchNumber As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			This token's name. Should be unique to a particular Tokenizer. Although this is not strictly enforced,
			using a duplicate token name will simply overwrite the previous token definition with the same name.
		#tag EndNote
		name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The actual regex pattern that defines this token.
		#tag EndNote
		regex As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="matchNumber"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="regex"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
