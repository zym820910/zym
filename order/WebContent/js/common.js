function isEmpty(value){
	if(value == null||value == ''||value.length == 0){
		return true;
	}else{
		return false;
	}
}

function $G(){
 var name,value,i;
 var str=location.href;
 var num=str.indexOf("?")
 str=str.substr(num+1);
 var arrtmp=str.split("&");
 for(i=0;i < arrtmp.length;i++){
  num=arrtmp[i].indexOf("=");
  if(num>0){
   name=arrtmp[i].substring(0,num);
   value=arrtmp[i].substr(num+1);
   this[name]=value;
  }
 }
}
function getRandomValue(arr){
	var index=-1;
	var num = -1;
	var value = '';
	var flag = true;
	while(num<0||num>4){
		num = parseInt(Math.random()*50);
	}
	while(index<0||index>(arr.length*num)){
		index = parseInt(Math.random()*arr.length*num);
	}
	while(index>=0){
		if(index>=arr.length){
			if(arr[index%(arr.length)]!=''){
				if(value.indexOf(arr[index%arr.length])==-1){
					value+=arr[index%arr.length]+";";
				}				
			}
			index=index-(arr.length%num==0?arr.length:arr.length%num);
		}else{
			if(arr[index]!=''){
				if(value.indexOf(arr[index])==-1){
					value+=arr[index]+";";
				}
			}
			index=index-arr.length;
		}
	}
	if(value==''){
		value = arr[0];
	}
	return value;
}
function GetRandomAge(){ 
	var age = 0;
	while(age<18||age>80){
		age = parseInt(Math.random()*50)
	}
	return age;
} 
function GetRandomIndex(){ 
	return parseInt(Math.random()*10000)/100;
} 
function GetRandom(){
	return parseInt(Math.random()*10);
}

function iframeAutoFit() {
	try {
		//alert("autofit: " + window + ", " + parent);
		if (window != parent) {
			var a = parent.document.getElementsByTagName("IFRAME");
			for (var i = 0; i < a.length; i++) { //author:meizz
				if (a[i].contentWindow == window) {
					var h1 = 0, h2 = 0;
					a[i].parentNode.style.height = a[i].offsetHeight + "px";
					a[i].style.height = "10px";
					if (document.documentElement && document.documentElement.scrollHeight) {
						h1 = document.documentElement.scrollHeight;
					}
					if (document.body) {
						h2 = document.body.scrollHeight;
					}
					var h = Math.max(h1, h2);
					if (document.all) {
						h += 4;
					}
					if (window.opera) {
						h += 1;
					}
					a[i].style.height = a[i].parentNode.style.height = h + "px";
				}
			}
		}
	}
	catch (ex) {
	}
}