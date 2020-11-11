({
    getAccountRecords : function(cmp, event) {
        this.showSpinner(cmp);
        var action = cmp.get('c.getMostRecentlyCreatedAccount');
        action.setParams({});
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log('Got Raw Response for ');
                console.log(response.getReturnValue());      
                
                var result =  response.getReturnValue();     
                if(result != undefined && result != null && Array.isArray(result) && result.length > 0) {
                    for(var i = 0; i < result.length; i++) {
                    	result[i].Id_URL = '/lightning/r/Account/'+result[i].Id+'/view';
                    }
                    cmp.set("v.data", result);
                } else {
                    cmp.set("v.data", []);
                }
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors[0] && errors[0].message) {  
                    this.showToast(cmp, 'error', errors[0].message);
                }                
            }               
            this.hideSpinner(cmp);
        }));
        $A.enqueueAction(action);
    },
    showToast : function(cmp, type, msg){
        var title = (type == 'error') ? 'Error!' : 'Success!';
        var massge = msg ;
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "type": type,
            "title": title+' '+massge,
            "message": massge
        });
        toastEvent.fire();        
    },
	hideSpinner : function(cmp) {
        var cmpTarget = cmp.find("mySpinner");        
        $A.util.addClass(cmpTarget, 'slds-hide');
    },
    showSpinner : function(cmp) {
        var cmpTarget = cmp.find("mySpinner");
        $A.util.removeClass(cmpTarget, 'slds-hide');
    },
})