// JavaScript Document
function valid()
{
	

   var f = document.appl_form;
  if(!empty_mail_to(f.mail_to)||!empty_mail_subject(f.mail_subject)||!empty_mail_message(f.mail_message))
   {

   return false;              
  }
  return true; 
}


function empty_mail_to(name,test)
{ 
 var  field=name.value;

  if( field == "Select User" )
  { 
     alert("Please Select User");
     name.focus();
     return false;  
  
 }

  return true;
}


function empty_mail_subject(name)
{ 
 
 var  field=name.value;
  if(field == "")
  { 
     alert("Please Enter Subject");
     name.focus();
     return false;  
  }
 
  return true;
}
function empty_mail_message(name)
{ 
 
 var  field=name.value;
  if(field == "")
  { 
     alert("Please Enter Message");
     name.focus();
     return false;  
  }
 
  return true;
}


function validation()
{
	

   var f = document.test;
  if(!empty_mail_to1(f.mail_to1)||!empty_mail_subject1(f.mail_subject1)||!empty_mail_message1(f.mail_message1))
   {

   return false;              
  }
  return true; 
}


function empty_mail_to1(name)
{
	var field=name.value;

       if(field=name.value=="")
	   {
		   alert("Enter Email Address");
		   name.focus();
		   return false;
	   }



return true;
}

 var re = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,3}$/;
    if (!field.match(re)) 
	{
     alert("Check  Email Format for  To - Address ");
		name.value="";
		name.focus();
        return false;
    }

function empty_mail_subject1(name)
{ 
 
 var  field=name.value;
  if(field == "")
  { 
     alert("Please Enter Subject");
     name.focus();
     return false;  
  }
 
  return true;
}

function empty_mail_message1(name)
{ 
 
 var  field=name.value;
  if(field == "")
  { 
     alert("Please Enter Message");
     name.focus();
     return false;  
  }
 
  return true;
}



