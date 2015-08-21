package;

import ys.App;
import ys.Shell;

import cosmos.Model;

class Main {
	public static function main() {
		var model = new Model([]);
		App.start("YS_test",new Shell([new LoadingScreen(), new TestScreen(), new CosmosScreen(model)]));
	}
}
