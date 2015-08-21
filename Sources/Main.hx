package;

import ys.App;
import ys.Shell;

import cosmos.Model;
import syst.Populator;

class Main {
	public static function main() {
		var model = new Model([new Populator()]);
		App.start("YS_test",new Shell([new LoadingScreen(), new TestScreen(), new CosmosScreen(model, new RectanglesAndSpritesPresenter(),"dummy_sprites.json")]));
	}
}
