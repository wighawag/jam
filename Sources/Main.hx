package;

import ys.App;
import ys.Shell;

import cosmos.Model;
import syst.Populator;

class Main {
	public static function main() {
		var session = new Session();
		App.start("YS_test",new Shell([new LoadingScreen(),new StartScreen()],[new GameScreen(session), new GameOverScreen(session)]));
	}
}
