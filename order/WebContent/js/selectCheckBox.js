 // add by Michael: 2010/01/04
	function bindCheckedString(checkboxListName , componentName){
		/**
	    var count = 0 ;
		var newCheckedString = "" ;
		var checkboxList = document.getElementsByName(checkboxListName) ;
		for(var cbxIndex = 0 ; cbxIndex < checkboxList.length ; cbxIndex++){
			if(checkboxList[cbxIndex].checked) {
				newCheckedString += ("," + checkboxList[cbxIndex].value) ;
				count++ ;
			}
		}*/
		var count = bindCheck(count,checkboxListName , componentName ,newCheckedString);
		if( count == 0 ){
			alert("<s:text name='error.notchoose' />");
			return false ;
		}
		/**
		if(newCheckedString.length > 0 ) newCheckedString = newCheckedString.substr(1);
		$("#" + componentName).val(newCheckedString);
		*/
		return true ;
	}
	
	function bindCheck(checkboxListName , componentName)
	{
		var count = 0 ;
		var newCheckedString = "" ;
		var checkboxList = document.getElementsByName(checkboxListName) ;
		for(var cbxIndex = 0 ; cbxIndex < checkboxList.length ; cbxIndex++){
			if(checkboxList[cbxIndex].checked) {
				newCheckedString += ("," + checkboxList[cbxIndex].value) ;
				count++ ;
			}
		}
		if(newCheckedString.length > 0 ) newCheckedString = newCheckedString.substr(1);
		$("#" + componentName).val(newCheckedString);
		return count;
	}
	// add by Michael: 2010/01/04
	function chooseAllCheckBox(controlCbx , controlledCbxListName){
		var controlledCbxList = document.getElementsByName(controlledCbxListName) ;
		for(var cbxIndex = 0 ; cbxIndex < controlledCbxList.length ; cbxIndex++) 
			controlledCbxList[cbxIndex].checked = controlCbx.checked ;
	}