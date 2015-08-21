package;

import kha.Framebuffer;
import ys.Shell;
import ys.Input;

import cosmos.Model;

import ys.sprite.Sprites;

class CosmosScreen implements Screen {

  var _model : Model;
  var _presenter : CosmosKhaPresenter;
  var _spritesPath : String;

	public function new(model : Model, presenter : CosmosKhaPresenter, spritesPath : String) {
    _model = model;
    _presenter = presenter;
    _model.setupPresenter(presenter);
    _spritesPath = spritesPath;
	}

  public function enter() {
    var sprites = Sprites.load(_spritesPath);
    _presenter.setSprites(sprites);
    _model.start(0);
  }

  public function exit(elapsedTime : Float){

	}

	public function update(elapsedTime : Float, dt : Float, input : Input) : Bool{
    _model.update(elapsedTime, dt);
		return false;
	}

	public function render(elapsedTime : Float, frame:Framebuffer, input : Input) {
    _presenter.render(elapsedTime, frame);
  }

}
