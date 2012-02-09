// JavaScript Document
function isMember()
{

	if(document.getElementById('name').value=="")
	{
	alert("Name should not be Empty");
	document.getElementById('name').focus();
	return false;
	}
	var str1=/[0-9]/;
	var d=document.getElementById('name').value;
	if(d.match(str1))
	{
	alert("Name should  be Alphabets");
	document.getElementById('name').value="";
	document.getElementById('name').focus();
	return false;
	}

	if(document.getElementById('email').value == "")
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
	
	if(document.getElementById('reason').value =="")
	{
	alert("Please Enter Few Words About Your Friend");
	document.getElementById('reason').focus();
	return false;
	}
	
	
	return true;
}