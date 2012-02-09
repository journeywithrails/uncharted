// JavaScript Document

function isReg()

{

	var f = document.appl_form;

  if(!empty_firstname(f.First_Name)||!empty_lastname(f.Last_Name)||!check_gender(f.Gender,f.Gender1)||!empty_email(f.email)||!empty_city(f.City)||!empty_state(f.State)||!empty_date(f.birthday)||!empty_address(f.address)||!empty_password(f.password,f.password_confirmation))

   {



   return false;              

  }

  return true; 

}





function empty_firstname(name)

{

	if(name.value=="")

	{

	alert("First Name should not be Empty");

	name.focus();

	return false;

	}

return true;

}



function empty_lastname(name)

{

	if(name.value=="")

	{

	alert("Last Name should not be Empty");

	name.focus();

	return false;

	}

return true;

}

function check_gender(Gender,Gender1)
{

if(Gender.checked ||Gender1.checked)
	{
		return true;
	}
	else
	{
	alert("Gender should not be Empty");
	Gender.focus();
	return false;
	}

}


function empty_email(name)

{

	

	if(name.value=="")

	{

	alert("Email should not be Empty");

	name.focus();

	return false;

	}

	

	var str = name.value;

    var re = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,3}$/;

    if (!str.match(re))

	{

     alert("Check your Email Format");

		name.value="";

		name.focus();

        return false;

    }

	

return true;

}





function empty_city(name)

{

	if(name.value=="")

	{

	alert("City should not be Empty");

	name.focus();

	return false;

	}

return true;

}

function empty_state(name)

{

	if(name.value=="")

	{

	alert("State should not be Empty");

	name.focus();

	return false;

	}

return true;

}






function empty_address(name)

{

	if(name.value=="")

	{

    alert("Address should not be Empty");

	name.focus();

	return false;

	}

return true;

}
function empty_date(name)

{

	if(name.value=="")

	{

    alert("Date of Birth should not be Empty");

	name.focus();

	return false;

	}
	
	var RegExPattern = /^(?=\d)(?:(?:(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})|(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))|(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2}))($|\ (?=\d)))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$/;
	
    var errorMessage = 'Please enter valid date as month, day, and four digit year.\nYou may use a slash, hyphen or period to separate the values.\nThe date must be a real date. 2-30-2000 would not be accepted.\nFormay mm/dd/yyyy.';
	var d=name.value;
    if (!d.match(RegExPattern))
		{
                alert(errorMessage);
				name.value="";
        name.focus();
		return false;
    } 
	
	
	
return true;

}






function empty_password(name,name1)

{

	

	if(name.value=="")

	{

	alert("Password should not be Empty");

	name.focus();

	return false;

	}
	var n=name.value;
	if(n.length<=5)
	{
		alert("Password should be minimum of 6 characters");
		name.value="";
		name.focus();
		return false;
	}

	

	if(name1.value=="")

	{

	alert("Confirmation Password should not be Empty");

	name1.focus();

	return false;

	}

	

	if(name.value==name1.value)

	{

	}

	else

	{

	alert("Password and Confirm Password should be Match");

	name.value="";

	name1.value="";

	name.focus();

	return false;

	}

	

	

return true;

}


