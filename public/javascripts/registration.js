// JavaScript Document
function isReg()
{

	if(document.getElementById('First_Name').value=="")
	{
	alert("FirstName should not be Empty");
	document.getElementById('First_Name').focus();
	return false;
	}
	

	
	if(document.getElementById('Last_Name').value =="")
	{
	alert("LastName should not be Empty");
	document.getElementById('Last_Name').focus();
	return false;
	}
	
	
	if(document.getElementById('Gender').checked ||document.getElementById('Gender1').checked)
	{
	}
	else
	{
	alert("Click on Gender option");
	document.getElementById('Gender').focus();
	return false;
	}
	
	
	
	if(document.getElementById('email').value=="")
	{
	alert("Email should not be Empty");
	document.getElementById('email').focus();
	return false;
	}
	
	var str = document.getElementById('email').value;
    var re = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,3}$/;
    if (!str.match(re)) {
     alert("Check your Email Format");
		document.getElementById('email').value="";
		document.getElementById('email').focus();
        return false;
    }
	
	if(document.getElementById('password').value=="")
	{
	alert("Password should not be Empty");
	document.getElementById('password').focus();
	return false;
	}
	
	if(document.getElementById('confirmation_password').value=="")
	{
	alert("Confirmation Password should not be Empty");
	document.getElementById('confirmation_password').focus();
	return false;
	}
	
	if(document.getElementById('password').value==document.getElementById('confirmation_password').value)
	{
	}
	else
	{
	alert("Password and Confirm Password  should be Match");
	document.getElementById('password').value="";
	document.getElementById('confirmation_password').value="";
	document.getElementById('password').focus();
	return false;
	}
	
	if(document.getElementById('primary_residence').value =="")
	{
	alert("Residence Address should not be Empty");
	document.getElementById('primary_residence').focus();
	return false;
	}
	if(document.getElementById('City').value =="")
	{
	alert("City should not be Empty");
	document.getElementById('City').focus();
	return false;
	}
	
	
	
	if(document.getElementById('places_lived').value =="")
	{
	alert("Places Lived should not be Empty");
	document.getElementById('places_lived').focus();
	return false;
	}
	
	if(document.getElementById('places_traveled').value =="")
	{
	alert("Places Traveled should not be Empty");
	document.getElementById('places_traveled').focus();
	return false;
	}
	if(document.getElementById('personal_interests').value =="")
	{
	alert("Personal Interests should not be Empty");
	document.getElementById('personal_interests').focus();
	return false;
	}
	if(document.getElementById('future_plans').value =="")
	{
	alert("Future Plans should not be Empty");
	document.getElementById('future_plans').focus();
	return false;
	}
	if(document.getElementById('work_life').value =="")
	{
	alert("Work Life should not be Empty");
	document.getElementById('work_life').focus();
	return false;
	}
	
	if(document.getElementById('value_life').value =="")
	{
	alert("Value Life should not be Empty");
	document.getElementById('value_life').focus();
	return false;
	}
	
	if(document.getElementById('reference').value =="")
	{
	alert("Reference should not be Empty");
	document.getElementById('reference').focus();
	return false;
	}
	
	if(document.getElementById('check').checked)
	{
	}
	else
	{
	alert("You Should Accept the Information Submitted in this application is true.");
	document.getElementById('check').focus();
	return false;
	}
	


return true;
}
