// JavaScript Document

function valid()
{
   var f = document.postform;
   var field=f.subject;
 
  if(field.value == "")
   {
 	alert("Please Enter Subject");
    field.focus();
     return false;  
             
  }
   var field=f.msg;
   if(field.value == "")
   {
 	alert("Please Enter Message");
    field.focus();
     return false;  
             
  }
  
  return true; 
}