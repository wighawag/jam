package;

import kha.Framebuffer;
import kha.Loader;

import ys.Shell;
import ys.Input;

import kha.Color;
import kha.Font;
import kha.FontStyle;

using Khage;

class StartScreen implements Screen {

	public function new() {
	}

  public function enter(input : Input) {

  }

  public function exit(elapsedTime : Float){

	}

	public function update(elapsedTime : Float, dt : Float, input : Input) : Bool{
  	return input.isKeyDown(kha.Key.UP);
	}

	public function render(elapsedTime : Float, frame:Framebuffer, input : Input) {

		frame.usingG2({
			g2.clear();
			g2.color = Color.Green;

			g2.font = Loader.the.loadFont("GrapeSoda", new FontStyle(false, false, false), 72);
			g2.drawString("press UP",frame.width/2 - 270 ,frame.height/2 - 30);

      g2.font = Loader.the.loadFont("Arial", new FontStyle(false, false, false), 24);
			g2.drawString("UP to jump",frame.width/2 - 270 ,frame.height/2 + 100);
      g2.drawString("DOWN to roll",frame.width/2 - 270 ,frame.height/2 + 200);

		 });


  }

}
