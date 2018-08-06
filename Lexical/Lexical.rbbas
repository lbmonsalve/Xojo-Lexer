#tag Module
Protected Module Lexical
	#tag Method, Flags = &h1
		Protected Function Iif(expr As Boolean, strTrue As String, strFalse As String) As String
		  If expr Then
		    Return strTrue
		  Else
		    Return strFalse
		  End If
		End Function
	#tag EndMethod


	#tag Note, Name = ChangeLog
		
		0.0.180805
		
		* init
	#tag EndNote

	#tag Note, Name = Readme
		
		# Xojo-Lexer
		A Xojo module to provide lexical analysis features to Xojo. It will convert source code text to tokens.
		
		Written originally by Garry Pettet [lex](https://github.com/gkjpettet/lex), with some changes like Text by String type.
	#tag EndNote


	#tag Constant, Name = Version, Type = String, Dynamic = False, Default = \"0.0.180805", Scope = Protected
	#tag EndConstant


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
End Module
#tag EndModule
