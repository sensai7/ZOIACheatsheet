function hideShow(cl) {
  var a = document.getElementsByClassName(cl);
  if(a[1].style.display != 'none'){
	for (var i=0; i<a.length; i++) 
	  a[i].style.display = 'none';
  }else{
  	for (var i=0; i<a.length; i++) 
	  a[i].style.display = 'inline-block';
  }
}

document.onkeydown = function(evt) {
    evt = evt || window.event;
    if (evt.keyCode == 27) {
        window.location.href = '#main';
    }
};