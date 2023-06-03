#tag Class
Protected Class MultipartFormDataContent
	#tag Method, Flags = &h0
		Sub Add(name as String, f as FolderItem)
		  
		  if name.Len > 0 and f <> nil then
		    mNames.Append(name)
		    mTypes.Append("")
		    mValues.Append(f)
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Add(name as String, value as String, contentType as String = "")
		  if name.Len > 0 then
		    mNames.Append(name)
		    mTypes.Append(contentType)
		    mValues.Append(value)
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetURLConnectionMultipartContent(uc as URLConnection)
		  Dim boundary as String = Left(Str(Microseconds) + Str(Microseconds), 24)
		  Dim formText as String
		  Dim CRLF as string = Encodings.ASCII.Chr(13) + Encodings.ASCII.Chr(10)
		  
		  uc.RequestHeader("Content-Type") = "multipart/form-data; boundary=--------------------------" + boundary
		  
		  for i as Integer = 0 to mNames.Ubound
		    
		    formText = formText +  "----------------------------" + boundary + CRLF
		    
		    if mValues(i).Type = Variant.TypeString then
		      
		      formText = formText + "Content-Disposition: form-data; name=""" + mNames(i) + """" + CRLF
		      
		      // Handle Content-Type headers if needed
		      if mTypes(i) <> "" then
		        formText = formText + "Content-Type: " + mTypes(i) + CRLF
		        
		      end
		      
		      // Extra CRLF to start the form body after headers
		      formText = formText + CRLF + mValues(i).StringValue + CRLF
		      
		    else
		      
		      Dim bin as BinaryStream = BinaryStream.Open(FolderItem(mValues(i).ObjectValue))
		      
		      Dim s as String
		      
		      while not bin.EOF
		        s = s + bin.Read(1024 * 16)
		      wend
		      
		      bin.Close()
		      
		      formText = formText + "Content-Disposition: form-data; name=""" + mNames(i) + """; filename=""" + FolderItem(mValues(i).ObjectValue).Name + """" + CRLF + CRLF
		      formText = formText +  s + CRLF
		      
		    end if
		  next
		  
		  
		  // Final end marker is different
		  formText = formText + "----------------------------" + boundary + "--" + CRLF
		  
		  
		  uc.SetRequestContent(formText, "")
		End Sub
	#tag EndMethod


	#tag Note, Name = Read Me and License
		This class is to do multipart "form-data" encoding on URLConnection posts.
		
		---------------------------------------------------------------------------
		
		This class has permissive MIT license.
		
		Copyright 2020 Einhugur Software
		
		
		Permission is hereby granted, free of charge, to any person obtaining a 
		copy of this software and associated documentation files (the "Software"), 
		to deal in the Software without restriction, including without limitation 
		the rights to use, copy, modify, merge, publish, distribute, sublicense, 
		and/or sell copies of the Software, and to permit persons to whom the 
		Software is furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in 
		all copies or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
		EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
		MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
		IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
		DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
		ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
		DEALINGS IN THE SOFTWARE.
		
		---------------------------------------------------------------------------
		
		Special thanks to Andrew Lambert, who pointed me to his code after 
		I had been stuck on this for a day,  where his code gave me clue that 
		I had LF instead of CRLF, which caused things to not work.
		
	#tag EndNote


	#tag Property, Flags = &h21
		Private mNames(-1) As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTypes(-1) As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mValues(-1) As Variant
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
