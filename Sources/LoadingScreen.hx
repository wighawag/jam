package;

import kha.Framebuffer;
import kha.Loader;

import ys.Shell;
import ys.Input;

import kha.Color;
import kha.Font;
import kha.FontStyle;

using Khage;

class LoadingScreen implements Screen {

	var finishedLoading : Bool = false;

	public function new() {
	}

  public function enter(input : Input) {
		Loader.the.loadRoom("loading", function(){
		});
		//font = Loader.the.loadFont("Arial", new FontStyle(false, false, false), 14);
    //Configuration.setScreen(new LoadingScreen());

    // Load room with our texture
    Loader.the.loadRoom("room0", loadingFinished);
  }

	function loadingFinished() {
    finishedLoading = true;
  }

  public function exit(elapsedTime : Float){

	}

	public function update(elapsedTime : Float, dt : Float, input : Input) : Bool{
		return finishedLoading && elapsedTime > 2;
	}

	public function render(elapsedTime : Float, frame:Framebuffer, input : Input) {

		frame.usingG2({
			g2.clear();
			g2.color = Color.Green;

			g2.font = Loader.the.loadFont("GrapeSoda", new FontStyle(false, false, false), 72);
			g2.drawString("Loading",frame.width/2 - 200 ,frame.height/2 - 30);

		 });
  }

}
