package;

import kha.Framebuffer;
import kha.Loader;

import ys.Shell;
import ys.Input;

import kha.Color;
import kha.Font;
import kha.FontStyle;

using Khage;

class GameOverScreen implements Screen {

	var _session : Session;
	public function new(session : Session) {
		_session = session;
	}

  public function enter(input : Input) {
  }

  public function exit(elapsedTime : Float){

	}

	public function update(elapsedTime : Float, dt : Float, input : Input) : Bool{
		return input.isKeyDown(kha.Key.UP) && elapsedTime > 1;
	}

	public function render(elapsedTime : Float, frame:Framebuffer, input : Input) {
		if(_session.gameover==true){
		frame.usingG2({
			g2.clear();
			g2.color = Color.Green;

			g2.font = Loader.the.loadFont("GrapeSoda", new FontStyle(false, false, false), 72);
			g2.drawString("Game Over",frame.width/2 - 250 ,frame.height/2 - 30);
			g2.font = Loader.the.loadFont("Arial", new FontStyle(false, false, false), 24);
			g2.drawString("Score: " +_session.highScore,frame.width/2 - 250 ,frame.height/2 + 50);
			g2.drawString("press UP to restart: ",frame.width/2 - 250 ,frame.height/2 + 200);

		 });
		}
		else if(_session.winning==true){
		frame.usingG2({
			g2.clear();
			g2.color = Color.Green;

			g2.font = Loader.the.loadFont("GrapeSoda", new FontStyle(false, false, false), 72);
			g2.drawString("WELL DONE!!!",frame.width/2 - 250 ,frame.height/2 - 30);
			g2.font = Loader.the.loadFont("Arial", new FontStyle(false, false, false), 24);
			g2.drawString("Score: " +_session.highScore,frame.width/2 - 250 ,frame.height/2 + 50);
			g2.drawString("press UP to restart: ",frame.width/2 - 250 ,frame.height/2 + 200);

		 });
		}
  }

}
