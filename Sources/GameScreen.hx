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
import kha.audio1.Audio;
import kha.Loader;

class GameScreen implements Screen {

  var _model : Model;
  var _presenter : CosmosKhaPresenter;

  var _session : Session;
	public function new(session : Session) {
		_session = session;
	}

  public function enter(input : Input) {
    _session.reset();
    _model = new Model([new Populator(), new Controller(input),new Physics(_session) , new Collision()]);
    _presenter = new RectanglesAndSpritesPresenter(Sprites.load("dummy_sprites.json"));
    _model.setupPresenter(_presenter);

    _model.start(0);
    Audio.playMusic(Loader.the.getMusic("music"), true);
  }

  public function exit(elapsedTime : Float){

	}

	public function update(elapsedTime : Float, dt : Float, input : Input) : Bool{
    _model.update(elapsedTime, dt);
		return _session.gameover || _session.winning;
	}

	public function render(elapsedTime : Float, frame:Framebuffer, input : Input) {
    _presenter.render(elapsedTime, frame, input);
  }

}
