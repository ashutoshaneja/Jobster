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