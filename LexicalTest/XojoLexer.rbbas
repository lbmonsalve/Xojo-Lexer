#tag Class
Protected Class XojoLexer
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
		  ' Returns an array of Xojo data types.
		  ' Taken from: http://developer.xojo.com/data-types and http://developer.xojo.com/advanced-data-types
		  
		  dim dataTypes() as String
		  
		  ' Standard
		  dataTypes.Append("Boolean")
		  dataTypes.Append("Color")
		  dataTypes.Append("Currency")
		  dataTypes.Append("Double")
		  dataTypes.Append("Enumeration")
		  dataTypes.Append("Integer")
		  dataTypes.Append("String")
		  'dataTypes.Append("Auto")
		  'dataTypes.Append("Text")
		  
		  ' Advanced
		  dataTypes.Append("CFStringRef")
		  dataTypes.Append("CGFloat")
		  dataTypes.Append("CString")
		  dataTypes.Append("Delegate")
		  dataTypes.Append("Int8")
		  dataTypes.Append("Int16")
		  dataTypes.Append("Int32")
		  dataTypes.Append("Int64")
		  dataTypes.Append("UInt8")
		  dataTypes.Append("Byte")
		  dataTypes.Append("UInt16")
		  dataTypes.Append("UInt32")
		  dataTypes.Append("UInt64")
		  dataTypes.Append("Object")
		  dataTypes.Append("OSType")
		  dataTypes.Append("PString")
		  dataTypes.Append("Ptr")
		  dataTypes.Append("Single")
		  dataTypes.Append("Structure")
		  dataTypes.Append("Variant")
		  dataTypes.Append("WString")
		  
		  return dataTypes
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function KeywordsAsArray() As String()
		  ' Returns an array of Xojo keywords.
		  ' Taken from: http://developer.xojo.com/reserved-words
		  
		  dim keywords() as String
		  
		  keywords.Append("#Bad")
		  keywords.Append("#Else")
		  keywords.Append("#ElseIf")
		  keywords.Append("#If")
		  keywords.Append("#Pragma")
		  keywords.Append("#Tag")
		  keywords.Append("AddHandler")
		  keywords.Append("AddressOf")
		  keywords.Append("Aggregates")
		  keywords.Append("And")
		  keywords.Append("Array")
		  keywords.Append("As")
		  keywords.Append("Assigns")
		  keywords.Append("Async")
		  keywords.Append("Attributes")
		  keywords.Append("Await")
		  keywords.Append("Break")
		  keywords.Append("ByRef")
		  keywords.Append("ByVal")
		  keywords.Append("Call")
		  keywords.Append("Case")
		  keywords.Append("Catch")
		  keywords.Append("Class")
		  keywords.Append("Const")
		  keywords.Append("Continue")
		  keywords.Append("CType")
		  keywords.Append("Declare")
		  keywords.Append("Delegate")
		  keywords.Append("Dim")
		  keywords.Append("Do")
		  keywords.Append("DownTo")
		  keywords.Append("Each")
		  keywords.Append("Else")
		  keywords.Append("ElseIf")
		  keywords.Append("End")
		  keywords.Append("Enum")
		  keywords.Append("Event")
		  keywords.Append("Exception")
		  keywords.Append("Exit")
		  keywords.Append("Extends")
		  keywords.Append("False")
		  keywords.Append("Finally")
		  keywords.Append("For")
		  keywords.Append("Function")
		  keywords.Append("Global")
		  keywords.Append("GoTo")
		  keywords.Append("Handles")
		  keywords.Append("If")
		  keywords.Append("Implements")
		  keywords.Append("In")
		  keywords.Append("Inherits")
		  keywords.Append("Inline68K")
		  keywords.Append("Interface")
		  keywords.Append("Is")
		  keywords.Append("IsA")
		  keywords.Append("Lib")
		  keywords.Append("Loop")
		  keywords.Append("Me")
		  keywords.Append("Mod")
		  keywords.Append("Module")
		  keywords.Append("Namespace")
		  keywords.Append("New")
		  keywords.Append("Next")
		  keywords.Append("Nil")
		  keywords.Append("Not")
		  keywords.Append("Object")
		  keywords.Append("Of")
		  keywords.Append("Optional")
		  keywords.Append("Or")
		  keywords.Append("ParamArray")
		  keywords.Append("Private")
		  keywords.Append("Property")
		  keywords.Append("Protected")
		  keywords.Append("Public")
		  keywords.Append("Raise")
		  keywords.Append("RaiseEvent")
		  keywords.Append("Rect")
		  keywords.Append("ReDim")
		  keywords.Append("RemoveHandler")
		  keywords.Append("Return")
		  keywords.Append("Select")
		  keywords.Append("Self")
		  keywords.Append("Shared")
		  keywords.Append("Soft")
		  keywords.Append("Static")
		  keywords.Append("Step")
		  keywords.Append("Sub")
		  keywords.Append("Super")
		  keywords.Append("Then")
		  keywords.Append("To")
		  keywords.Append("True")
		  keywords.Append("Try")
		  keywords.Append("Until")
		  keywords.Append("Using")
		  keywords.Append("WeakAddressOf")
		  keywords.Append("Wend")
		  keywords.Append("While")
		  keywords.Append("With")
		  keywords.Append("Xor")
		  
		  return keywords
		End Function
	#tag EndMethod


	#tag Constant, Name = REGEX_BRACKET, Type = String, Dynamic = False, Default = \"[\\(\\)]", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = REGEX_COMMENT, Type = String, Dynamic = False, Default = \"\\/\\/.*|\\\'.*|[r|R][e|E][m|M].*", Scope = Protected
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
			Name="caseSensitive"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="Lex.Lexer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="consolidateNewLines"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			InheritedFrom="Lex.Lexer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="currentLine"
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
			InheritedFrom="Lex.Lexer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ignoreNewLines"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="Lex.Lexer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ignoreTabs"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="Lex.Lexer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ignoreWhitespace"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="Lex.Lexer"
		#tag EndViewProperty
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
		#tag ViewProperty
			Name="version"
			Group="Behavior"
			Type="String"
			InheritedFrom="Lex.Lexer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
