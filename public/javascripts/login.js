// JavaScript Document
function valid()
{
   var f = document.appl_form;
  if(!empty_username(f.email,"Email")||!empty_password(f.password,"Password"))
   {

   return false;              
  }
  return true; 
}


function empty_username(name,id)
{ 
 var  field=name.value;
  if(field == "Email Address")
  { 
  	alert("Please Enter Email");
	document.getElementById('email').focus();
	return false;
	}
	
	var str = name.value;
    var re = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,3}$/;
    if (!str.match(re))
	{
     alert("Wrong Email Format");
		name.value="";
		name.focus();
        return false;
    }
	return true;
}




function empty_password(name,id)
{ 
 var  field=name.value;
  if(field == "Password")
  { 
     alert("Please Enter " + id);
     name.focus();
     return false;  
  }
 
  return true;
}

