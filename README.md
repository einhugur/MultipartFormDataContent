# MultipartFormDataContent
**MultipartFormDataContent class for Xojo**

This class is to do multipart "form-data" encoding on URLConnection posts.

**Example usage:**
```
Dim f as FolderItem = GetOpenFolderItem("*.*")

if f = nil then 
  return
end if

Dim uc as URLConnection = new URLConnection()
Dim multipartContent as MultipartFormDataContent = new MultipartFormDataContent()

multipartContent.Add("Component","PictureEffects")
multipartContent.Add("Path","Xojo x64")
multipartContent.Add("File",f)

multipartContent.SetURLConnectionMultipartContent(uc)

Dim result as String = uc.SendSync("POST", "http://localhost:5000/filecontroller/api/sendfile")
```
