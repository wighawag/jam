package ys;

import ys.App;


class Shell implements Application{

  var screens : Array<Screen>;
  var currentIndex : Int = 0;
  var currentScreen : Screen;

  public function new (screens : Array<Screen>){
		this.screens = screens;
	}

  public function init(now : Float){
    currentIndex = 0;
    enterScreen(now);
  }

  public function update(now : Float, dt : Float, input : Input){
    var done = currentScreen.update(now, dt, input);
    if (done) {
        currentScreen.exit(now);
        currentIndex++;
        if (currentIndex >= screens.length) {
            currentIndex = 0;
            //TODO
        }
        enterScreen(now);
    }
  }

  public function render(now : Float, framebuffer : Framebuffer, input : Input){
    currentScreen.render(now,framebuffer, input);
  }

  function enterScreen(now : Float){
    currentScreen = screens[currentIndex];
    currentScreen.enter(now);
  }
}

interface Screen{
  function enter(now : Float):Void;
  function exit(now : Float):Void;
  function update(now : Float, dt : Float, input : Input):Bool;
  function render(now : Float, framebuffer : Framebuffer, input : Input):Void;
}
