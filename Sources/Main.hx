package;

import ys.App;
import ys.Shell;

class Main {
	public static function main() {
		App.start("YS_test",new Shell([new LoadingScreen(), new TestScreen(), new TestScreen2()]));
	}
}
