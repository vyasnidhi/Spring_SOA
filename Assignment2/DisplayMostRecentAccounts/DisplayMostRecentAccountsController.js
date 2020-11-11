({
	doInIt : function(component, event, helper) {
		component.set('v.columns', [
            {label: 'Account Name', fieldName: 'Id_URL', type: 'url', typeAttributes: {label: { fieldName: 'Name' }, target: '_blank'}},
            {label: 'Account Number', fieldName: 'AccountNumber', type: 'text'},
            {label: 'Description', fieldName: 'Description', type: 'text'},
            {label: 'Industry', fieldName: 'Industry', type: 'text'},
            {label: 'Phone', fieldName: 'phone', type: 'phone'},
            {label: 'Website', fieldName: 'website', type: 'url', typeAttributes: { target: '_self'}}
        ]);
        
        helper.getAccountRecords(component, event);
	}
})