var bMoveable=true;	
var _VersionInfo=""
var strFrame="";

document.writeln('<iframe id=meizzDateLayer Author=wayx frameborder=0 src="javascript:false;" style="position: absolute; width: 144px; height: 238px; z-index: 9998; display: none"></iframe>');
//strFrame='<html><body>';
strFrame+='<style>';
strFrame+='INPUT.button{BORDER-RIGHT: #ff9900 1px solid;BORDER-TOP: #ff9900 1px solid;BORDER-LEFT: #ff9900 1px solid;';
strFrame+='BORDER-BOTTOM: #ff9900 1px solid;BACKGROUND-COLOR: #fff8ec;font-family:;}';
strFrame+='TD{FONT-SIZE: 9pt;font-family:;}';
strFrame+='INPUT.smallbutton{BORDER: #ff9900 1px solid;BACKGROUND-COLOR: #fff8ec;font-size:9pt;padding-top:2px;cursor:pointer;}';
strFrame+='</style>';
strFrame+='<scr' + 'ipt>';
strFrame+='var datelayerx,datelayery;	';
strFrame+='var bDrag;	';
strFrame+='function document.onmousemove()	';
strFrame+='{if(bDrag && window.event.button==1)';
strFrame+='	{var DateLayer=parent.document.all.meizzDateLayer.style;';
strFrame+='		DateLayer.posLeft += window.event.clientX-datelayerx;';
strFrame+='		DateLayer.posTop += window.event.clientY-datelayery;}}';
strFrame+='function DragStart()		';
strFrame+='{var DateLayer=parent.document.all.meizzDateLayer.style;';
strFrame+='	datelayerx=window.event.clientX;';
strFrame+='	datelayery=window.event.clientY;';
strFrame+='	bDrag=true;}';
strFrame+='function DragEnd(){		';
strFrame+='	bDrag=false;}';
strFrame+='</scr' + 'ipt>';
strFrame+='<div style="z-index:9997;position: absolute; left:0; top:0;" onselectstart="return false">';
strFrame+='<span id=tmpSelectYearLayer Author=wayx style="z-index: 9996;position: absolute;top: 28; left: 19;display: none"></span>';
strFrame+='<span id=tmpSelectMonthLayer Author=wayx style="z-index: 9996;position: absolute;top: 28; left: 78;display: none"></span>';
strFrame+='<table border=1 cellspacing=0 cellpadding=0 width=142 height=160 bordercolor=#ff9900 bgcolor=#ff9900 Author="wayx">';

strFrame+='<tr Author="wayx"><td Author="wayx">';
strFrame+='        <table border=0 cellspacing=1 cellpadding=0 width=100% Author="wayx" bgcolor="buttonface">';
strFrame+='          <tr Author="wayx">';
strFrame+='				<td Author=meizz align=left><input Author=meizz type=button class=smallbutton value="清空" onclick="parent.meizzClearDay()"></td>';
strFrame+='             <td Author=meizz align=right><input Author=meizz type=button class=smallbutton value="关闭" onclick="parent.closeLayer()"></td><td ';
strFrame+='             Author=meizz align=right></td>';
strFrame+='</tr></table></td></tr>';

strFrame+='  <tr Author="wayx"><td width=142 height=23 Author="wayx" bgcolor=#FFFFFF><table border=0 cellspacing=1 cellpadding=0 width=140 Author="wayx" height=23>';
strFrame+='      <tr align=center Author="wayx"><td width=16 align=center bgcolor=#ff9900 style="font-size:12px;cursor: hand;color: #ffffff" ';
strFrame+='        onclick="parent.meizzPrevM()" title="向前1个月" Author=meizz><b Author=meizz>&lt;</b>';
strFrame+='        </td><td width=60 align=center style="font-size:12px;cursor:default" Author=meizz ';
strFrame+='onmouseover="style.backgroundColor=\'#FFD700\'" onmouseout="style.backgroundColor=\'white\'" ';
strFrame+='onclick="parent.tmpSelectYearInnerHTML(this.innerText.substring(0,4))" title="选择年份"><span Author=meizz id=meizzYearHead></span></td>';
strFrame+='<td width=48 align=center style="font-size:12px;cursor:default" Author=meizz onmouseover="style.backgroundColor=\'#FFD700\'" ';
strFrame+=' onmouseout="style.backgroundColor=\'white\'" onclick="parent.tmpSelectMonthInnerHTML(this.innerText.length==3?this.innerText.substring(0,1):this.innerText.substring(0,2))"';
strFrame+='        title="选择月份"><span id=meizzMonthHead Author=meizz></span></td>';
strFrame+='        <td width=16 bgcolor=#ff9900 align=center style="font-size:12px;cursor: hand;color: #ffffff" ';
strFrame+='         onclick="parent.meizzNextM()" title="向后1个月" Author=meizz><b Author=meizz>&gt;</b></td></tr>';
strFrame+='    </table></td></tr>';
strFrame+='  <tr Author="wayx"><td width=142 height=18 Author="wayx">';
strFrame+='<table border=1 cellspacing=0 cellpadding=0 bgcolor=#ff9900 ' + (bMoveable? 'onmousedown="DragStart()" onmouseup="DragEnd()"':'');
strFrame+=' BORDERCOLORLIGHT=#FF9900 BORDERCOLORDARK=#FFFFFF width=140 height=20 Author="wayx" style="cursor:' + (bMoveable ? 'move':'default') + '">';
strFrame+='<tr Author="wayx" align=center valign=bottom><td style="font-size:12px;color:#FFFFFF" Author=meizz>日</td>';
strFrame+='<td style="font-size:12px;color:#FFFFFF" Author=meizz>一</td><td style="font-size:12px;color:#FFFFFF" Author=meizz>二</td>';
strFrame+='<td style="font-size:12px;color:#FFFFFF" Author=meizz>三</td><td style="font-size:12px;color:#FFFFFF" Author=meizz>四</td>';
strFrame+='<td style="font-size:12px;color:#FFFFFF" Author=meizz>五</td><td style="font-size:12px;color:#FFFFFF" Author=meizz>六</td></tr>';
strFrame+='</table></td></tr>';
strFrame+='  <tr Author="wayx"><td width=142 height=120 Author="wayx">';
strFrame+='    <table border=1 cellspacing=2 cellpadding=0 BORDERCOLORLIGHT=#FF9900 BORDERCOLORDARK=#FFFFFF bgcolor=#fff8ec width=140 height=120 Author="wayx">';
var n=0; 
for (j=0;j<5;j++)
{ 
	strFrame+= ' <tr align=center Author="wayx">'; 
	for (i=0;i<7;i++)
	{
		strFrame+='<td width=20 height=20 id=meizzDay'+n+' style="font-size:12px" Author=meizz onclick=parent.meizzDayClick(this.innerText,0)></td>';
		n++;
	}
	strFrame+='</tr>';
}
strFrame+='      <tr align=center Author="wayx">';
for (i=35;i<39;i++) 
	strFrame+='<td width=20 height=20 id=meizzDay'+i+' style="font-size:12px" Author=wayx onclick="parent.meizzDayClick(this.innerText,0)"></td>';
	
strFrame+='        <td colspan=3 align=right Author=meizz></td></tr>';
strFrame+='    </table></td></tr><tr Author="wayx"><td Author="wayx">';
strFrame+='        <table border=0 cellspacing=1 cellpadding=0 width=100% Author="wayx" bgcolor=#FFFFFF>';
strFrame+='          <tr Author="wayx"><td Author=meizz align=left><input Author=meizz type=button class=button value="<<" title="上1年" onclick="parent.meizzPrevY()" ';
strFrame+='             onfocus="this.blur()" style="font-size: 12px; height: 20px"><input Author=meizz class=button title="上1个月" type=button ';
strFrame+='             value="< " onclick="parent.meizzPrevM()" onfocus="this.blur()" style="font-size: 12px; height: 20px"></td><td ';
strFrame+='             Author=meizz align=center><input Author=meizz type=button class=button value="今天" onclick="parent.meizzToday()" ';
strFrame+='             onfocus="this.blur()" title="今天" style="font-size: 12px; height: 20px; cursor:hand"></td><td ';
strFrame+='             Author=meizz align=right><input Author=meizz type=button class=button value=" >" onclick="parent.meizzNextM()" ';
strFrame+='             onfocus="this.blur()" title="下1个月" class=button style="font-size: 12px; height: 20px"><input ';
strFrame+='             Author=meizz type=button class=button value=">>" title="下1年" onclick="parent.meizzNextY()"';
strFrame+='             onfocus="this.blur()" style="font-size: 12px; height: 20px"></td>';
strFrame+='</tr></table></td></tr></table></div>';
//strFrame+='</body></html>';

window.frames.meizzDateLayer.document.writeln(strFrame);
window.frames.meizzDateLayer.document.close();	

var outObject;
var outButton;
var outDate="";	
var odatelayer=window.frames.meizzDateLayer.document.all;

//20080920 Add By PGQ，一般情况采用setDay(tt,obj)方法,特殊情况下，定位不准确采用该方法 
function setLayday(tt,obj)
{
	if (arguments.length > 2)
	{
		alert("");
		return;
	}
	if (arguments.length == 0)
	{
		alert("");
		return;
	}
	var dads  = document.all.meizzDateLayer.style;
	var th = tt;
	
	var ttop  = tt.offsetTop;     
	var thei  = tt.clientHeight;  
	var tleft = tt.offsetLeft;    
	var ttyp  = tt.type;          
	
	while (tt = tt.offsetParent)
	{
		ttop+=tt.offsetTop - tt.scrollTop; 
		tleft+=tt.offsetLeft;
	}
	
	dads.top  = (ttyp=="image") ? ttop+thei : ttop+thei+6;
	dads.left = tleft;
	outObject = (arguments.length == 1) ? th : obj;
	outButton = (arguments.length == 1) ? null : th;
	
	outObject.setAttribute("readOnly",true);
	outObject.blur();

	var reg = /^(\d+)-(\d{1,2})-(\d{1,2})$/;
	var r = outObject.value.match(reg);
	if(r!=null)
	{
		r[2]=r[2]-1;
		var d= new Date(r[1], r[2],r[3]);
		if(d.getFullYear()==r[1] && d.getMonth()==r[2] && d.getDate()==r[3])
		{
			outDate=d;
		}
		else outDate="";
		meizzSetDay(r[1],r[2]+1);
	}
	else
	{
		outDate="";
		meizzSetDay(new Date().getFullYear(), new Date().getMonth() + 1);
	}
	dads.display = '';

	event.returnValue=false;
}

function setday(tt,obj)
{
	if (arguments.length > 2)
	{
		alert("");
		return;
	}
	if (arguments.length == 0)
	{
		alert("");
		return;
	}
	var dads  = document.all.meizzDateLayer.style;
	var th = tt;
	
	var ttop  = tt.offsetTop;     
	var thei  = tt.clientHeight;  
	var tleft = tt.offsetLeft;    
	var ttyp  = tt.type;          
	
	while (tt = tt.offsetParent)
	{
		ttop+=tt.offsetTop; //- tt.scrollTop; 
		tleft+=tt.offsetLeft;
	}
	
	dads.top  = (ttyp=="image") ? ttop+thei : ttop+thei+6;
	dads.left = tleft;
	outObject = (arguments.length == 1) ? th : obj;
	outButton = (arguments.length == 1) ? null : th;
	
	outObject.setAttribute("readOnly",true);
	outObject.blur();

	var reg = /^(\d+)-(\d{1,2})-(\d{1,2})$/;
	var r = outObject.value.match(reg);
	if(r!=null)
	{
		r[2]=r[2]-1;
		var d= new Date(r[1], r[2],r[3]);
		if(d.getFullYear()==r[1] && d.getMonth()==r[2] && d.getDate()==r[3])
		{
			outDate=d;
		}
		else outDate="";
		meizzSetDay(r[1],r[2]+1);
	}
	else
	{
		outDate="";
		meizzSetDay(new Date().getFullYear(), new Date().getMonth() + 1);
	}
	dads.display = '';

	event.returnValue=false;
}

var MonHead = new Array(12);
    MonHead[0] = 31; MonHead[1] = 28; MonHead[2] = 31; MonHead[3] = 30; MonHead[4]  = 31; MonHead[5]  = 30;
    MonHead[6] = 31; MonHead[7] = 31; MonHead[8] = 30; MonHead[9] = 31; MonHead[10] = 30; MonHead[11] = 31;

var meizzTheYear=new Date().getFullYear(); 
var meizzTheMonth=new Date().getMonth()+1; 
var meizzWDay=new Array(39);               

var datetimeHidden=function() 
{
  with(window.event)
  { 
  	if (srcElement.getAttribute("Author")==null && srcElement != outObject && srcElement != outButton) closeLayer();
  }
}

var datetimeKeyup=function()
{
    if (window.event.keyCode==27)
	{
		if(outObject)	outObject.blur();
		closeLayer();
	}
	else if(document.activeElement)
	{
		if(document.activeElement.getAttribute("Author")==null && document.activeElement != outObject && document.activeElement != outButton)
		{
			closeLayer();
		}
	}
}

document.attachEvent("onclick",datetimeHidden);
document.attachEvent("onkeyup",datetimeKeyup);

function meizzWriteHead(yy,mm)
{
	odatelayer.meizzYearHead.innerText  = yy + " 年";
    odatelayer.meizzMonthHead.innerText = mm + " 月";
}

function tmpSelectYearInnerHTML(strYear)
{
	if (strYear.match(/\D/)!=null){alert("！");return;}
	var m = (strYear) ? strYear : new Date().getFullYear();
	if (m < 1000 || m > 9999) {alert(" 1000  9999 ！");return;}
	var n = m - 80;
	if (n < 1000) n = 1000;
	if (n + 26 > 9999) n = 9974;
	var s = "<select Author=meizz name=tmpSelectYear style='font-size: 12px' "
	s += "onblur='document.all.tmpSelectYearLayer.style.display=\"none\"' "
	s += "onchange='document.all.tmpSelectYearLayer.style.display=\"none\";"
	s += "parent.meizzTheYear = this.value; parent.meizzSetDay(parent.meizzTheYear,parent.meizzTheMonth)'>\r\n";
	var selectInnerHTML = s;
	
	for (var i = n; i < n + 90; i++)
	{
	if (i == m)
	{
		selectInnerHTML += "<option Author=wayx value='" + i + "' selected>" + i + "年" + "</option>\r\n";
	}
	else 
	{
		selectInnerHTML += "<option Author=wayx value='" + i + "'>" + i + "年" + "</option>\r\n";
	}
	}
	selectInnerHTML += "</select>";
	odatelayer.tmpSelectYearLayer.style.display="";
	odatelayer.tmpSelectYearLayer.innerHTML = selectInnerHTML;
	odatelayer.tmpSelectYear.focus();
}

function tmpSelectMonthInnerHTML(strMonth) //
{
	if (strMonth.match(/\D/)!=null){alert("！");return;}
	var m = (strMonth) ? strMonth : new Date().getMonth() + 1;
	var s = "<select Author=meizz name=tmpSelectMonth style='font-size: 12px' "
	s += "onblur='document.all.tmpSelectMonthLayer.style.display=\"none\"' "
	s += "onchange='document.all.tmpSelectMonthLayer.style.display=\"none\";"
	s += "parent.meizzTheMonth = this.value; parent.meizzSetDay(parent.meizzTheYear,parent.meizzTheMonth)'>\r\n";
	var selectInnerHTML = s;
	for (var i = 1; i < 13; i++)
	{
		if (i == m)
	   	{
			selectInnerHTML += "<option Author=wayx value='"+i+"' selected>"+i+"月"+"</option>\r\n";
		}
		else 
		{
			selectInnerHTML += "<option Author=wayx value='"+i+"'>"+i+"月"+"</option>\r\n";
		}
	}
	selectInnerHTML += "</select>";
	odatelayer.tmpSelectMonthLayer.style.display="";
	odatelayer.tmpSelectMonthLayer.innerHTML = selectInnerHTML;
	odatelayer.tmpSelectMonth.focus();
}

function closeLayer()
{
    document.getElementById("meizzDateLayer").style.display="none";
}

function IsPinYear(year) 
{
    if (0==year%4 && ((year % 100!=0)||(year%400==0))) return true;else return false;
}

function GetMonthCount(year,month)  //29
{
    var c=MonHead[month-1];if((month==2)&&IsPinYear(year)) c++;return c;
}

function GetDOW(day,month,year)
{
    var dt=new Date(year,month-1,day).getDay()/7; 
	return dt;
}

function meizzPrevY()
{
    if(meizzTheYear > 999 && meizzTheYear <10000)
	{
		meizzTheYear--;
	}
    else
	{
		alert("（1000-9999）！");
	}
    meizzSetDay(meizzTheYear,meizzTheMonth);
}

function meizzNextY()
{
    if(meizzTheYear > 999 && meizzTheYear <10000)
	{
		meizzTheYear++;
	}
    else
	{
		alert("（1000-9999）！");
	}
    meizzSetDay(meizzTheYear,meizzTheMonth);
}

/**
 * 20080912 add by pengguoqing
 */
function meizzClearDay()
{
	if(outObject)
	{
		outObject.value="";
	}
	closeLayer();
}

function meizzToday()  
{
	var today;
    meizzTheYear = new Date().getFullYear();
    meizzTheMonth = new Date().getMonth()+1;
    today=new Date().getDate();
    
    if(outObject)
	{
		outObject.value=meizzTheYear + "-" + meizzTheMonth + "-" + today;
    }
    closeLayer();
}

function meizzPrevM()
{
    if(meizzTheMonth>1)
	{
		meizzTheMonth--;
	}
	else
	{
		meizzTheYear--;
		meizzTheMonth=12;
	}
    meizzSetDay(meizzTheYear,meizzTheMonth);
}

function meizzNextM() 
{
    if(meizzTheMonth==12)
	{
		meizzTheYear++;
		meizzTheMonth=1;
	}
	else
	{
		meizzTheMonth++;
	}
    meizzSetDay(meizzTheYear,meizzTheMonth);
}

function meizzSetDay(yy,mm)
{
  meizzWriteHead(yy,mm);
  meizzTheYear=yy;
  meizzTheMonth=mm;

  for (var i = 0; i < 39; i++)
  {
	  meizzWDay[i]="";
  }
  var day1 = 1,day2=1,firstday = new Date(yy,mm-1,1).getDay();  
  for (i=0;i<firstday;i++)
  	meizzWDay[i]=GetMonthCount(mm==1?yy-1:yy,mm==1?12:mm-1)-firstday+i+1;
  for (i = firstday; day1 < GetMonthCount(yy,mm)+1; i++)
  {
	  meizzWDay[i]=day1;
	  day1++;
  }
  for (i=firstday+GetMonthCount(yy,mm);i<39;i++)
  {
	  meizzWDay[i]=day2;
	  day2++;
  }
  for (i = 0; i < 39; i++)
  { 
  	var da = eval("odatelayer.meizzDay"+i) 
    if (meizzWDay[i]!="")
    {
		da.borderColorLight="#FF9900";
		da.borderColorDark="#FFFFFF";
		if(i<firstday)	
		{
			da.innerHTML="<b><font color=gray>" + meizzWDay[i] + "</font></b>";
			da.title=(mm==1?12:mm-1) +"月" + meizzWDay[i] + "日";
			da.onclick=Function("meizzDayClick(this.innerText,-1)");
			if(!outDate)
			{
				da.style.backgroundColor = ((mm==1?yy-1:yy) == new Date().getFullYear() && (mm==1?12:mm-1) == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate()) ? "#FFD700":"#e0e0e0";
			}
			else
			{
				da.style.backgroundColor =((mm==1?yy-1:yy)==outDate.getFullYear() && (mm==1?12:mm-1)== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())? "#00ffff" : (((mm==1?yy-1:yy) == new Date().getFullYear() && (mm==1?12:mm-1) == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate()) ? "#FFD700":"#e0e0e0");
				if((mm==1?yy-1:yy)==outDate.getFullYear() && (mm==1?12:mm-1)== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())
				{
					da.borderColorLight="#FFFFFF";
					da.borderColorDark="#FF9900";
				}
			}
		}
		else if (i>=firstday+GetMonthCount(yy,mm))	
		{
			da.innerHTML="<b><font color=gray>" + meizzWDay[i] + "</font></b>";
			da.title=(mm==12?1:mm+1) +"月" + meizzWDay[i] + "日";
			da.onclick=Function("meizzDayClick(this.innerText,1)");
			if(!outDate)
			{
				da.style.backgroundColor = ((mm==12?yy+1:yy) == new Date().getFullYear() && (mm==12?1:mm+1) == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate()) ?"#FFD700":"#e0e0e0";
			}
			else
			{
				da.style.backgroundColor =((mm==12?yy+1:yy)==outDate.getFullYear() && (mm==12?1:mm+1)== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())? "#00ffff" :(((mm==12?yy+1:yy) == new Date().getFullYear() && (mm==12?1:mm+1) == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate()) ? "#FFD700":"#e0e0e0");
				if((mm==12?yy+1:yy)==outDate.getFullYear() && (mm==12?1:mm+1)== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())
				{
					da.borderColorLight="#FFFFFF";
					da.borderColorDark="#FF9900";
				}
			}
		}
		else
		{
			da.innerHTML="<b>" + meizzWDay[i] + "</b>";
			da.title=mm +"月" + meizzWDay[i] + "日";
			da.onclick=Function("meizzDayClick(this.innerText,0)");	

			if(!outDate)
			{
				da.style.backgroundColor = (yy == new Date().getFullYear() && mm == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate())?"#FFD700":"#e0e0e0";
			}
			else
			{
				da.style.backgroundColor =(yy==outDate.getFullYear() && mm== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())? "#00ffff":((yy == new Date().getFullYear() && mm == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate())?	"#FFD700":"#e0e0e0");
				if(yy==outDate.getFullYear() && mm== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())
				{
					da.borderColorLight="#FFFFFF";
					da.borderColorDark="#FF9900";
				}
			}
		}
        da.style.cursor="hand"
      }
    else
	{
		da.innerHTML="";
		da.style.backgroundColor="";
		da.style.cursor="default";
	}
  }
}

function meizzDayClick(n,ex)
{
	var yy=meizzTheYear;
	var mm = parseInt(meizzTheMonth)+ex;	
	if(mm<1)
	{
		yy--;
		mm=12+mm;
	}
	else if(mm>12)
	{
		yy++;
		mm=mm-12;
	}
	
	if (mm < 10)
	{
	  mm = "0" + mm;
	}
	if (outObject)
	{
		if (!n) 
		{
	  		return;
		}
		if ( n < 10)
		{
			n = "0" + n;
		}
		outObject.value= yy + "-" + mm + "-" + n ; 
		closeLayer();
	}
	else 
	{
	  closeLayer(); 
	  alert("！");
	}
}