//产品对应选项
var product2condition = new Array();
var temp = new Array();
temp[0]='在网时间';
temp[1]='信息用量';
product2condition['短信']=temp;
temp = new Array();
temp[0]='内容偏好';
temp[1]='终端类型';
temp[2]='在网时间';
temp[3]='信息流量';
temp[4]='终端功能';
product2condition['手机报']=temp;
temp = new Array();
temp[0]='内容偏好';
temp[1]='终端类型';
temp[2]='信息流量';
temp[3]='终端功能';
product2condition['彩信']=temp;
temp = new Array();
temp[0]='内容偏好';
temp[1]='终端类型';
temp[2]='定制费用';
temp[3]='跟换频率';
temp[4]='终端功能';
product2condition['七彩铃音']=temp;
temp = new Array();
temp[0]='内容偏好';
temp[1]='终端类型';
temp[2]='信息流量';
temp[3]='定制费用';
temp[4]='跟换频率';
temp[5]='终端功能';
product2condition['爱音乐－全曲下载']=temp;
temp = new Array();
temp[0]='内容偏好';
temp[1]='终端类型';
temp[2]='终端功能';
temp[3]='信息流量';
temp[4]='定制费用';
temp[5]='跟换频率';
product2condition['手机游戏']=temp;
temp = new Array();
temp[0]='内容偏好';
temp[1]='终端类型';
temp[2]='终端功能';
temp[3]='信息流量';
temp[4]='定制费用';
temp[5]='跟换频率';
temp[6]='寻股偏好';
product2condition['手机炒股']=temp;
temp = new Array();
temp[0]='终端类型';
temp[1]='终端功能';
product2condition['189邮箱']=temp;
temp = new Array();
temp[0]='终端类型';
temp[1]='终端功能';
temp[2]='使用频率';
product2condition['移动支付']=temp;
temp = new Array();
temp[0]='使用率';
product2condition['其他']=temp;
//特殊选项内容
var SpecialCoditions = new Array();
temp = new Array();
temp[0]='政治';
temp[1]='娱乐';
temp[2]='饮食';
temp[3]='旅游';
temp[4]='交友';
temp[5]='音乐';
temp[6]='体育';
SpecialCoditions['内容偏好']=temp;
temp = new Array();
temp[0]='天语-E61';
temp[1]='海尔C60';
temp[2]='酷派 N900';
temp[3]='多普达S900C';
temp[4]='LG KV500';
temp[4]='三星SCH-M609';
SpecialCoditions['终端类型']=temp;
temp = new Array();
temp[0]='彩信';
temp[1]='WAP';
temp[2]='BPEW';
temp[3]='客户端安装';
SpecialCoditions['终端功能']=temp;
temp = new Array();
temp[0]='青年';
temp[1]='中年';
temp[2]='老年';
temp[3]='学生族';
temp[4]='上班族';
SpecialCoditions['年龄']=temp;
temp = new Array();
temp[0]='男';
temp[1]='女';
SpecialCoditions['性别']=temp;
//产品
Products = new Array();
Products[0]='短信';
Products[1]='手机报';
Products[2]='彩信';
Products[3]='七彩铃音';
Products[4]='爱音乐－全曲下载';
Products[5]='手机游戏';
Products[6]='手机炒股';
Products[7]='189邮箱';
Products[8]='移动支付';
//临时已选内容
var SelectedCodition = new Array();
function initSelect(selectObj,cs){
	var temp = new Array();
	var haved = new Array();
	selectObj.add(new Option('请选择..','temp'));
	for(var i=0;i<cs.length;i++){
		if(isEmpty(cs[i])==false){
			temp = product2condition[cs[i]];
			for(var j=0;j<temp.length;j++){
				var flag = true;
				for(var x=0;x<SelectedCodition.length;x++){
					if(SelectedCodition[x]==''){
						continue;
					}
					if(temp[j]==SelectedCodition[x]){
						flag = false;
						break;
					}
				}
				for(var x=0;x<haved.length;x++){
					if(haved[x]==''){
						continue;
					}
					if(temp[j]==haved[x]){
						flag = false;
						break;
					}
				}		
				if(flag == true){
					selectObj.add(new Option(temp[j],temp[j]));
				}
				haved[haved.length]=temp[j];
			}		
		}		
	}
}