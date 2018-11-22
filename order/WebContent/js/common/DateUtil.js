// 判断闰年   
//---------------------------------------------------   
Date.prototype.isLeapYear = function()    
{    
    return (0==this.getYear()%4&&((this.getYear()%100!=0)||(this.getYear()%400==0)));    
}    
   
// ---------------------------------------------------
// 日期格式化
// 格式 YYYY/yyyy/YY/yy 表示年份
// MM/M 月份
// W/w 星期
// dd/DD/d/D 日期
// hh/HH/h/H 时间
// mm/m 分钟
// ss/SS/s/S 秒
// ---------------------------------------------------
Date.prototype.Format = function(formatStr)    
{    
    var str = formatStr;    
    var Week = ['日','一','二','三','四','五','六'];   
   
    str=str.replace(/yyyy|YYYY/,this.getFullYear());    
    str=str.replace(/yy|YY/,(this.getYear() % 100)>9?(this.getYear() % 100).toString():'0' + (this.getYear() % 100));    
   
    str=str.replace(/MM/,this.getMonth()>9?this.getMonth().toString():'0' + this.getMonth());    
    str=str.replace(/M/g,this.getMonth());    
   
    str=str.replace(/w|W/g,Week[this.getDay()]);    
   
    str=str.replace(/dd|DD/,this.getDate()>9?this.getDate().toString():'0' + this.getDate());    
    str=str.replace(/d|D/g,this.getDate());    
   
    str=str.replace(/hh|HH/,this.getHours()>9?this.getHours().toString():'0' + this.getHours());    
    str=str.replace(/h|H/g,this.getHours());    
    str=str.replace(/mm/,this.getMinutes()>9?this.getMinutes().toString():'0' + this.getMinutes());    
    str=str.replace(/m/g,this.getMinutes());    
   
    str=str.replace(/ss|SS/,this.getSeconds()>9?this.getSeconds().toString():'0' + this.getSeconds());    
    str=str.replace(/s|S/g,this.getSeconds());    
   
    return str;    
}    
   
// +---------------------------------------------------
// | 求两个时间的天数差 日期格式为 YYYY-MM-dd
// +---------------------------------------------------
function daysBetween(DateOne,DateTwo)   
{    
    var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ('-'));   
    var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ('-')+1);   
    var OneYear = DateOne.substring(0,DateOne.indexOf ('-'));   
   
    var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ('-'));   
    var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ('-')+1);   
    var TwoYear = DateTwo.substring(0,DateTwo.indexOf ('-'));   
   
    var cha=((Date.parse(OneMonth+'/'+OneDay+'/'+OneYear)- Date.parse(TwoMonth+'/'+TwoDay+'/'+TwoYear))/86400000);    
    return Math.abs(cha);   
}   
   
   
// +---------------------------------------------------
// | 日期计算
// +---------------------------------------------------
Date.prototype.DateAdd = function(strInterval, Number) {    
    var dtTmp = this;   
    switch (strInterval) {    
        case 's' :return new Date(Date.parse(dtTmp) + (1000 * Number));   
        case 'n' :return new Date(Date.parse(dtTmp) + (60000 * Number));   
        case 'h' :return new Date(Date.parse(dtTmp) + (3600000 * Number));   
        case 'd' :return new Date(Date.parse(dtTmp) + (86400000 * Number));   
        case 'w' :return new Date(Date.parse(dtTmp) + ((86400000 * 7) * Number));   
        case 'q' :return new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + Number*3, dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());   
        case 'm' :return new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + Number, dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());   
        case 'y' :return new Date((dtTmp.getFullYear() + Number), dtTmp.getMonth(), dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());   
    }   
}   
   
// +---------------------------------------------------
// | 比较日期差 dtEnd 格式为日期型或者 有效日期格式字符串
// +---------------------------------------------------
Date.prototype.DateDiff = function(strInterval, dtEnd) {    
    var dtStart = this;   
    if (typeof dtEnd == 'string' )// 如果是字符串转换为日期型
    {    
        dtEnd = StringToDate(dtEnd);   
    }   
    switch (strInterval) {    
        case 's' :return parseInt((dtEnd - dtStart) / 1000);   
        case 'n' :return parseInt((dtEnd - dtStart) / 60000);   
        case 'h' :return parseInt((dtEnd - dtStart) / 3600000);   
        case 'd' :return parseInt((dtEnd - dtStart) / 86400000);   
        case 'w' :return parseInt((dtEnd - dtStart) / (86400000 * 7));   
        case 'm' :return (dtEnd.getMonth()+1)+((dtEnd.getFullYear()-dtStart.getFullYear())*12) - (dtStart.getMonth()+1);   
        case 'y' :return dtEnd.getFullYear() - dtStart.getFullYear();   
    }   
}   
   
// +---------------------------------------------------
// | 日期输出字符串，重载了系统的toString方法
// +---------------------------------------------------
Date.prototype.toString = function(showWeek)   
{    
    var myDate= this;   
    var str = myDate.toLocaleDateString();   
    if (showWeek)   
    {    
        var Week = ['日','一','二','三','四','五','六'];   
        str += ' 星期' + Week[myDate.getDay()];   
    }   
    return str;   
}   
   
// +---------------------------------------------------
// | 日期合法性验证
// | 格式为：YYYY-MM-DD或YYYY/MM/DD
// +---------------------------------------------------
function IsValidDate(DateStr)    
{    
	var sDate=DateStr.replace(/(^\s+|\s+$)/g,''); //去两边空格;    
    if(sDate=='') return false;    
    //如果格式满足YYYY-(/)MM-(/)DD或YYYY-(/)M-(/)DD或YYYY-(/)M-(/)D或YYYY-(/)MM-(/)D就替换为''    
    //数据库中，合法日期可以是:YYYY-MM/DD(2003-3/21),数据库会自动转换为YYYY-MM-DD格式    
    var s = sDate.replace(/[\d]{ 4,4 }[\-/]{ 1 }[\d]{ 1,2 }[\-/]{ 1 }[\d]{ 1,2 }/g,'');    
    if (s=='') //说明格式满足YYYY-MM-DD或YYYY-M-DD或YYYY-M-D或YYYY-MM-D    
    {    
        var t=new Date(sDate.replace(/\-/g,'/'));    
        var ar = sDate.split(/[-/:]/);    
        if(ar[0] != t.getYear() || ar[1] != t.getMonth()+1 || ar[2] != t.getDate())    
        {    
            //alert('错误的日期格式！格式为：YYYY-MM-DD或YYYY/MM/DD。注意闰年。');    
            return false;    
        }    
    }    
    else    
    {    
        //alert('错误的日期格式！格式为：YYYY-MM-DD或YYYY/MM/DD。注意闰年。');    
        return false;    
    }    
    return true;      
}    
   
// +---------------------------------------------------
// | 日期时间检查
// | 格式为：YYYY-MM-DD HH:MM:SS
// +---------------------------------------------------
function CheckDateTime(str)   
{    
    var reg = /^(\d+)-(\d{ 1,2 })-(\d{ 1,2 }) (\d{ 1,2 }):(\d{ 1,2 }):(\d{ 1,2 })$/;    
    var r = str.match(reg);    
    if(r==null)return false;    
    r[2]=r[2]-1;    
    var d= new Date(r[1],r[2],r[3],r[4],r[5],r[6]);    
    if(d.getFullYear()!=r[1])return false;    
    if(d.getMonth()!=r[2])return false;    
    if(d.getDate()!=r[3])return false;    
    if(d.getHours()!=r[4])return false;    
    if(d.getMinutes()!=r[5])return false;    
    if(d.getSeconds()!=r[6])return false;    
    return true;    
}    
   
// +---------------------------------------------------
// | 把日期分割成数组
// +---------------------------------------------------
Date.prototype.toArray = function()   
{    
    var myDate = this;   
    var myArray = Array();   
    myArray[0] = myDate.getFullYear();   
    myArray[1] = myDate.getMonth();   
    myArray[2] = myDate.getDate();   
    myArray[3] = myDate.getHours();   
    myArray[4] = myDate.getMinutes();   
    myArray[5] = myDate.getSeconds();   
    return myArray;   
}   
   
// +---------------------------------------------------
// | 取得日期数据信息
// | 参数 interval 表示数据类型
// | y 年 m月 d日 w星期 ww周 h时 n分 s秒
// +---------------------------------------------------
Date.prototype.DatePart = function(interval)   
{    
    var myDate = this;   
    var partStr='';   
    var Week = ['日','一','二','三','四','五','六'];   
    switch (interval)   
    {    
        case 'y' :partStr = myDate.getFullYear();break;   
        case 'm' :partStr = myDate.getMonth()+1;break;   
        case 'd' :partStr = myDate.getDate();break;   
        case 'w' :partStr = Week[myDate.getDay()];break;   
        case 'ww' :partStr = myDate.WeekNumOfYear();break;   
        case 'h' :partStr = myDate.getHours();break;   
        case 'n' :partStr = myDate.getMinutes();break;   
        case 's' :partStr = myDate.getSeconds();break;   
    }   
    return partStr;   
}   
   
// +---------------------------------------------------
// | 取得当前日期所在月的最大天数
// +---------------------------------------------------
Date.prototype.MaxDayOfDate = function()   
{    
    var myDate = this;   
    var ary = myDate.toArray();   
    var date1 = (new Date(ary[0],ary[1]+1,1));   
    var date2 = date1.dateAdd(1,'m',1);   
    var result = dateDiff(date1.Format('yyyy-MM-dd'),date2.Format('yyyy-MM-dd'));   
    return result;   
}   
   
// +---------------------------------------------------
// | 取得当前日期所在周是一年中的第几周
// +---------------------------------------------------
Date.prototype.WeekNumOfYear = function()   
{    
    var myDate = this;   
    var ary = myDate.toArray();   
    var year = ary[0];   
    var month = ary[1]+1;   
    var day = ary[2];      
    return result;   
}   
   
// +---------------------------------------------------
// | 字符串转成日期类型
// | 格式 MM/dd/YYYY MM-dd-YYYY YYYY/MM/dd YYYY-MM-dd
// +---------------------------------------------------
function StringToDate(DateStr)   
{    
   
    var converted = Date.parse(DateStr);   
    var myDate = new Date(converted);   
    if (isNaN(myDate))   
    {    
        // var delimCahar = DateStr.indexOf('/')!=-1?'/':'-';
        var arys= DateStr.split('-');   
        myDate = new Date(arys[0],--arys[1],arys[2]);   
    }   
    return myDate;   
}

// +---------------------------------------------------
// | 获取当月总天数
// | 格式 MM/dd/YYYY MM-dd-YYYY YYYY/MM/dd YYYY-MM-dd
// +---------------------------------------------------

Date.prototype.Monthdays=function()
{
	var dtStart = this; 
	Year= dtStart.getYear() 
	var monthar   = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	if(Year%400==0||(Year%4==0&&Year%100!=0)) monthar[1]=   29;
	return monthar[dtStart.getMonth()];

}

/*
 * 
 * Date (对象) Date 对象能够使你获得相对于国际标准时间（格林威治标准时间，现在被称为 UTC-Universal Coordinated
 * Time）或者是 Flash 播放器正运行的操作系统的时间和日期。要使用Date对象的方法，你就必须先创建一个Date对象的实体（Instance）。
 * 
 * Date 对象必须使用 Flash 5 或以后版本的播放器。
 * 
 * Date 对象的方法并不是静态的，但是在使用时却可以应用于所指定的单独实体。
 * 
 * Date 对象的方法简介：
 * 
 * ·getDate ｜ 根据本地时间获取当前日期(本月的几号) ·getDay ｜ 根据本地时间获取今天是星期几(0-Sunday,1-Monday...)
 * ·getFullYear ｜ 根据本地时间获取当前年份(四位数字) ·getHours ｜ 根据本地时间获取当前小时数(24小时制,0-23)
 * ·getMilliseconds ｜ 根据本地时间获取当前毫秒数 ·getMinutes ｜ 根据本地时间获取当前分钟数 ·getMonth ｜
 * 根据本地时间获取当前月份(注意从0开始:0-Jan,1-Feb...) ·getSeconds ｜ 根据本地时间获取当前秒数 ·getTime ｜
 * 获取UTC格式的从1970.1.1 0:00以来的毫秒数 ·getTimezoneOffset ｜ 获取当前时间和UTC格式的偏移值(以分钟为单位)
 * ·getUTCDate ｜ 获取UTC格式的当前日期(本月的几号) ·getUTCDay ｜
 * 获取UTC格式的今天是星期几(0-Sunday,1-Monday...) ·getUTCFullYear ｜ 获取UTC格式的当前年份(四位数字)
 * ·getUTCHours ｜ 获取UTC格式的当前小时数(24小时制,0-23) ·getUTCMilliseconds ｜ 获取UTC格式的当前毫秒数
 * ·getUTCMinutes ｜ 获取UTC格式的当前分钟数 ·getUTCMonth ｜
 * 获取UTC格式的当前月份(注意从0开始:0-Jan,1-Feb...) ·getUTCSeconds ｜ 获取UTC格式的当前秒数 ·getYear ｜
 * 根据本地时间获取当前缩写年份(当前年份减去1900) ·setDate ｜ 设置当前日期(本月的几号) ·setFullYear ｜
 * 设置当前年份(四位数字) ·setHours ｜ 设置当前小时数(24小时制,0-23) ·setMilliseconds ｜ 设置当前毫秒数
 * ·setMinutes ｜ 设置当前分钟数 ·setMonth ｜ 设置当前月份(注意从0开始:0-Jan,1-Feb...) ·setSeconds ｜
 * 设置当前秒数 ·setTime ｜ 设置UTC格式的从1970.1.1 0:00以来的毫秒数 ·setUTCDate ｜
 * 设置UTC格式的当前日期(本月的几号) ·setUTCFullYear ｜ 设置UTC格式的当前年份(四位数字) ·setUTCHours ｜
 * 设置UTC格式的当前小时数(24小时制,0-23) ·setUTCMilliseconds ｜ 设置UTC格式的当前毫秒数 ·setUTCMinutes ｜
 * 设置UTC格式的当前分钟数 ·setUTCMonth ｜ 设置UTC格式的当前月份(注意从0开始:0-Jan,1-Feb...)
 * ·setUTCSeconds ｜ 设置UTC格式的当前秒数 ·setYear ｜ 设置当前缩写年份(当前年份减去1900) ·toString ｜
 * 将日期时间值转换成"日期/时间"形式的字符串值 ·Date.UTC ｜ 返回指定的UTC格式日期时间的固定时间值
 * 
 * 创建新的 Date 对象
 * 
 * 语法： new Date(); new Date(year [, month [, date [, hour [, minute [, second [,
 * millisecond ]]]]]] ); 参数： year 是一个 0 到 99 之间的整数，对应于 1900 到 1999
 * 年，或者为四位数字指定确定的年份； month 是一个 0 (一月) 到 11 (十二月) 之间的整数，这个参数是可选的； date 是一个 1 到 31
 * 之间的整数，这个参数是可选的； hour 是一个 0 (0:00am) 到 23 (11:00pm) 之间的整数，这个参数是可选的； minute 是一个
 * 0 到 59 之间的整数，这个参数是可选的； second 是一个 0 到 59 之间的整数，这个参数是可选的； millisecond 是一个 0 到
 * 999 之间的整数，这个参数是可选的； 注释： 对象。新建一个 Date 对象。 播放器支持： Flash 5 或以后的版本。 例子：
 * 下面是获得当前日期和时间的例子： now = new Date(); 下面创建一个关于国庆节的 Date 对象的例子： national_day =
 * new Date (49, 10, 1); 下面是新建一个 Date 对象后，利用 Date 对象的 getMonth、getDate、和
 * getFullYear方法获取时间，然后在动态文本框中输出的例子。 myDate = new Date(); dateTextField =
 * (mydate.getMonth() + "/" + myDate.getDate() + "/" + mydate.getFullYear());
 * 
 * 
 * Date > Date.getDate Date.getDate
 * 
 * 语法：myDate.getDate(); 参数：无 注释： 方法。根据本地时间获取当前日期(本月的几号)，返回值是 1 到 31 之间的一个整数。
 * 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getDay Date.getDay
 * 
 * 语法：myDate.getDay(); 参数：无 注释： 方法。根据本地时间获取今天是星期几(0-星期日，1-星期一...)。本地时间由 Flash
 * 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getFullYear Date.getFullYear
 * 
 * 语法：myDate.getFullYear(); 参数：无 注释： 方法。根据本地时间获取当前年份(四位数字，例如 2000)。本地时间由 Flash
 * 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。 例子： 下面的例子新建了一个 Date 对象，然后在输出窗口输出用
 * getFullYear 方法获得的年份： myDate = new Date(); trace(myDate.getFullYear());
 * 
 * Date > Date.getHours Date.getHours
 * 
 * 语法：myDate.getHours(); 参数：无 注释： 方法。根据本地时间获取当前小时数(24小时制，返回值为0-23之间的整数)。本地时间由
 * Flash 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getMilliseconds Date.getMilliseconds
 * 
 * 语法：myDate.getMilliseconds(); 参数：无 注释： 方法。根据本地时间获取当前毫秒数(返回值是 0 到 999
 * 之间的一个整数)。本地时间由 Flash 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getMinutes Date.getMinutes
 * 
 * 语法：myDate.getMinutes(); 参数：无 注释： 方法。根据本地时间获取当前分钟数(返回值是 0 到 59 之间的一个整数)。本地时间由
 * Flash 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getMonth Date.getMonth
 * 
 * 语法：myDate.getMonth(); 参数：无 注释： 方法。根据本地时间获取当前月份(注意从0开始:0-一月,1-二月...)。本地时间由
 * Flash 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getSeconds Date.getSeconds
 * 
 * 语法：myDate.getSeconds(); 参数：无 注释： 方法。根据本地时间获取当前秒数(返回值是 0 到 59 之间的一个整数)。本地时间由
 * Flash 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getTime Date.getTime
 * 
 * 语法：myDate.getTime(); 参数：无 注释：
 * 方法。按UTC格式返回从1970年1月1日0:00am起到现在的毫秒数。使用这个方法可以描述不同时区里的同一瞬间的时间。 播放器支持：Flash 5
 * 或以后版本。
 * 
 * Date > Date.getTimezoneOffset Date.getTimezoneOffset
 * 
 * 语法：mydate.getTimezoneOffset(); 参数：无 注释： 方法。获取当前时间和UTC格式的偏移值(以分钟为单位)。
 * 播放器支持：Flash 5 或以后版本。 例子： 下面的例子将返回北京时间与UTC时间之间的偏移值。 new
 * Date().getTimezoneOffset(); 结果如下： 480 (8 小时 * 60 分钟/小时 = 480 分钟)
 * 
 * Date > Date.getUTCDate Date.getUTCDate
 * 
 * 语法：myDate.getUTCDate(); 参数：无 注释： 方法。获取UTC格式的当前日期(本月的几号)。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getUTCDay Date.getUTCDay
 * 
 * 语法：myDate.getUTCDate(); 参数：无 注释： 方法。获取UTC格式的今天是星期几(0-星期日，1-星期一...)。
 * 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getUTCFullYear Date.getUTCFullYear
 * 
 * 语法：myDate.getUTCFullYear(); 参数：无 注释： 方法。获取UTC格式的当前年份(四位数字)。 播放器支持：Flash 5
 * 或以后版本。
 * 
 * Date > Date.getUTCHours Date.getUTCHours
 * 
 * 语法：myDate.getUTCHours(); 参数：无 注释： 方法。获取UTC格式的当前小时数(24小时制,返回值为0-23之间的一个整数)。
 * 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getUTCMilliseconds Date.getUTCMilliseconds
 * 
 * 语法：myDate.getUTCMilliseconds(); 参数：无 注释： 方法。获取UTC格式的当前毫秒数(返回值是 0 到 999
 * 之间的一个整数)。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getUTCMinutes Date.getUTCMinutes
 * 
 * 语法：myDate.getUTCMinutes(); 参数：无 注释： 方法。获取UTC格式的当前分钟数(返回值是 0 到 59 之间的一个整数)。
 * 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getUTCMonth Date.getUTCMonth
 * 
 * 语法：myDate.getUTCMonth(); 参数：无 注释： 方法。获取UTC格式的当前月份(注意从0开始:0-一月,1-二月...)。
 * 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getUTCSeconds Date.getUTCSeconds
 * 
 * 语法：myDate.getUTCSeconds(); 参数：无 注释： 方法。获取UTC格式的当前秒数(返回值是 0 到 59 之间的一个整数)。
 * 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.getYear Date.getYear
 * 
 * 语法：myDate.getYear(); 参数：无 注释： 方法。根据本地时间获取当前缩写年份(当前年份减去1900)。本地时间由 Flash
 * 播放器所运行的操作系统决定。例如 2000 年用100来表示。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setDate Date.setDate
 * 
 * 语法：myDate.setDate(date); 参数：date 为 1 到 31 之间的一个整数。 注释：
 * 方法。根据本地时间设置当前日期(本月的几号)。本地时间由 Flash 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setFullYear Date.setFullYear
 * 
 * 语法：myDate.setFullYear(year [, month [, date]] ); 参数： year
 * 指定的四位整数代表指定年份，二位数字并不代表年份，如99不表示1999，只表示公元99年 month 是一个从 0 (一月) 到 11 (十二月)
 * 之间的整数，这个参数是可选的。 date 是一个从 1 到 31 之间的整数，这个参数是可选的。 注释： 方法。根据本地时间设定年份。如果设定了
 * month 和 date 参数，将同时设定月份和日期。本地时间由 Flash 播放器所运行的操作系统决定。设定之后 getUTCDay 和 getDay
 * 方法所获得的值将出现相应的变化。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setHours Date.setHours
 * 
 * 语法：myDate.setHours(hour); 参数：hour 是一个从 0 (0:00am) 到 23 (11:00pm) 之间的整数。 注释：
 * 方法。根据本地时间设置当前小时数。本地时间由 Flash 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setMilliseconds Date.setMilliseconds
 * 
 * 语法：myDate.setMilliseconds(millisecond); 参数：millisecond 是一个从 0 到 999 之间的整数。
 * 注释： 方法。根据本地时间设置当前毫秒数。本地时间由 Flash 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。
 * 
 * 
 * Date > Date.setMinutes Date.setMinutes
 * 
 * 语法：myDate.setMinutes(minute); 参数：minute 是一个从 0 到 59 之间的整数。 注释：
 * 方法。根据本地时间设置当前分钟数。本地时间由 Flash 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setMonth Date.setMonth
 * 
 * 语法：myDate.setMonth(month [, date ]); 参数： month 是一个从 0 (一月) 到 11 (十二月)之间的整数
 * date 是一个从 1 到 31 之间的整数，这个参数是可选的。 注释： 方法。根据本地时间设置当前月份数，如果选用了 date
 * 参数，将同时设定日期。本地时间由 Flash 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setSeconds Date.setSeconds
 * 
 * 语法：myDate.setSeconds(second); 参数：second 是一个从 0 到 59 之间的整数。 注释：
 * 方法。根据本地时间设置当前秒数。本地时间由 Flash 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setTime Date.setTime
 * 
 * 语法：myDate.setTime(millisecond); 参数：millisecond 是一个从 0 到 999 之间的整数。 注释：
 * 方法。用毫秒数来设定指定的日期。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setUTCDate Date.setUTCDate
 * 
 * 语法：myDate.setUTCDate(date); 参数：date 是一个从 1 到 31 之间的整数。 注释：
 * 方法。按UTC格式设定日期，使用本方法将不会影响 Date 对象的其他字段的值，但是 getUTCDay 和 getDay
 * 方法会返回日期更改过后相应的新值。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setUTCFullYear Date.setUTCFullYear
 * 
 * 语法：myDate.setUTCFullYear(year [, month [, date]]); 参数： year 代表年份的四位整数，如 2000
 * month 一个从 0 (一月) 到 11 (十二月)之间的整数，可选参数。 date 一个从 1 到 31 之间的整数，可选参数。 注释：
 * 方法。按UTC格式设定年份，如果使用了可选参数，还同时设定月份和日期。设定过后 getUTCDay 和 getDay 方法会返回一个相应的新值。
 * 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setUTCHours Date.setUTCHours
 * 
 * 语法：myDate.setUTCHours(hour [, minute [, second [, millisecond]]])); 参数： hour
 * 是一个从 0 (0:00am) 到 23 (11:00pm)之间的整数。 minute 是一个从 0 到 59 之间的整数，可选参数。 second
 * 是一个从 0 到 59 之间的整数，可选参数。 millisecond 是一个从 0 到 999 之间的整数，可选参数。 注释：
 * 方法。设定UTC格式的小时数，如果是用可选参数，同时会设定分钟、秒和毫秒值。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setUTCMilliseconds Date.setUTCMilliseconds
 * 
 * 语法：myDate.setUTCMilliseconds(millisecond); 参数：millisecond 是一个从 0 到 999 之间的整数。
 * 注释： 方法。设定UTC格式的毫秒数。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setUTCMinutes Date.setUTCMinutes
 * 
 * 语法：myDate.setUTCMinutes(minute [, second [, millisecond]])); 参数： minute 是一个从
 * 0 到 59 之间的整数，可选参数。 second 是一个从 0 到 59 之间的整数，可选参数。 millisecond 是一个从 0 到 999
 * 之间的整数，可选参数。 注释： 方法。设定UTC格式的分钟数，如果是用可选参数，同时会设定秒和毫秒值。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setUTCMonth Date.setUTCMonth
 * 
 * 语法：myDate.setUTCMonth(month [, date]); 参数： month 是一个从 0 (一月) 到 11 (十二月)之间的整数
 * date 是一个从 1 到 31 之间的整数，这个参数是可选的。 注释： 方法。设定UTC格式的月份，同时可选设置日期。设定后 getUTCDay 和
 * getDay 方法会返回相应的新值。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setUTCSeconds Date.setUTCSeconds
 * 
 * 语法：myDate.setUTCSeconds(second [, millisecond])); 参数： second 是一个从 0 到 59
 * 之间的整数，可选参数。 millisecond 是一个从 0 到 999 之间的整数，可选参数。 注释：
 * 方法。设定UTC格式的秒数，如果是用可选参数，同时会设定毫秒值。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.setYear Date.setYear
 * 
 * 语法：myDate.setYear(year); 参数：year 是一个代表年份的四位整数，如 2000。 注释： 方法。根据本地时间设定年份。本地时间由
 * Flash 播放器所运行的操作系统决定。 播放器支持：Flash 5 或以后版本。
 * 
 * Date > Date.toString Date.toString
 * 
 * 语法：myDate.toString(); 参数：无 注释： 方法。将日期时间值转换成"日期/时间"形式的字符串值 播放器支持：Flash 5
 * 或以后版本。 例子： 下面的例子将国庆节的 national_day 对象输出成可读的字符串： var national_day =
 * newDate(49, 9, 1, 10, 00); trace (national_day.toString()); Output (for
 * Pacific Standard Time): 结果为：Sat Oct 1 10:00:00 GMT+0800 1949
 * 
 * Date > Date.UTC Date.UTC
 * 
 * 语法：Date.UTC(year, month [, date [, hour [, minute [, second [, millisecond
 * ]]]]]); 参数： year 代表年份的四位整数，如 2000 month 一个从 0 (一月) 到 11 (十二月)之间的整数。 date 一个从
 * 1 到 31 之间的整数，可选参数。 hour 是一个从 0 (0:00am) 到 23 (11:00pm)之间的整数。 minute 是一个从 0 到
 * 59 之间的整数，可选参数。 second 是一个从 0 到 59 之间的整数，可选参数。 millisecond 是一个从 0 到 999
 * 之间的整数，可选参数。 注释： 方法。返回指定时间距 1970 年 1 月 1 日 0:00am
 * 的毫秒数。这是一个静态的方法，不需要特定的对象。它能够创建一个新的 UTC 格式的 Date 对象，而 new Date() 所创建的是本地时间的
 * Date 对象。 播放器支持：Flash 5 或以后版本。
 */
