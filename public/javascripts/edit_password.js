// JavaScript Document

function isEmpty()
{
	if(document.getElementById('old_password').value=="")
	{
		alert("Please enter old password");
		document.getElementById('old_password').focus();
		return false;
	}
	
	if(document.getElementById('password').value=="")
	{
		alert("Please enter new password");
		document.getElementById('password').focus();
		return false;
	}
	
	
	
	if(document.getElementById('retype_password').value=="")
	{
		alert("Please retype new password");
		document.getElementById('retype_password').focus();
		return false;
	}
return true;
}