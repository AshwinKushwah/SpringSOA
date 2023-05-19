({
  addResultRecord: function (component, gameResult) {
    //create apex method call action
    const action = component.get("c.addResult");
    const modeValue = component.get("v.selectedMode").toUpperCase();
    //set parameters
    action.setParams({
      result: gameResult,
      mode: modeValue
    });

    action.setCallback(this, function (response) {
      const state = response.getState();
      if (state !== "SUCCESS") console.log("Error in Saving the Record");
    });

    //call apex method
    $A.enqueueAction(action);
  },
  showToast: function (titleValue, messageValue, typeValue) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
      title: titleValue,
      message: messageValue,
      type: typeValue
    });
    toastEvent.fire();
  }
});