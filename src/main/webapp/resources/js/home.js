function startTime() {
	var today = new Date();
	var h = today.getHours();
	var m = today.getMinutes();
	var s = today.getSeconds();
	var TimeMeridian = getMeridian(h);
	h = changeFormat(h);
	m = checkTime(m);
	s = checkTime(s);
	document.getElementById('dynamicTime').innerHTML =
		h + ":" + m + ":" + s + " " + TimeMeridian;
	var t = setTimeout(startTime, 500);
}
function getMeridian(h){
	if(h>12)	{	return "PM IST";}
	else		{return "AM IST";}
}
function changeFormat(h){
	if(h>12){
		h-=12;
	}
	return h;
}
function checkTime(i) {
	if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
	return i;
}

function hand() {
	var a = document.getElementById("emoji");

	a.innerHTML = "&#x270B;&#x1F3FB;";
	setTimeout(function () {
		a.innerHTML = "&#x1F44B;&#x1F3FB;";
	}, 1600);
	setTimeout(function () {
		a.innerHTML = "&#x270C;&#x1F3FB;";
	}, 2800);
}
hand();
setInterval(hand, 4200);

function togglePassword() {
	var x = document.getElementById("password-input");
	if (x.type === "password") {
		x.type = "text";
	} else {
		x.type = "password";
	}
}