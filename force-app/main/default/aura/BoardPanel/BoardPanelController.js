({
  startGame: function (component, event, helper) {
    //acess combobox
    let gameModeComboBox = component.find("gameMode");

    //acess the value of combobox
    let selectedValue = gameModeComboBox.get("v.value");
    console.log("Start Game is button is clicke with value " + selectedValue);

    const selectedMode = component.get("v.selectedMode");
    //update the value of selectedMode
    component.set("v.selectedMode", selectedValue);

    if (selectedMode) {
      //find board component
      const boardComp = component.find("boardComp");
      //call the aura method
      boardComp.startGame();
    }
  },
  reshuffleBoard: function (component, event, helper) {
    const boardComp = component.find("boardComp");
    //calling the borad (child) component method
    boardComp.reshuffleBoard();

    //disabling the Reshuffle button
    component.set("v.reshuffleDisabled", true);
  },
  onResultHandler: function (component, event, helper) {
    const result = event.getParam("result");

    if (result === "WIN") {
      component.set("v.reshuffleDisabled", true);
      helper.showToast("YOU WIN", "Hooray!!", "success");
    } else {
      component.set("v.reshuffleDisabled", false);
      helper.showToast(
        "YOU LOSE",
        "Reshuffle the board to keep playing",
        "error"
      );
    }
    //call the helper method to set the gameResult through AuraEnabled method of Controller
    helper.addResultRecord(component, result);
  }
});