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

	var font : kha.Font;

	public function new() {
	}

  public function enter() {
		Loader.the.loadRoom("loading", function(){
			font = Loader.the.loadFont("Arial", new FontStyle(false, false, false), 14);
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
			g2.drawLine(0,0,frame.width,frame.height);
			if(font != null){
					g2.font = font;
					g2.drawString("test",100,100);//frame.width/2, frame.height/2);
			}


		 });
  }

}
