package;

import kha.Framebuffer;
import kha.Loader;

import ys.Shell;
import ys.Input;

class LoadingScreen implements Screen {

	var finishedLoading : Bool = false;

	public function new() {
	}

  public function enter() {
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

  }

}
