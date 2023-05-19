({
	doInit : function(component, event, helper) {
		console.log("inside do INIT");
	},
    handleClick : function(component, event, helper){
        console.log("handleclick is called");
        
        var choice = component.find("myinput");
        choice.reportValidity();
        var validity = component.find("myinput").get("v.validity");
        console.log("from method --", choice.checkValidity());
        console.log("validity is --- > ", validity.valid); //returns true
        
        var sel = component.get("v.selValue");
        console.log('Selected Value is -- ', sel);
    }
})