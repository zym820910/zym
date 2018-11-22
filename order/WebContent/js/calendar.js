// JavaScript Document
   
  <!--   
  //========================================================================================================================   
  document.writeln   ('<div   id=DayShow   style="position:absolute;width:142;height:166;top:68;left:1;z-index:99;display:none">');   
  document.writeln   ('<table   border=0   cellspacing=1   cellpadding=0   width=142   height=160   bgcolor=#808080   style="font-size:12px">');   
  document.writeln   ('<tr><td   width=142   height=22   bgcolor=#FFFFFF><table   border=0   cellspacing=1   cellpadding=0   width=140   height=22>');   
  document.writeln   ('<tr   align=center><td   width=25   align=left   bgcolor=#808080   style="font-size:12px;cursor:   hand"   onclick=prev()>');   
  document.writeln   ('<font   color=#FFD700   face="Wingdings   3">Pre</font><span   style="color:   #FFD700"><b></b></span>');   
  document.writeln   ('</td><td   width=90><span   style="font-size:12px;cursor:default"   id=thehead></span></td>');   
  document.writeln   ('<td   width=25   bgcolor=#808080   align=right   style="font-size:12px;cursor:   hand"   onclick=next()>');   
  document.writeln   ('<span   style="color:   #FFD700"></span><font   color=#FFD700   face="Wingdings   3">Next</font></td></tr>');   
  document.writeln   ('</table></td></tr><tr><td   width=142   height=18   bgcolor=#808080>');   
  document.writeln   ('<table   border=0   cellspacing=0   cellpadding=0   width=140   height=1   style="cursor:default">');   
  document.writeln   ('<tr   align=center><td   style="font-size:12px;color:#FFFFFF">日</td>');   
  document.writeln   ('<td   style="font-size:12px;color:#FFFFFF">一</td><td   style="font-size:12px;color:#FFFFFF">二</td>');   
  document.writeln   ('<td   style="font-size:12px;color:#FFFFFF">三</td><td   style="font-size:12px;color:#FFFFFF">四</td>');   
  document.writeln   ('<td   style="font-size:12px;color:#FFFFFF">五</td><td   style="font-size:12px;color:#FFFFFF">六</td></tr>');   
  document.writeln   ('</table></td></tr><tr><td   width=142   height=120><!--Author:F.R.Huang(meizz)-->');   
  document.writeln   ('<table   border=0   cellspacing=1   cellpadding=0   width=140   height=120   bgcolor=#FFFFFF>');   
  var   n=0;   for   (j=0;j<5;j++){   document.writeln   ('<tr   align=center>');for   (i=0;i<7;i++){   
  document.writeln   ('<td   width=20   height=20   id=D'+n+'   style="font-size:12px"   onclick=DayClick(this.innerText)></td>');   n++;}   
  document.writeln   ('</tr>');}   
  document.writeln   ('<tr   align=center><td   width=20   height=20   style="font-size:12px"   id=D35   onclick=DayClick(this.innerText)></td>');   
  document.writeln   ('<td   width=20   height=20   style="font-size:12px"   id=D36   onclick=DayClick(this.innerText)></td>');   
  document.writeln   ('<td   colspan=5   align=right><span   onclick=closelayer()   style="font-size:12px;cursor:   hand"');   
  document.writeln   ('><u>关闭</u></span>&nbsp;</td></tr></table></td></tr></table></div>');   
  //=============================================================================================   
    
  var   TObject;   
  function   setday(tt,obj){   
      var   dads     =   document.all.DayShow.style;   
      var   ttop     =   tt.offsetTop;           //TT控件的定位点高   
      var   thei     =   tt.clientHeight;     //TT控件本身的高   
      var   tleft   =   tt.offsetLeft;         //TT控件的定位点宽   
      var   ttyp     =   tt.type;                     //TT控件的类型   
      while   (tt   =   tt.offsetParent){ttop+=tt.offsetTop;   tleft+=tt.offsetLeft;}   
      dads.top     =   (ttyp=="image")?   ttop+thei   :   ttop+thei+6;   
      dads.left   =   tleft;         dads.display   =   '';   
      TObject       =   obj;             event.returnValue=false;   
      }   
  var   MonHead=new   Array(12);MonHead[0]=31;MonHead[1]=28;MonHead[2]=31;MonHead[3]=30;MonHead[4]=31;MonHead[5]=30;   
          MonHead[6]=31;MonHead[7]=31;MonHead[8]=30;MonHead[9]=31;MonHead[10]=30;MonHead[11]=31;   
          //定义阳历中每个月的最大天数   
  var   TheYear=new   Date().getFullYear();           //定义年的变量的初始值   
  var   TheMonth=new   Date().getMonth()+1;           //定义月的变量的初始值   
  var   wday=new   Array(37);   
  document.all.thehead.innerText=TheYear+"   年   "+TheMonth+"   月"             //往   thehead   中写入当前的年与月   
  function   closelayer(){document.all.DayShow.style.display="none";}   //这个层的关闭   
  function   cennalclose(){if(window.event.keyCode==27)document.all.DayShow.style.display="none";}   
  function   IsPinYear(year){   if(0==year%4&&((year%100!=0)||(year%400==0)))   return   true;else   return   false;}   //判断是否闰平年   
  function   GetMonthCount(year,month){var   c=MonHead[month-1];if((month==2)&&IsPinYear(year))   c++;return   c;}   //闰年二月为29日   
  function   GetDOW(day,month,year){var   dt=new   Date(year,month-1,day).getDay()/7;   return   dt;}         //求某天的星期几   
  function   prev(){if(TheMonth>1){TheMonth--}else{TheYear--;TheMonth=12;}       
      document.all.thehead.innerText=TheYear+"   年   "+TheMonth+"   月";SetD(TheYear,TheMonth);               //往前翻日期   
      }   
  function   next(){if(TheMonth==12){TheYear++;TheMonth=1}else{TheMonth++}   
      document.all.thehead.innerText=TheYear+"   年   "+TheMonth+"   月";   SetD(TheYear,TheMonth);             //往后翻日期   
      }   
  function   SetD(yy,mm){   
    for   (i=0;i<37;i++){wday[i]=""};     //将显示框的内容全部清空   
    var   day1=1,firstday=new   Date(yy,mm-1,1).getDay()     //某月第一天的星期几   
    for   (i=firstday;day1<GetMonthCount(yy,mm)+1;i++){wday[i]=day1;day1++;};   
    for   (i=0;i<37;i++){   var   da   =   eval("document.all.D"+i)     //书写新的一个月的日期星期排列   
    if   (wday[i]!=""){da.innerHTML=wday[i];da.style.backgroundColor="#DAE3FC";da.style.cursor="hand"}   
    else{da.innerHTML="";da.style.backgroundColor="";da.style.cursor="default"}}   
    }   
  function   DayClick(n){     //点击显示框选取日期   
    var   t1=TheYear;var   t2=TheMonth;   
    if   (t2<10){t2="0"+t2;}   
    if   (n<10){n="0"+n;}   
    if   (n!=""){TObject.value=t1+""+t2+""+n;document.all.DayShow.style.display='none';}   
    else{TObject.value=""}   
    }   
  SetD(TheYear,TheMonth)   
  document.onkeydown=cennalclose   
  //   -->   
