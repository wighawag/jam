package;

import kha.Framebuffer;
import kha.Loader;

import ys.Shell;
import ys.Input;

class SplashScreen implements Screen {


	public function new() {
	}

  public function enter() {
  }

  public function exit(elapsedTime : Float){

	}

	public function update(elapsedTime : Float, dt : Float, input : Input) : Bool{
		return finishedLoading;
	}

	public function render(elapsedTime : Float, frame:Framebuffer, input : Input) {

  }

}
