#tag Class
Protected Class Token
	#tag Method, Flags = &h0
		Sub Constructor(name as String, value as String, position as Integer, line as Integer)
		  Self.name = name
		  Self.value = value
		  Self.position = position
		  Self.line = line
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		line As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The name of this token (derived from its TokenDefinition).
		#tag EndNote
		name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The position of the first character of this token in the source code (zero-based).
		#tag EndNote
		position As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The actual string value of this token.
		#tag EndNote
		value As String
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
			Name="line"
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="position"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
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
			Name="value"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
