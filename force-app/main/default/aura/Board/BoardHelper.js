({
  getWords: function (count) {
    if (count > 100) return;
    //build an Array
    let wordsArray = [
      "tenace",
      "gin",
      "split",
      "knave",
      "void",
      "draw",
      "skat",
      "blackjack",
      "cartomancy",
      "play",
      "dummy",
      "snap",
      "cassino",
      "fold",
      "card shark",
      "wallet",
      "stock",
      "cheat",
      "commerce",
      "Honour",
      "game",
      "card index",
      "first class",
      "ace",
      "sweep",
      "run",
      "opener",
      "cater",
      "gin rummy",
      "keno",
      "quint",
      "scuffle",
      "showdown",
      "bingo",
      "face card",
      "lotto",
      "bezique",
      "pip",
      "deuce",
      "old maid",
      "quadrille",
      "whist",
      "playing card",
      "cribbage",
      "ante",
      "slam",
      "solitaire",
      "four flush",
      "pinochle",
      "crimp",
      "led",
      "pool",
      "matador",
      "finesse",
      "fill",
      "lansquenet",
      "renounce",
      "quinze",
      "stud poker",
      "overplay",
      "Slough",
      "palm",
      "four-flush",
      "book",
      "two",
      "cartophily",
      "kanban",
      "Queen",
      "underbid",
      "bid",
      "bower",
      "goulash",
      "up",
      "handicap",
      "coonjine",
      "baccarat",
      "shaffle",
      "keypunch",
      "ruff",
      "straddle",
      "pat",
      "cylinder",
      "basset",
      "king",
      "fortune",
      "cardsharp",
      "cash",
      "cards",
      "widow",
      "joker",
      "blind",
      "draw poker",
      "palmer",
      "double shuffle",
      "combine",
      "score",
      "stick",
      "primero",
      "shuffling",
      "revoke"
    ];
    //randomize the words array
    wordsArray = this.randomizeArray(wordsArray);

    //setting open property and converting an array of strings to an array of objects
    const wordsObjArray = wordsArray.map((element) => {
      return { word: element, open: false };
    });

    //return the request word
    return wordsObjArray.slice(0, count);
  },
  randomizeArray: function (arr) {
    const randomArr = arr;
    //Randomize the array
    for (let i = randomArr.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * i);
      const temp = randomArr[i];
      randomArr[i] = randomArr[j];
      randomArr[j] = temp;
    }

    return randomArr;
  },

  getWinWord: function (arr) {
    const randomIndex = Math.floor(Math.random() * arr.length);
    return arr[randomIndex].word;
  },
  disableBoard: function (component) {
    component.set("v.boardDisabled", true);
  },
  enableBoard: function (component) {
    component.set("v.boardDisabled", false);
  },
  resetBoard: function (component) {
    this.enableBoard(component);
    //reset the moves left counter
    component.set("v.clickCount", 0);

    //reset the result;
    component.set("v.result", "");
  },

  fireResultEvent: function (resultValue) {
    const appEvent = $A.get("e.c:ResultApplicationEvent");
    appEvent.setParams({ result: resultValue });
    appEvent.fire();
  }
});