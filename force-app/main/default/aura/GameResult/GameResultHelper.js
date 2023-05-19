({
  fetchGameResult: function (component) {
    const action = component.get("c.gameResults");

    //set the callback function
    action.setCallback(this, function (response) {
      const state = response.getState();
      if (state === "SUCCESS") {
        const resp = response.getReturnValue();
        component.set("v.data", resp);
      } else {
        console.log("Setting data doesn't work");
      }
    });

    $A.enqueueAction(action);
  }
});