package;

import ys.App;
import ys.Shell;

import cosmos.Model;
import syst.Populator;

class Main {
	public static function main() {
		App.start("YS_test",new Shell([new LoadingScreen(), new TestScreen(), new GameScreen()]));
	}
}
