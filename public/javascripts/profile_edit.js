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
	
	
		var RegExPattern = /^(?=\d)(?:(?:(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})|(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))|(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2}))($|\ (?=\d)))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$/;
	var errorMessage = 'Please enter valid date as month, day, and four digit year.\nYou may use a slash, hyphen or period to separate the values.\nThe date must be a real date. 2-30-2000 would not be accepted.\nFormay MM-DD-YYYY.';	
	
	
	if(document.getElementById('birthday').value =="")
	{
	alert(" Date of Birth should not be Empty");
	document.getElementById('birthday').focus();
	 return false;
	}
	else if(!document.getElementById('birthday').value.match(RegExPattern))
	{
    alert(errorMessage);
    document.getElementById('birthday').focus();
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
	
	if(document.getElementById('State').value =="")
	{
	alert("State should not be Empty");
	document.getElementById('State').focus();
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
