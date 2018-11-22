jQuery.fn.eajaxSubmit = function(options) {
	
    if (typeof options == 'function')
        options = { success: options };

    options = jQuery.extend({
        url:  this.attr('action') || window.location,
        type: this.attr('method') || 'GET'
    }, options || {});

    var a = this.eformToArray(options.semantic, options.extraparams);



    // give pre-submit callback an opportunity to abort the submit
    if (options.beforeSubmit && options.beforeSubmit(a, this, options) === false) return this;

    // fire vetoable 'validate' event
    var veto = {};
    jQuery.event.trigger('form.submit.validate', [a, this, options, veto]);
    if (veto.veto)
        return this;
        
    if(options.extraparams){
    	for (var k in options.extraparams){
			a.push({name: k,value:options.extraparams[k]});
		}
    }
        
        
    var q = jQuery.param(a);//.replace(/%20/g,'+');
    
     if (options.type.toUpperCase() == 'GET') {
        options.url += (options.url.indexOf('?') >= 0 ? '&' : '?') + q;
        options.data = null;  // data is null for 'get'
    }
    else
        options.data = q; // data is the query string for 'post'

    var $form = this, callbacks = [];
    if (options.resetForm) callbacks.push(function() { $form.resetForm(); });
    if (options.clearForm) callbacks.push(function() { $form.clearForm(); });

    // perform a load on the target only if dataType is not provided
    if (!options.dataType && options.target) {
        var oldSuccess = options.success || function(){};
        callbacks.push(function(data, status) {
            jQuery(options.target).attr("innerHTML", data).evalScripts().each(oldSuccess, [data, status]);
        });
    }
    else if (options.success)
        callbacks.push(options.success);

    options.success = function(data, status) {
        for (var i=0, max=callbacks.length; i < max; i++)
            callbacks[i](data, status);
    };
		
    // are there files to upload?
    var files = jQuery('input:file', this).fieldValue();
    var found = false;
    for (var j=0; j < files.length; j++)
        if (files[j]) 
            found = true;
    
    if (options.iframe || found) // options.iframe allows user to force iframe mode
        fileUpload();
    else
        jQuery.ajax(options);

    // fire 'notify' event
    jQuery.event.trigger('form.submit.notify', [this, options]);
    return this;


    // private function for handling file uploads (hat tip to YAHOO!)
    function fileUpload() {
        var form = $form[0];
        var opts = jQuery.extend({}, jQuery.ajaxSettings, options);
        
        var id = 'jqFormIO' + jQuery.fn.ajaxSubmit.counter++;
        var $io = jQuery('<iframe id="' + id + '" name="' + id + '" src="javascript:false;"/>');
        var io = $io[0];
        var op8 = jQuery.browser.opera && window.opera.version() < 9;
        if (jQuery.browser.msie || op8) io.src = 'javascript:false;document.write("");';
        $io.css({ position: 'absolute', top: '-1000px', left: '-1000px' });

        // make sure form attrs are set
        form.method = 'POST';
        form.encoding ? form.encoding = 'multipart/form-data' : form.enctype = 'multipart/form-data';

        var xhr = { // mock object
            responseText: null,
            responseXML: null,
            status: 0,
            statusText: 'n/a',
            getAllResponseHeaders: function() {},
            getResponseHeader: function() {},
            setRequestHeader: function() {}
        };
        
        var g = opts.global;
        // trigger ajax global events so that activity/block indicators work like normal
        if (g && ! jQuery.active++) jQuery.event.trigger("ajaxStart");
        if (g) jQuery.event.trigger("ajaxSend", [xhr, opts]);
        
        var cbInvoked = 0;
        var timedOut = 0;
        
        // take a breath so that pending repaints get some cpu time before the upload starts
        setTimeout(function() {
            $io.appendTo('body');
            // jQuery's event binding doesn't work for iframe events in IE
            io.attachEvent ? io.attachEvent('onload', cb) : io.addEventListener('load', cb, false);
            form.action = opts.url;
            var t = form.target;
            form.target = id;

            // support timout
            if (opts.timeout)
                setTimeout(function() { timedOut = true; cb(); }, opts.timeout);

            form.submit();
            form.target = t; // reset
        }, 10);
        
        function cb() {
            if (cbInvoked++) return;
            
            io.detachEvent ? io.detachEvent('onload', cb) : io.removeEventListener('load', cb, false);

            var ok = true;
            try {
                if (timedOut) throw 'timeout';
                // extract the server response from the iframe
                var data, doc;
                doc = io.contentWindow ? io.contentWindow.document : io.contentDocument ? io.contentDocument : io.document;
                xhr.responseText = doc.body ? doc.body.innerHTML : null;
                xhr.responseXML = doc.XMLDocument ? doc.XMLDocument : doc;
                
                if (opts.dataType == 'json' || opts.dataType == 'script') {
                    var ta = doc.getElementsByTagName('textarea')[0];
                    data = ta ? ta.value : xhr.responseText;
                    if (opts.dataType == 'json')
                        eval("data = " + data);
                    else
                        jQuery.globalEval(data);
                }
                else if (opts.dataType == 'xml') {
                    data = xhr.responseXML;
                    if (!data && xhr.responseText != null)
                        data = toXml(xhr.responseText);
                }
                else {
                    data = xhr.responseText;
                }
            }
            catch(e){
                ok = false;
                jQuery.handleError(opts, xhr, 'error', e);
            }

            // ordering of these callbacks/triggers is odd, but that's how $.ajax does it
            if (ok) {
                opts.success(data, 'success');
                if (g) jQuery.event.trigger("ajaxSuccess", [xhr, opts]);
            }
            if (g) jQuery.event.trigger("ajaxComplete", [xhr, opts]);
            if (g && ! --jQuery.active) jQuery.event.trigger("ajaxStop");
            if (opts.complete) opts.complete(xhr, ok ? 'success' : 'error');

            // clean up
            setTimeout(function() { 
                $io.remove(); 
                xhr.responseXML = null;
            }, 100);
        };
        
        function toXml(s, doc) {
            if (window.ActiveXObject) {
                doc = new ActiveXObject('Microsoft.XMLDOM');
                doc.async = 'false';
                doc.loadXML(s);
            }
            else
                doc = (new DOMParser()).parseFromString(s, 'text/xml');
            return (doc && doc.documentElement && doc.documentElement.tagName != 'parsererror') ? doc : null;
        }
    };
};


jQuery.fn.eformToArray = function(semantic, extraparams) {
    var a = [];
    if (this.length == 0) return a;

    var form = this[0];
    var els = semantic ? form.getElementsByTagName('*') : form.elements;
    if (!els) return a;
    for(var i=0, max=els.length; i < max; i++) {
        var el = els[i];
        var n = el.name;
        if (!n) continue;

        if (semantic && form.clk && el.type == "image") {
            // handle image inputs on the fly when semantic == true
            if(!el.disabled && form.clk == el)
                a.push({name: n+'.x', value: form.clk_x}, {name: n+'.y', value: form.clk_y});
            continue;
        }
        var v = jQuery.fieldValue(el, true);
        if (v === null) continue;
        if (v!=null && v.constructor == Array) {
            for(var j=0, jmax=v.length; j < jmax; j++){
            	if((!extraparams) || (extraparams && !(n in extraparams))){
            		a.push({name: n, value: v[j]});
            	}
            }
    
        }
        else{
                if((!extraparams) || (extraparams && !(n in extraparams))){
            		a.push({name: n, value: v});
            	}
        }
    }

    if (!semantic && form.clk) {
        // input type=='image' are not found in elements array! handle them here
        var inputs = form.getElementsByTagName("input");
        for(var i=0, max=inputs.length; i < max; i++) {
            var input = inputs[i];
            var n = input.name;
            if(n && !input.disabled && input.type == "image" && form.clk == input)
                a.push({name: n+'.x', value: form.clk_x}, {name: n+'.y', value: form.clk_y});
        }
    }
    return a;
};