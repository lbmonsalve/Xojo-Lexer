#tag Class
Protected Class BinaryMessageLexer
Inherits Lexical.Lexer
	#tag Event
		Sub Initialise()
		  dim keywordDef as Lexical.TokenDefinition = Lexical.TokenDefinition.FromLiterals("keyword", KeywordsAsArray())
		  dim typeDef as Lexical.TokenDefinition = Lexical.TokenDefinition.FromLiterals("type", DataTypesAsArray())
		  dim commentDef as new Lexical.TokenDefinition("comment", REGEX_COMMENT)
		  dim stringDef as new Lexical.TokenDefinition("string", REGEX_STRING)
		  dim integerDef as new Lexical.TokenDefinition("integer", REGEX_INTEGER)
		  dim floatDef as new Lexical.TokenDefinition("float", REGEX_FLOAT)
		  dim bracketDef as new Lexical.TokenDefinition("bracket", REGEX_BRACKET)
		  dim dotDef as new Lexical.TokenDefinition("dot", REGEX_DOT)
		  dim operatorDef as new Lexical.TokenDefinition("operator", REGEX_OPERATOR)
		  dim symbolDef as new Lexical.TokenDefinition("symbol", REGEX_SYMBOL)
		  
		  ' Assign the token definitions to the Tokenizer
		  self.AddTokenDefinition(keywordDef)
		  self.AddTokenDefinition(typeDef)
		  self.AddTokenDefinition(commentDef)
		  self.AddTokenDefinition(stringDef)
		  self.AddTokenDefinition(integerDef)
		  self.AddTokenDefinition(floatDef)
		  self.AddTokenDefinition(bracketDef)
		  self.AddTokenDefinition(dotDef)
		  self.AddTokenDefinition(operatorDef)
		  self.AddTokenDefinition(symbolDef)
		  
		  ' Xojo isn't case sensitive
		  self.caseSensitive = False
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function DataTypesAsArray() As String()
		  ' Returns an array of BinaryMessage data types.
		  ' Taken from:
		  
		  dim dataTypes() as String
		  
		  ' Standard
		  dataTypes.Append("int8")
		  dataTypes.Append("int16")
		  dataTypes.Append("int32")
		  dataTypes.Append("int64")
		  dataTypes.Append("uint8")
		  dataTypes.Append("unit16")
		  dataTypes.Append("uint32")
		  dataTypes.Append("uint64")
		  dataTypes.Append("float")
		  dataTypes.Append("double")
		  dataTypes.Append("bool")
		  dataTypes.Append("string")
		  dataTypes.Append("dictionary")
		  
		  return dataTypes
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function KeywordsAsArray() As String()
		  ' Returns an array of BinaryMessage keywords.
		  ' Taken from:
		  
		  dim keywords() as String
		  
		  keywords.Append("release")
		  keywords.Append("namespace")
		  keywords.Append("import")
		  keywords.Append("message")
		  
		  return keywords
		End Function
	#tag EndMethod


	#tag Constant, Name = REGEX_BRACKET, Type = String, Dynamic = False, Default = \"[\\(\\)\\{\\}]", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REGEX_COMMENT, Type = String, Dynamic = False, Default = \"\\/\\/.*|\\\'.*|[r|R][e|E][m|M].*|\\#.*", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REGEX_DOT, Type = String, Dynamic = False, Default = \"\\.", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REGEX_FLOAT, Type = String, Dynamic = False, Default = \"\\d+\\.\\d+", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REGEX_INTEGER, Type = String, Dynamic = False, Default = \"\\d+(\?!\\.)", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REGEX_OPERATOR, Type = String, Dynamic = False, Default = \"[\\+\\-\\/\\*\\\x3D\\<\\>\\\x2C]", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REGEX_STRING, Type = String, Dynamic = False, Default = \"\".*\?\"", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REGEX_SYMBOL, Type = String, Dynamic = False, Default = \"[a-zA-Z]{1}[\\w]*", Scope = Protected
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
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
