// JavaScript Document
function JM_cc(ob){
var obj=MM_findObj(ob); if (obj) { 
obj.select();js=obj.createTextRange();js.execCommand("Copy");}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}


var over=false,down=false,divleft,divtop,n;   
function clase(x){document.all['plane'+x].style.visibility='hidden'}   
function down1(m){   
n=m;down=true;divleft=event.clientX-parseInt(m.style.left);divtop=event.clientY-parseInt(m.style.top)}   
function move(){if(down){n.style.left=event.clientX-divleft;n.style.top=event.clientY-divtop;}}