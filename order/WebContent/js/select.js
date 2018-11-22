// JavaScript Document

function copyToList(from,to) { 
  fromList = from; 
  toList = to;
  if (toList.options.length > 0 && toList.options[0].value == 'temp'){
    toList.options.length = 0;
  }
  var sel = false; 
  for (i=0;i<fromList.options.length;i++) 
  { 
    var current = fromList.options[i]; 
    if (current.selected) 
    { 
      sel = true; 
      if (current.value == 'temp') 
      { 
        alert ('你不能选择这个项目!'); 
        return; 
      } 
      txt = current.text; 
      val = current.value; 
      toList.options[toList.length] = new Option(txt,val); 
      fromList.options[i] = null; 
      i--; 
    } 
  } 
  if (!sel) alert ('你还没有选择任何项目'); 
} 
function allSelect() { 
  List = document.forms[0].chosen; 
  if (List.length && List.options[0].value == 'temp')
  	return; 
  for (i=0;i<List.length;i++) 
  { 
     List.options[i].selected = true; 
  } 
} 

