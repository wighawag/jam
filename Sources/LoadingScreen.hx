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
		return finishedLoading;

	}

	public function render(elapsedTime : Float, frame:Framebuffer, input : Input) {

		frame.usingG2({
			g2.clear();
			g2.color = Color.Green;

			g2.font = Loader.the.loadFont("GrapeSoda", new FontStyle(false, false, false), 72);
			g2.drawString("Loading",frame.width/2 - 200 ,frame.height/2 - 30);

		 });

		 if (Loader.the != null) {
 			frame.g2.color = Color.fromBytes(0, 0, 255);
 			frame.g2.fillRect(frame.width / 4, frame.height / 2 + 100, Loader.the.getLoadPercentage() * frame.width / 2 / 100, 20);
 			frame.g2.color = Color.fromBytes(28, 28, 28);
 			frame.g2.drawRect(frame.width / 4, frame.height / 2 + 100, frame.width / 2, 20);
 		}
  }

}
