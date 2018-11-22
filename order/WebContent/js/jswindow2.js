

var JSWindow = {

    //properties
    _windowContainer : null,
    _zIndex : 100,

	//methods
    createNewWindow : function(title, width, height) {
        var newWindow = document.createElement("div");//parent.document.getElementById('fly');//
        newWindow.className = "window-container";
		
        var newWindowContent = '<a href=\"#\" onclick=\"CreateNewWindowWithAnIFrame()\">Polo</a>';
        newWindowContent =  '<div class="window-titleBar">';
        newWindowContent += title;
        newWindowContent += '<div class="window-minimizeButton"><img src="../../images/i_small.gif" ></div>';
        newWindowContent += '<div class="window-maximizeButton"><img src="../../images/i_open.gif" ></div>';
        newWindowContent += '<div class="window-closeButton"><img src="../../images/i_close.gif" ></div>';
        newWindowContent += '</div>';
        newWindowContent += '<div class="window-content"></div>';
        newWindowContent += '<div class="window-statusBar">';
        newWindowContent += '<div class="window-resizeIcon"><img src="../../images/window_resize_w.gif"></div>';
        newWindowContent += '</div>';
        newWindow.innerHTML = newWindowContent;
		document.getElementsByTagName('body')[0].appendChild(newWindow);
        
        oElem = newWindow;
        
        var winElements = oElem.getElementsByTagName("div");
        for (var i=0; i<winElements.length; i++){
            if (winElements[i].className == "window-titleBar") oElem["titleBar"] = winElements[i];
			else if (winElements[i].className == "window-content") oElem["content"] = winElements[i];
			else if (winElements[i].className == "window-statusBar") oElem["statusBar"] = winElements[i];
			else if (winElements[i].className == "window-minimizeButton") oElem["minimizeButton"] = winElements[i];
			else if (winElements[i].className == "window-maximizeButton") oElem["maximizeButton"] = winElements[i];
			else if (winElements[i].className == "window-closeButton") oElem["closeButton"] = winElements[i];
			else if (winElements[i].className == "window-resizeIcon") oElem["resizeIcon"] = winElements[i];
        }
        
        //properties
        oElem.lastWidth = 200;
        oElem.lastHeight = 100;
        oElem.lastTop = 100;
        oElem.lastLeft = 100;
        oElem.state = "normal";
        oElem.windowUrl = "url";
        oElem.titleBar._parent = oElem;
        oElem.content._parent = oElem;
        oElem.statusBar._parent = oElem;
        oElem.minimizeButton._parent = oElem;
        oElem.maximizeButton._parent = oElem;
        oElem.closeButton._parent = oElem;
        oElem.resizeIcon._parent = oElem;
        
        //methods
        oElem.titleBar.onmousedown = JSWindow._dragBegin;
        oElem.resizeIcon.onmousedown = JSWindow._resizeBegin;
        oElem.minimize = function(){JSWindow._minimize(this);};
        oElem.maximize = function(){JSWindow._maximize(this);};
        oElem.close = function(){JSWindow._close(this);};
        oElem.minimizeButton.onclick = function(){JSWindow._minimize(this._parent);};
        oElem.maximizeButton.onclick = function(){JSWindow._maximize(this._parent);};
        oElem.closeButton.onclick = function(){JSWindow._close(this._parent);};
        oElem.setFocus = function(){JSWindow._setFocus(this);};
        oElem.move = function(x,y,savePosition){JSWindow._move(this,x,y,savePosition);};
        oElem.resize = function(newWidht,newHeight,saveSize){JSWindow._resize(this,newWidht,newHeight,saveSize);};
        oElem.addContent = function(content){JSWindow._addContent(this,content);};
        
        // callbacks
        oElem.onDragBegin = new Function();
        oElem.onDragging = new Function();
        oElem.onDragEnd = new Function();
        oElem.onResizeBegin = new Function();
        oElem.onResizing = new Function();
        oElem.onResizeEnd = new Function();
        oElem.onClosing = new Function();
        
		if(width==undefined)width = 600;
		if(height==undefined)height = 400;
        var randx = Math.round(Math.random()*(document.documentElement.clientWidth/2));
        var randy = Math.round(Math.random()*(document.documentElement.clientHeight/3));
        oElem.move(randx, randy);
        oElem.setFocus();
		oElem.resize(width, height);        
        return oElem;
		
    },


    _dragBegin : function(e) {
        var oElem = JSWindow._windowContainer = this._parent;
        
        oElem.setFocus();

        if (isNaN(parseInt(oElem.style.left))) { oElem.style.left = '0px'; }
        if (isNaN(parseInt(oElem.style.top))) { oElem.style.top = '0px'; }

        var x = parseInt(oElem.style.left);
        var y = parseInt(oElem.style.top);

        e = e ? e : window.event;
        oElem.mouseX = e.clientX;
        oElem.mouseY = e.clientY;

        oElem.onDragBegin(oElem, x, y);

        document.onmousemove = JSWindow._dragging;
        document.onmouseup = JSWindow._dragEnd;
        return false;
    },
    
    _resizeBegin : function(e) {
        var oElem = JSWindow._windowContainer = this._parent;
        
        oElem.setFocus();

        if (isNaN(parseInt(oElem.style.left))) { oElem.style.left = '0px'; }
        if (isNaN(parseInt(oElem.style.top))) { oElem.style.top = '0px'; }

        var x = parseInt(oElem.style.left);
        var y = parseInt(oElem.style.top);

        e = e ? e : window.event;
        oElem.mouseX = e.clientX;
        oElem.mouseY = e.clientY;

        var w = parseInt(oElem.style.width);
        var h = parseInt(oElem.style.height);
        oElem.onResizeBegin(oElem, w, h);

        document.onmousemove = JSWindow._resizing;
        document.onmouseup = JSWindow._resizeEnd;
        return false;
    },


    _dragging : function(e) {
        var oElem = JSWindow._windowContainer;
        
        var x = parseInt(oElem.style.left);
        var y = parseInt(oElem.style.top);

        e = e ? e : window.event;

        oElem.move(x + (e.clientX - oElem.mouseX), y + (e.clientY - oElem.mouseY));

        oElem.mouseX = e.clientX;
        oElem.mouseY = e.clientY;

        oElem.onDragging(oElem, x, y);

        return false;
    },
    
    _resizing : function(e) {
        var oElem = JSWindow._windowContainer;
        
        var w = parseInt(oElem.style.width);
        var h = parseInt(oElem.style.height);

        if (isNaN(w)) { w = 20; }
        if (isNaN(h)) { h = 10; }

        e = e ? e : window.event;

        var newWidth = w + e.clientX - oElem.mouseX;
        var newHeight = h + e.clientY - oElem.mouseY;
        if(newWidth < 20) newWidth = 20;
        if(newHeight < 10) newHeight = 10;
        oElem.resize(newWidth, newHeight);

        oElem.mouseX = e.clientX;
        oElem.mouseY = e.clientY;

        oElem.onResizing(oElem, newWidth, newHeight);

        return false;
    },


    _dragEnd : function() {
        var oElem = JSWindow._windowContainer;

        var x = parseInt(oElem.style.left);
        var y = parseInt(oElem.style.top);

        oElem.onDragEnd(oElem, x, y);

        document.onmousemove = null;
        document.onmouseup = null;
        JSWindow._windowContainer = null;
    },
    
    _resizeEnd : function() {
        var oElem = JSWindow._windowContainer;

        var w = parseInt(oElem.style.width);
        var h = parseInt(oElem.style.height);

        oElem.onResizeEnd(oElem, w, h);

        document.onmousemove = null;
        document.onmouseup = null;
        JSWindow._windowContainer = null;
    },
    
    
    _setFocus : function(oElem){
        JSWindow._zIndex++;
        oElem.style.zIndex = JSWindow._zIndex;
    },
    
    _move : function(oElem, x, y, savePosition){
        oElem.style.left = x + 'px';
        oElem.style.top = y + 'px';
        if(typeof(savePosition)=="undefined")savePosition=true;
        if(savePosition){
            oElem.lastLeft = x;
            oElem.lastTop = y;
        }
    },
    
    _resize : function(oElem, newWidth, newHeight, saveSize){
        oElem.style.width = newWidth + 'px';
        oElem.style.height = newHeight + 'px';
        if(typeof(saveSize)=="undefined")saveSize=true;
        if(saveSize){
            oElem.lastWidth = newWidth;
            oElem.lastHeight = newHeight;
        }        
        
        var objs = oElem.getElementsByTagName('object');
        var embs = oElem.getElementsByTagName('embed');
        var iframes = oElem.getElementsByTagName('iframe');
        for(var i=0; i<objs.length; i++){ 
            objs[i].width = (newWidth) + 'px';
            objs[i].height = (newHeight) + 'px';
        }
        for(var i=0; i<embs.length; i++){ 
            embs[i].width = (newWidth) + 'px';
            embs[i].height = (newHeight) + 'px';
        }
        for(var i=0; i<iframes.length; i++){ 
            iframes[i].width = (newWidth) + 'px';
            iframes[i].height = (newHeight) + 'px';
        }
    },
    
    _addContent : function(oElem, content){
        oElem.content.innerHTML = '<div style="width:100%; height:100%; overflow:auto;">' + content + '</div>';
    },
    
    _minimize : function(oElem){
        if(oElem.state != "minimized"){
            oElem.content.style.visibility = "hidden";
            oElem.statusBar.style.visibility = "hidden";
            oElem.resize(210,13,false);
            oElem.lastState = oElem.state;
            oElem.state = "minimized";
        }
        else{
            oElem.move(oElem.lastLeft,oElem.lastTop);
            oElem.content.style.visibility = "visible";
            oElem.statusBar.style.visibility = "visible";
            oElem.resize(oElem.lastWidth,oElem.lastHeight);
            oElem.lastState = oElem.state;
            oElem.state = "normal";
        }
    },
    
    _maximize : function(oElem){
        if(oElem.state != "maximized"){
            oElem.move(0,0,false);
            oElem.content.style.visibility = "visible";
            oElem.statusBar.style.visibility = "visible";
            oElem.resize(document.documentElement.clientWidth-5,document.documentElement.clientHeight-45,false);
            oElem.lastState = oElem.state;
            oElem.state = "maximized";
        }
        else{
            oElem.move(oElem.lastLeft,oElem.lastTop);
            oElem.content.style.visibility = "visible";
            oElem.statusBar.style.visibility = "visible";
            oElem.resize(oElem.lastWidth,oElem.lastHeight);
            oElem.lastState = oElem.state;
            oElem.state = "normal";
        }
    },    
    
    _close : function(oElem){
        oElem.style.display = "none";
        oElem.onClosing();
        oElem.content.innerHTML = "";
        oElem = null;
    }

}
