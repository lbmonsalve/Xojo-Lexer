#tag Class
Protected Class Lexer
	#tag Method, Flags = &h0
		Sub AcknowledgeToken(tokenName as String)
		  ' The opposite of IgnoreToken(). Will cause a previously ignored token to be acknowledged
		  ' during tokenization.
		  ' @param tokenName: The name of the token to acknowledge.
		  
		  if tokensToIgnore.HasKey(tokenName) then tokensToIgnore.Remove(tokenName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddTokenDefinition(definition as TokenDefinition)
		  ' Adds a new token type to the Tokenizer.
		  ' @param definition:   The TokenDefinition
		  
		  ' Make sure this is not a reserved token definition name
		  select case definition.name
		  case TOKEN_WHITESPACE, TOKEN_TAB, TOKEN_NEWLINE, TOKEN_UNEXPECTED
		    if TokenDefinitions.HasKey(definition.name) then
		      raise new LexicalException("Tokenizer.AddTokenDefinition: Cannot use '" + definition.name + _
		      "' as a definition name. It is reserved for internal use.", LexicalException.ERROR_WRONG_PARAMETERS)
		    end if
		  end select
		  
		  ' The regex matchnumber for this pattern is dependent upon the total number of patterns we are searching for
		  definition.matchNumber = tokenDefinitions.Count + 1
		  
		  definition.regex = "(?P<" + definition.name + ">" + definition.regex + ")"
		  
		  ' Add this definition
		  tokenDefinitions.Value(definition.name) = definition ' note this overwrite identically named definitions
		  tokenMatchNumbers.Value(definition.matchNumber) = definition.name
		  
		  ' Add this definition's regex pattern to the global regex's pattern as an 'or' clause
		  regex.SearchPattern = regex.SearchPattern + _
		  Iif(regex.SearchPattern = "", definition.regex, "|" + definition.regex)
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  ' Set the RegEx options
		  dim options as RegExOptions
		  options = new RegExOptions
		  
		  ' Initialise the RegEx object
		  self.regex = new RegEx
		  regex.Options = options
		  
		  ' Initialise dictionaries
		  self.tokenDefinitions = new Dictionary
		  self.tokenMatchNumbers = new Dictionary
		  self.tokensToIgnore = new Dictionary
		  
		  ' Add definitions for spaces, tabs and newline characters
		  dim whiteSpaceDef as new TokenDefinition(TOKEN_WHITESPACE, " ")
		  self.AddTokenDefinition(whiteSpaceDef)
		  dim tabDef as new TokenDefinition(TOKEN_TAB, "\t")
		  self.AddTokenDefinition(tabDef)
		  dim newLineDef as new TokenDefinition(TOKEN_NEWLINE, "\n|\r")
		  self.AddTokenDefinition(newLineDef)
		  
		  ' Call our custom Initialise() event so subclasses can do their own setup
		  Initialise()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GetNextToken(source as String, ByRef position as Integer)
		  ' Get next token from the source and advance our position.
		  ' @param source:          The source code to tokenize.
		  ' @param ByRef position:  The position in the source code to start searching from (zero-based).
		  ' @param eventDriven:     If True then the Lexer will raise the TokenFound, UnexpectedToken and
		  '                         EndOfSourceCode events. If False then only the array of tokens will be generated
		  ' Unexpected tokens will raise a LexicalException.
		  
		  dim match as RegExMatch
		  'dim tokenValue as Text
		  dim matchNumber, tokenStart as Integer
		  dim token as Token
		  'dim shouldAddToken as Boolean = True
		  
		  ' Look for a token match
		  match = regex.Search(source, position)
		  
		  if match = Nil then ' No tokens found
		    
		    if position <= source.Len then
		      UnexpectedToken(source.Mid(position), currentLine, position)
		      position = source.Len + 1
		    else
		      EndOfSourceCode
		    end
		    
		  else
		    
		    ' Check if the matched token starts at the next character
		    tokenStart = match.SubExpressionStartB(0)
		    if tokenStart > position then
		      ' No tokens matched at `position` - return error
		      token = new Token(TOKEN_UNEXPECTED, source.Mid(position, tokenStart - position), position, currentLine)
		      tokens.Append(token)
		      UnexpectedToken(token.value, currentLine, token.position)
		      ' Increment our position pointer
		      position = tokenStart + 1
		    end
		    
		    ' The matchNumber for the correct subexpression should be the last one
		    matchNumber = match.SubExpressionCount - 1
		    
		    try ' Create a token
		      token = new Token(TokenNameFromMatchNumber(matchNumber), _
		      match.SubExpressionString(matchNumber), match.SubExpressionStartB(matchNumber), currentLine)
		    catch
		      raise new LexicalException("Tokenizer.GetNextToken: Unable to create new Token.", _
		      LexicalException.ERROR_MISSING_MATCH_NUMBER)
		    end try
		    
		    ' Advance the position in the source code
		    position = token.position + token.value.Len
		    
		    ' If we've hit a new line then increment the current line pointer
		    if token.name = TOKEN_NEWLINE then currentLine = currentLine + 1
		    
		    if token.name = TOKEN_NEWLINE and consolidateNewLines and tokens.Ubound >= 0 and tokens(tokens.Ubound).name = TOKEN_NEWLINE then
		      ' Skip adding this newline token
		    else
		      if not tokensToIgnore.HasKey(token.name) then
		        tokens.Append(token)
		        TokenFound(token)
		      end if
		    end if
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IgnoreToken(tokenName as String)
		  ' This method will cause the specified token to be ignored during tokenization.
		  ' @param tokenName: The name of the token to ignore.
		  
		  tokensToIgnore.Value(tokenName) = ""
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Reset()
		  ' Remove all matched tokens, ready for tokenization again.
		  redim tokens(-1)
		  
		  currentLine = 1
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tokenize(source as String)
		  ' This method tokenizes the passed text. It calls the GetNextToken method repeatedly
		  ' with the supplied input. The EndOfSourceCode event will be called when the end of the
		  ' text is reached, which may be used to trigger any post-processing needed.
		  ' @param source:       The source code (as Text) to tokenize.
		  
		  dim position as integer = 0
		  
		  Reset()
		  
		  while position <= (source.Len-1)
		    ' Get the next token and advance the position
		    GetNextToken(source, position)
		  wend
		  
		  EndOfSourceCode()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function TokenNameFromMatchNumber(matchNumber as Integer) As String
		  ' Returns the name of the token matched by the RegEx engine based on the passed match number
		  ' @param matchNumber: The regex match number determined by GetNextToken().
		  ' @return Text:       The name of the token.
		  ' Raises a LexicalException if a matching token is not found.
		  try
		    return tokenMatchNumbers.Value(matchNumber)
		  catch KeyNotFoundException
		    raise new LexicalException("Tokenizer.TokenNameFromMatchNumber: Could not find a token with " + _
		    "matchNumber " + Str(matchNumber) + ".", LexicalException.ERROR_MISSING_MATCH_NUMBER)
		  end try
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event EndOfSourceCode()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Initialise()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event TokenFound(token as Lexical.Token)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event UnexpectedToken(value as String, line as Integer, position as Integer)
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return regex.Options.CaseSensitive
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  regex.Options.CaseSensitive = value
			End Set
		#tag EndSetter
		caseSensitive As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		consolidateNewLines As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		currentLine As Integer = 1
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Read only.
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  if value then
			    IgnoreToken(TOKEN_NEWLINE)
			  else
			    AcknowledgeToken(TOKEN_NEWLINE)
			  end if
			End Set
		#tag EndSetter
		ignoreNewLines As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Read only.
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  if value then
			    IgnoreToken(TOKEN_TAB)
			  else
			    AcknowledgeToken(TOKEN_TAB)
			  end if
			End Set
		#tag EndSetter
		ignoreTabs As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  ' Read only.
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  if value then
			    IgnoreToken(TOKEN_WHITESPACE)
			  else
			    AcknowledgeToken(TOKEN_WHITESPACE)
			  end if
			End Set
		#tag EndSetter
		ignoreWhitespace As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		#tag Note
			The RegEx instance used to search the source code.
		#tag EndNote
		Protected regex As RegEx
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			A Dictionary containing all of the TokenDefinitions known to this Tokenizer.
			Key = TokenDefinition.name
			Value = TokenDefinition
		#tag EndNote
		Private tokenDefinitions As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			A Dictionary which keeps track of the regex match number for a particular TokenDefinition.
			In order to know which type of token has been found when a match is made, we can cross reference the match
			number determined in the Tokenizer.GetNextToken() method with this Dictionary.
			Key = match number
			Value = TokenDefinition.name
			on the order in which token definitions are added to the regex object.
		#tag EndNote
		Private tokenMatchNumbers As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Stores the Tokens found during tokenization. First token in is element 0.
		#tag EndNote
		tokens() As Token
	#tag EndProperty

	#tag Property, Flags = &h1
		#tag Note
			A dictionary containing the names of tokens to ignore.
			Key = token name.
		#tag EndNote
		Protected tokensToIgnore As Dictionary
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return kVersion
			End Get
		#tag EndGetter
		Version As String
	#tag EndComputedProperty


	#tag Constant, Name = ERROR_UNDEFINED_TOKEN, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kVersion, Type = String, Dynamic = False, Default = \"0.0.180805", Scope = Private
	#tag EndConstant

	#tag Constant, Name = TOKEN_NEWLINE, Type = String, Dynamic = False, Default = \"newline", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TOKEN_TAB, Type = String, Dynamic = False, Default = \"tab", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TOKEN_UNEXPECTED, Type = String, Dynamic = False, Default = \"UNEXPECTED", Scope = Public
	#tag EndConstant

	#tag Constant, Name = TOKEN_WHITESPACE, Type = String, Dynamic = False, Default = \"whitespace", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="caseSensitive"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="consolidateNewLines"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="currentLine"
			Group="Behavior"
			InitialValue="1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ignoreNewLines"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ignoreTabs"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ignoreWhitespace"
			Group="Behavior"
			Type="Boolean"
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
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
