// JavaScript Document
function valid()
{
   var f = document.replyform;
   var field=f.msg
 
  if(field.value == "")
   {
 	alert("Please Enter Message");
    field.focus();
     return false;  
             
  }
  return true; 
}
