package;

import kha.Framebuffer;
import ys.Shell;
import ys.Input;

import cosmos.Model;

import ys.sprite.Sprites;

import syst.Populator;
import syst.Controller;
import syst.Physics;
import syst.Collision;
import syst.SceneSys;

import kha.audio1.Audio;
import kha.Loader;

class GameScreen implements Screen {

  var _model : Model;
  var _presenter : CosmosKhaPresenter;

	public function new() {

	}

  public function enter(input : Input) {
    _model = new Model([new Populator(), new Controller(input),new Physics(new SceneSys()) , new Collision()]);
    _presenter = new RectanglesAndSpritesPresenter(Sprites.load("dummy_sprites.json"));
    _model.setupPresenter(_presenter);

    _model.start(0);
    Audio.playMusic(Loader.the.getMusic("music"), true);
  }

  public function exit(elapsedTime : Float){

	}

	public function update(elapsedTime : Float, dt : Float, input : Input) : Bool{
    _model.update(elapsedTime, dt);
		return false; //_model._systems.get(Physics).sceneSys.gameover;
	}

	public function render(elapsedTime : Float, frame:Framebuffer, input : Input) {
    _presenter.render(elapsedTime, frame, input);
  }

}
