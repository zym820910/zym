// JavaScript Document

	  <!--
	var jswindows2 = new Array();
	var winIndex = 0;
	
	function CreateNewWindow(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("Window" + winIndex);
      jswindows2[winIndex].addContent("This is a window");
	  jswindows2[winIndex].onDragging = ShowDraggingEvent;
	  jswindows2[winIndex].onDragEnd = ShowDragEndEvent;
      winIndex++;
	}
	
	function CreateNewWindowWithAnIFrame(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("区域目标" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="goal_detail_regin.html" />');
      winIndex++;
	}
	function CreateNewWindowWithAnIFrame1(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("销售目标" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="goal_detail.html" />');
      winIndex++;
	}
	
	function CreateNewWindowWithAnIFrame2(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("经销商目标" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="goal_detail_dealer.html" />');
      winIndex++;
	}
	
	function CreateNewWindowWithAnIFrame3(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("销售目标上传" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="goal_upload_detail.html" />');
      winIndex++;
	}
	
	function CreateNewWindowWithAnIFrame4(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("销售目标上传" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="goal_detail_regin.html" />');
      winIndex++;
	}
	function CreateNewWindowProductionPlan(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("生产计划" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="production_plan_detail.html" />');
      winIndex++;
	}
	
	function CreateNewWindowProductionPlan1(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("生产计划上传" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="production_plan_upload_detail.html" />');
      winIndex++;
	}
	
	function CreateNewWindowForecast(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("汇总预测" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="hq_forecast_detail.html" />');
      winIndex++;
	}
	
	function CreateNewWindowForecast2(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("编辑预测" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="hq_forecast_detail_edit.html" />');
      winIndex++;
	}
	
	function CreateNewWindowForecast3(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("查看历史情况" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="dlr_edit_forecast.html" />');
      winIndex++;
	}
	
	function CreateNewWindowForecast4(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("审核销售组织预测" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="hq_edit_forecast.html" />');
      winIndex++;
	}
	
	function CreateNewWindowForecast5(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("销售组织车型大类预测" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="hq_sale_org_forecast_car_model.html" />');
      winIndex++;
	}
	
	function CreateNewWindowForecast6(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("编辑销售组织预测" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="hq_sale_org_edit_forecast.html" />');
      winIndex++;
	}
	
	function CreateNewWindowForecast7(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("销售组织车型大类预测" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="hq_forecast_detail.html" />');
      winIndex++;
	}
	
	function CreateNewWindowAdditional(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("编辑补充预测" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="hq_additional_forecast_edit.html" />');
      winIndex++;
	}
	
	function CreateNewWindowAdditional2(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("补充预测详情" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="hq_additional_forecast_detail.html" />');
      winIndex++;
	}
	
	function CreateNewWindowAdditional3(){
	  jswindows2[winIndex] = JSWindow.createNewWindow("总部补充动力总成、装备等级预测编辑" , 700, 400);
      jswindows2[winIndex].addContent('<iframe width="100%" height="100%" frameborder="0" src="hq_additional_forecast_detail_edit.html" />');
      winIndex++;
	}
	
	
	function CloseAllWindows(){
	  for(var i=0; i<winIndex; i++){
	    jswindows2[i].close();
	  }
	  winIndex = 0;
	}
	
	function ShowDraggingEvent(){
	  document.getElementById('divEventDisplay').innerHTML = "Dragging";
	}
	function ShowDragEndEvent(){
	  document.getElementById('divEventDisplay').innerHTML = "Drag End";
	}
	
-->
