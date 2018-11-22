jQuery.jDialogs = {
	ec_form_id:null,
	diag:null,
	callbacks:[],
	build:function(options){
			diag = new Dialog("Diag1");
			diag.Width = options.width || 500;
			diag.Height = options.height || 300;
			diag.Title = options.caption;
			diag.URL = options.url ;
			diag.Message = options.caption;
			diag.OKEvent = jQuery.jDialogs.destroy;
			ec_form_id = options.formid;
			callbacks = options.destroyCallbacks;
			diag.show();
	},	
	destroy:function(){
		for(var i=0;i<callbacks.length;i++){
			if(callbacks[i]){
				callbacks[i]();
			}
		}
		//ECSideUtil.reload(ec_form_id);
		diag.close();
	}
}	

jQuery.fn.extend({openJdialog:jQuery.jDialogs.build,destroyJdialog:jQuery.jDialogs.destroy});
