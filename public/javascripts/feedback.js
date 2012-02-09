// JavaScript Document


function isFeedBack()
{

	if(document.getElementById('subject').value=="")
	{
	alert("Subject should not be Empty");
	document.getElementById('subject').focus();
	return false;
	}
	

	
	if(document.getElementById('description').value =="")
	{
	alert("Description should not be Empty");
	document.getElementById('description').focus();
	return false;
	}
	
return true;
}