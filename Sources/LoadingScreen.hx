package;

import kha.Framebuffer;
import kha.Loader;

import ys.Shell;
import ys.Input;

class LoadingScreen implements Screen {

	var finishedLoading : Bool = false;

	public function new() {
	}

  public function enter(now : Float) {
      //Configuration.setScreen(new LoadingScreen());

      // Load room with our texture
      Loader.the.loadRoom("room0", loadingFinished);
  }

	function loadingFinished() {
    finishedLoading = true;
  }

  public function exit(now : Float){

	}

	public function update(now : Float, dt : Float, input : Input) : Bool{
		return finishedLoading;
	}

	public function render(now : Float, frame:Framebuffer, input : Input) {

  }

}
