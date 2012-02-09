// JavaScript Document

function isEmpty()
{
	if(document.getElementById('title').value=="")
	{
		alert("Title field should not be empty");
		document.getElementById('title').focus();
		return false;
	}
	
	if(document.getElementById('location').value=="")
	{
		alert("Location field should not be empty");
		document.getElementById('location').focus();
		return false;
	}
	
	
	
	if(document.getElementById('desc').value=="")
	{
		alert("Description field should not be empty");
		document.getElementById('desc').focus();
		return false;
	}
return true;
}