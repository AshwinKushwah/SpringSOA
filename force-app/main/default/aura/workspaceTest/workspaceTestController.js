({
	
    openTab : function(component, event, helper) {
        var workspaceAPI = component.find("workspace");
        workspaceAPI.openTab({
            url: '#/sObject/0012w00000JsWQNAA3/view',
            focus: true
        });
    },
})