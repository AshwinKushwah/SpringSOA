({
  blockClickHandler: function (component, event, helper) {
    const open = component.get("v.open");
    if (!open) {
      component.set("v.open", true);
      //get the label value
      const label = component.get("v.label");
      //fire the block click event
      let compEvent = component.getEvent("onclick");
      compEvent.setParams({ wordValue: label });
      compEvent.fire();
    }
  },
  // processing the task after FitText Library is Loaded
  scriptsLoaded: function (component, event, helper) {
    const divElement = component.getElement(".board-block"); // finding the element through class name
    fitText(divElement);
  }
});