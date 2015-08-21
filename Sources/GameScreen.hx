package;

import kha.Framebuffer;
import ys.Shell;
import ys.Input;

import cosmos.Model;

import ys.sprite.Sprites;

import syst.Populator;
import syst.Controller;
import syst.Physics;

class GameScreen implements Screen {

  var _model : Model;
  var _presenter : CosmosKhaPresenter;

	public function new() {

	}

  public function enter() {

  }

  public function exit(elapsedTime : Float){

	}

	public function update(elapsedTime : Float, dt : Float, input : Input) : Bool{
    if(_model == null){
      _model = new Model([new Populator(), new Controller(input), new Physics()]);
  		_presenter = new RectanglesAndSpritesPresenter(Sprites.load("dummy_sprites.json"));
      _model.setupPresenter(_presenter);

      _model.start(0);
    }
    _model.update(elapsedTime, dt);
		return false;
	}

	public function render(elapsedTime : Float, frame:Framebuffer, input : Input) {
    _presenter.render(elapsedTime, frame);
  }

}
