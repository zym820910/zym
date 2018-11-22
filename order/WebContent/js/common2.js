function setBillNoEnable(name, flag){
	var t = $n(name)[0];
	t.disabled = flag;
	if(flag){
		t.style.background ='#999999'
	}else{
		t.style.background ='#FFFFFF'
	}
}

/**四舍五入，精确到小数点后2位**/
function parseFloat2(str){

	if(str != null){
		return parseFloat(str).toFixed(2);
	}else{
		return '';
	}
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
if (window.attachEvent) {
	window.attachEvent("onload", iframeAutoFit);
    //window.attachEvent("onresize",  iframeAutoFit);
} else {
	if (window.addEventListener) {
		window.addEventListener("load", iframeAutoFit, false);
    //window.addEventListener('resize',  iframeAutoFit,  false);
	}
}
/**
	判断是否整数

	negative	是否接受负数
*/
function isInteger(c, negative) {
	var reg = (negative) ? /^[-|+]?\d+$/ : /^\d+$/;
	return reg.test(c);
}
/**
	判断是否数

	negative	是否接受负数
*/
function isNumber(c, negative) {
	var reg = (negative) ? /^[-|+]?\d+(\.\d+)?$/ : /^\d+(\.\d+)?$/;
	return reg.test(c);
}
/**
	判断是否字符（数字和英文字母）
*/
function isChar(c) {
	var reg = "^[a-zA-Z0-9]*$";
	var rg = new RegExp(reg);
	return rg.test(c);
}
/**
    日期大小校验，如果date1 > date2 则返回false;
*/
function datecompare(date1, date2) {
	var d1 = new Date(date1.replace(/\-/g, "/"));
	var d2 = new Date(date2.replace(/\-/g, "/"));
	var flag = true;
	if (d1 == "NaN" || d2 == "NaN") {
		flag = false;
	}//不是日期
	if (flag && d1.getFullYear() > d2.getFullYear()) {
		flag = false;
	}
	if (flag && d1.getFullYear() == d2.getFullYear() && d1.getMonth() > d2.getMonth()) {
		flag = false;
	}
	if (flag && d1.getFullYear() == d2.getFullYear() && d1.getMonth() == d2.getMonth() && d1.getDate() > d2.getDate()) {
		flag = false;
	}
	return flag;
}

//将20080212转换成2008-02-12形式
function stringToDatestr(str) {
	if (str == null || str == "") {
		return "";
	}
	if (str.indexOf("-") != -1) {
		return str;
	}
	var year = str.substring(0, 4);
	var month = str.substring(4, 6);
	var day = str.substring(6, 8);
	return year + "-" + month + "-" + day;
}

//将2008-02-12转换成20080212形式
function stringToDatestr(str) {
	if (str == null || str == "") {
		return "";
	}
	if (str.indexOf("-") == -1) {
		return str;
	}
	var arr = str.split("-");
	return arr[0] + "" + arr[1] + "" + arr[2];
}
//a
function regInput(obj, reg, inputStr)
{
	var docSel	= document.selection.createRange()
	if (docSel.parentElement().tagName != "INPUT")	return false
		oSel = docSel.duplicate()
		oSel.text = ""
		var srcRange	= obj.createTextRange()
		oSel.setEndPoint("StartToStart", srcRange)
		var str = oSel.text + inputStr + srcRange.text.substr(oSel.text.length)
		return reg.test(str)
}
// Removes leading whitespaces
function ltrim(value) {
	var re = /\s*((\S+\s*)*)/;
	return value.replace(re, "$1");
}

// Removes ending whitespaces
function rtrim(value) {
	var re = /((\s*\S+)*)\s*/;
	return value.replace(re, "$1");
}

// Removes leading and ending whitespaces
function trim(value) {
	return ltrim(rtrim(value));
}

