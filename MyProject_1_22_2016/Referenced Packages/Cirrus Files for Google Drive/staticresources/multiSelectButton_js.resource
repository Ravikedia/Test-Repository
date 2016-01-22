var divHover = '';
 
function showOptions(objId){
	var multiButtons = document.getElementsByName("multiButton");
	for(var i=0; i < multiButtons.length; i++){
		multiButtons[i].style.position = '';
	}
 
	var multiButtonOpts = document.getElementsByName("multipButtonOpts");
	for(var i=0; i < multiButtonOpts.length; i++){
		multiButtonOpts[i].style.display = 'none';
	}		
 
	document.getElementById('CloneMenu' + objId).style.display = 'block';
	document.getElementById('CloneMenu' + objId).style.top = '24px';
	document.getElementById('button' + objId).style.position = 'relative';
}

document.onclick = function(){
	if(divHover == '' || divHover == null){
		var divs = document.getElementsByTagName('div');
		for(i=0; i < divs.length; i++){
			if(divs[i].getAttribute('name') == 'multiButton'){
				divs[i].style.position = '';
			}
			if(divs[i].getAttribute('name') == 'multipButtonOpts'){
				divs[i].style.display = 'none';
			}
		}
	}
}