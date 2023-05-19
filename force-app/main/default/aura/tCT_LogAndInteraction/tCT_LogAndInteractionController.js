({
	doInit : function(component, event, helper) {
         var picklistVal = ["Not Started ","In Progress","Complete"];
        component.set('v.statusPicklistVal',picklistVal);
        var recordId = component.get("v.recordId"); 
        component.set("v.recordId",recordId);
		var action = component.get('c.getFieldsDetails'); 
        action.setParams({
            "recordID" : recordId
        });
    action.setCallback(this,function(response){
     var state = response.getState();
     if(state === 'SUCCESS'){ 
    	 var loint = response.getReturnValue();
         component.set("v.logInteractionDetails",loint);
		}        
	});
    
      var action2 = component.get('c.getRMPickListValues');
      action2.setCallback(this,function(response){
      var state = response.getState();
      if(state === 'SUCCESS'){ 
          var relatedMetricList = [];
          var relValues = response.getReturnValue();
          for(var i in relValues){
              var obj={
                    Id:i,
                    Name:relValues[i],
                    flag:false
                }
               relatedMetricList.push(obj);
          }
            component.set("v.relatedMatrices", relatedMetricList);
          }
        });
        
        var action3 = component.get('c.getFA');
        action3.setParams({
            "recordID" : recordId
        });
      action3.setCallback(this,function(response){
      var state1 = response.getState();
      if(state1 === 'SUCCESS'){ 
          var focusAreaNames = [];
          var relValues = response.getReturnValue();
          for(var i in relValues){
              var obj={
                    Id:i,
                    Name:relValues[i],
                    flag:false
                }
               focusAreaNames.push(obj);
          }
    	console.log('focusAreaNames ' , focusAreaNames);
    	component.set("v.focusAreaNames", focusAreaNames);
          }
      });
        
     $A.enqueueAction(action);
     $A.enqueueAction(action2);
     $A.enqueueAction(action3);
	},
    savetask: function(component, event, helper) {
         var recordId = component.get("v.recordId");
         var logInteractionDetails =component.get("v.logInteractionDetails.finalTaskWrapper");
         var logInteractionDetails1 =JSON.stringify(logInteractionDetails);
         var action = component.get('c.createTask');
         action.setParams({
            "recordID" : recordId,
            "logInteractionDetails1" : logInteractionDetails1
         });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){ 
                var loint = response.getReturnValue();
                console.log('saveFocusArea===Else===tFA recordID==='+loint);
            }        
        });
        $A.enqueueAction(action);
    },
    handleUploadFinished: function (component, event,helper) {
        var uploadedFiles = event.getParam("files");
		console.log("handleUploadFinished------->"+JSON.stringify(uploadedFiles));
        var fileName=uploadedFiles[0].name;
        var documentId=uploadedFiles[0].documentId;
        helper.createLinkRecord(component, event,fileName,documentId);
               
    },
})