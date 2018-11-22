// JavaScript Document

function formHandler(form){
var URL = document.form.site.options[document.form.site.selectedIndex].value;
window.location.href = URL;
}

	var jswindows = new Array();
	var winIndex = 0;
	
	function CreateNewWindow(){
	  jswindows[winIndex] = JSWindow.createNewWindow("Window" + winIndex);
      jswindows[winIndex].addContent("This is a window");
	  jswindows[winIndex].onDragging = ShowDraggingEvent;
	  jswindows[winIndex].onDragEnd = ShowDragEndEvent;
	  winIndex++;
	}
	
	function CreateNewWindowWithAnIFrameForProductInfo1(){
	  jswindows[winIndex] = JSWindow.createNewWindow("内饰", 600, 400);
      jswindows[winIndex].addContent('<iframe width="600" height="400" frameborder="0" src="../../public/interior_list.html?objName=productInfo1" id="test"/>');
	  winIndex++;
	}
	function CreateNewWindowWithAnIFrameForProductInfo(){
	  jswindows[winIndex] = JSWindow.createNewWindow("车型", 600, 400);
      jswindows[winIndex].addContent('<iframe width="600" height="400" frameborder="0" src="../../public/model_list.html?objName=productInfo" id="test"/>');
	  winIndex++;
	}
	function CreateNewWindowWithAnIFrameForProductInfo2(){
	  jswindows[winIndex] = JSWindow.createNewWindow("颜色", 600, 400);
      jswindows[winIndex].addContent('<iframe width="600" height="400" frameborder="0" src="../../public/color_list.html?objName=productInfo2" id="test"/>');
	  winIndex++;
	}
	function CreateNewWindowWithAnIFrameForProductInfo3(){
	  jswindows[winIndex] = JSWindow.createNewWindow("选装列表", 600, 400);
      jswindows[winIndex].addContent('<iframe width="600" height="400" frameborder="0" src="../../public/pr_list.html?objName=productInfo3" id="test"/>');
	  winIndex++;
	}
	function CreateNewWindowWithAnIFrameForProductInfo4(){
	  jswindows[winIndex] = JSWindow.createNewWindow("客户", 700, 400);
      jswindows[winIndex].addContent('<iframe width="700" height="400" frameborder="0" src="../../public/customer_list.html?objName=productInfo4" id="test"/>');
	  winIndex++;
	}
    
	function CreateNewWindowWithAnIFrameForProductInfo5(){
	  jswindows[winIndex] = JSWindow.createNewWindow("动力总成", 300, 200);
      jswindows[winIndex].addContent('<iframe width="300" height="200" frameborder="0" src="../../public/powertrain_list.html?objName=productInfo5" id="test"/>');
	  winIndex++;
	}
	
	function CreateNewWindowWithAnIFrameForProductInfo6(){
	  jswindows[winIndex] = JSWindow.createNewWindow("装备等级", 300, 200);
      jswindows[winIndex].addContent('<iframe width="300" height="200" frameborder="0" src="../../public/EquipmentLevel_list.html?objName=productInfo6" id="test"/>');
	  winIndex++;
	}
	
	function CreateNewWindowWithAnIFrameForProductInfo7(){
	  jswindows[winIndex] = JSWindow.createNewWindow("经销商", 500, 400);
      jswindows[winIndex].addContent('<iframe width="500" height="400" frameborder="0" src="../../public/dealer_list.html?objName=productInfo7" id="test"/>');
	  winIndex++;
	}

	
	function CloseAllWindows(){
	  for(var i=0; i<winIndex; i++){
	    jswindows[i].close();
	  }
	  winIndex = 0;
	}

	function ShowDraggingEvent(){
	  document.getElementById('divEventDisplay').innerHTML = "Dragging";
	}
	function ShowDragEndEvent(){
	  document.getElementById('divEventDisplay').innerHTML = "Drag End";
	}