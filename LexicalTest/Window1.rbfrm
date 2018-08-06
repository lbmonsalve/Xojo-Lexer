#tag Window
Begin Window Window1
   BackColor       =   &hFFFFFF
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   400
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   1275607039
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   0
   Resizeable      =   True
   Title           =   "Lexical test"
   Visible         =   True
   Width           =   800
   Begin ColorTextArea SourceCode
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   &hFFFFFF
      Bold            =   ""
      Border          =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   310
      HelpTag         =   ""
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   ""
      Left            =   20
      LimitText       =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Mask            =   ""
      Multiline       =   True
      ReadOnly        =   ""
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollbarVertical=   True
      Styled          =   True
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   16
      TextUnit        =   0
      Top             =   70
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   270
   End
   Begin Listbox Tokens
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   ""
      Border          =   True
      ColumnCount     =   4
      ColumnsResizable=   ""
      ColumnWidths    =   "100, 60, *, 60"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   ""
      EnableDragReorder=   ""
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   360
      HelpTag         =   ""
      Hierarchical    =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "Name	Position	Value	Length"
      Italic          =   ""
      Left            =   310
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   ""
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollBarVertical=   True
      SelectionType   =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   16
      TextUnit        =   0
      Top             =   20
      Underline       =   ""
      UseFocusRing    =   False
      Visible         =   True
      Width           =   470
      _ScrollWidth    =   -1
   End
   Begin ComboBox SourceCodeType
      AutoComplete    =   False
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialValue    =   "Xojo\r\nBinaryMessage\r\nNone"
      Italic          =   ""
      Left            =   20
      ListIndex       =   0
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   16
      TextUnit        =   0
      Top             =   20
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   198
   End
   Begin BevelButton TokenizeBtn
      AcceptFocus     =   False
      AutoDeactivate  =   True
      BackColor       =   "&c00000000"
      Bevel           =   0
      Bold            =   False
      ButtonType      =   0
      Caption         =   "Tokenize"
      CaptionAlign    =   3
      CaptionDelta    =   0
      CaptionPlacement=   1
      Enabled         =   True
      HasBackColor    =   False
      HasMenu         =   0
      Height          =   30
      HelpTag         =   ""
      Icon            =   ""
      IconAlign       =   0
      IconDX          =   0
      IconDY          =   0
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   230
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      MenuValue       =   0
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextColor       =   "&c00000000"
      TextFont        =   "System"
      TextSize        =   ""
      TextUnit        =   0
      Top             =   19
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   60
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  SourceCode.Text= kSourceCodeTest
		  
		  Tokenize
		  HighlightTokens
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub HandlerTokenizerTokenFound(o As Lexical.Lexer, token As Lexical.Token)
		  #pragma Unused o
		  
		  Tokens.AddRow token.name, Str(token.position), token.value, Str(token.value.Len)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub HandlerTokenizerUnexpectedToken(o As Lexical.Lexer, value as String, line as Integer, position as Integer)
		  #pragma Unused o
		  
		  Tokens.AddRow "UNEXPECTED", Str(line), Str(position), value, Str(value.Len)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub HighlightTokens()
		  If Tokenizer Is Nil Then
		    SourceCode.StyledText.Text= SourceCode.Text
		    SourceCode.StyledText.Size(1, SourceCode.Text.Len)= SourceCode.TextSize
		    Return
		  End If
		  
		  dim st as StyledText = SourceCode.StyledText
		  dim token as Lexical.Token
		  dim tokenColor as Color
		  dim length as Integer
		  
		  for each token in Tokenizer.tokens
		    try
		      tokenColor = SourceCode.TokenColorForName(token.name)
		      if token.position + token.value.Len > SourceCode.Text.Len then
		        length = SourceCode.Text.Len - token.position
		      else
		        length = token.value.Len
		      end if
		      st.TextColor(token.position, length) = tokenColor
		    catch
		    end try
		    
		  next token
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Tokenize()
		  If Not (Tokenizer Is Nil) Then
		    RemoveHandler Tokenizer.TokenFound, WeakAddressOf HandlerTokenizerTokenFound
		    RemoveHandler Tokenizer.UnexpectedToken, WeakAddressOf HandlerTokenizerUnexpectedToken
		    Tokenizer= Nil
		  End If
		  
		  Select Case SourceCodeType.Text
		  Case "Xojo"
		    Tokenizer= New XojoLexer
		    AddHandler Tokenizer.TokenFound, WeakAddressOf HandlerTokenizerTokenFound
		    AddHandler Tokenizer.UnexpectedToken, WeakAddressOf HandlerTokenizerUnexpectedToken
		    
		    Tokenizer.ignoreWhitespace= True
		    Tokenizer.ignoreTabs= True
		    
		    // colors
		    SourceCode.RemoveAllTokenColors
		    SourceCode.AddTokenColor("keyword", &c0000FF)
		    SourceCode.AddTokenColor("type", &c0000FF)
		    SourceCode.AddTokenColor("comment", &c7F0000)
		    SourceCode.AddTokenColor("string", &c6500FE)
		    SourceCode.AddTokenColor("integer", &c326598)
		    SourceCode.AddTokenColor("float", &c006532)
		    SourceCode.AddTokenColor("bracket", &c000000)
		    SourceCode.AddTokenColor("dot", &c000000)
		    SourceCode.AddTokenColor("operator", &c000000)
		    SourceCode.AddTokenColor("symbol", &c000000)
		    SourceCode.AddTokenColor(Tokenizer.TOKEN_UNEXPECTED, &cFF0000)
		  Case "BinaryMessage"
		    Tokenizer= New BinaryMessageLexer
		    AddHandler Tokenizer.TokenFound, WeakAddressOf HandlerTokenizerTokenFound
		    AddHandler Tokenizer.UnexpectedToken, WeakAddressOf HandlerTokenizerUnexpectedToken
		    
		    Tokenizer.ignoreWhitespace= True
		    Tokenizer.ignoreTabs= True
		    
		    // colors
		    SourceCode.RemoveAllTokenColors
		    SourceCode.AddTokenColor("keyword", &c0000FF)
		    SourceCode.AddTokenColor("type", &c0080C000)
		    SourceCode.AddTokenColor("comment", &c7F0000)
		    SourceCode.AddTokenColor("string", &c6500FE)
		    SourceCode.AddTokenColor("integer", &c326598)
		    SourceCode.AddTokenColor("float", &c006532)
		    SourceCode.AddTokenColor("bracket", &c000000)
		    SourceCode.AddTokenColor("dot", &c000000)
		    SourceCode.AddTokenColor("operator", &c000000)
		    SourceCode.AddTokenColor("symbol", &c000000)
		    SourceCode.AddTokenColor(Tokenizer.TOKEN_UNEXPECTED, &cFF0000)
		  End Select
		  
		  Tokens.DeleteAllRows()
		  SourceCode.SelStart = 0
		  
		  If Not (Tokenizer Is Nil) Then
		    Tokenizer.Tokenize(SourceCode.Text)
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private Tokenizer As Lexical.Lexer
	#tag EndProperty


	#tag Constant, Name = kSourceCodeTest, Type = String, Dynamic = False, Default = \"\' This is a comment\rdim name as String \x3D \"Garry Pettet\"\rdim int1 as Integer \x3D 100\rdim pi as Float \x3D 3.143\rdim i\x2C j as Integer\r\rfor i \x3D 0 to 10\r\tj \x3D j + i\rnext i\r\rMsgBox(j.ToText) // show a dialog", Scope = Private
	#tag EndConstant


#tag EndWindowCode

#tag Events TokenizeBtn
	#tag Event
		Sub Action()
		  Tokenize
		  HighlightTokens
		End Sub
	#tag EndEvent
#tag EndEvents
