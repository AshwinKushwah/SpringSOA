({	
    doInit : function(component, event, helper){
      var action=component.find("light_input");  
       console.log('inside doinit') 
    },
    handlefClick : function(component, event, helper){
        var target = event.getSource();
        console.log('target is :', target);
    },
	handleClick: function(component, event, helper) {
        //var target = event.getSource();
        //console.log('target is', target);
        var title = event.target.title;
         var myLabel = component.find("button1").get("v.title");
        console.log('title', title);
        console.log('event is ,' , event);
		console.log('handleClick');
	},
    HidePickToggle: function(component, event, helper) {
		console.log('HidePickToggle');
	},
})