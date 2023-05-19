({
  doInit: function (component, event, helper) {
    console.log("Initialization complete");
    //get gameMode
    const gameMode = component.get("v.mode");
    let column = 0;
    //get the number of columns based on game mode
    if (gameMode && gameMode === "hard") {
      column = 6;
    } else if (gameMode === "medium") {
      column = 4;
    } else {
      column = 3;
    }

    //get block width/size
    let blockSize = 12 / column;
    component.set("v.blockSize", blockSize);

    //build the 100 words
    const words = helper.getWords(column * column);
    component.set("v.words", words);

    //get win word
    const winWord = helper.getWinWord(words);
    component.set("v.winWord", winWord);

    //reset the board
    helper.resetBoard(component);
  },
  doRender: function (component, event, helper) {
    console.log("Render complete");
  },

  blockClickHandler: function (component, event, helper) {
    let clickCount = component.get("v.clickCount") + 1;

    //get event value
    const value = event.getParam("wordValue");

    if (value === component.get("v.winWord")) {
      //user has won
      component.set("v.result", "YOU WIN");
      console.log("YOU WIN");
      helper.disableBoard(component);
      helper.fireResultEvent("WIN");
    } else if (clickCount === 3) {
      //user lose
      component.set("v.result", "YOU LOSE");
      console.log("YOU LOSE");
      helper.disableBoard(component);
      helper.fireResultEvent("LOSE");
    }
    //set clickcount
    component.set("v.clickCount", clickCount);
  },
  reshuffleBoard: function (component, event, helper) {
    const words = component.get("v.words");
    const randomizeWords = helper.randomizeArray(words);
    component.set("v.words", randomizeWords);
    helper.resetBoard(component);
  }
});