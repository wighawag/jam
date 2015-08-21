package;

import kha.Game;
import kha.Framebuffer;
import kha.Color;
import kha.graphics4.Usage;


import khage.g4.Program;
import khage.g4.Buffer;
import khage.g4.Viewport;
import khage.g4.OrthoCamera;

import kha.math.Matrix4;

import kha.Image;
import kha.Loader;
using Khage;

import ys.Shell;
import ys.Input;

using ys.sprite.Sprites;

class TestScreen implements Screen {

	inline static var FOCUS_WIDTH = 600;
	inline static var FOCUS_HEIGHT = 400;

	var backgroundBuffer : Buffer<{pos:Vec3}>;
	var testBuffer : Buffer<{position:Vec3,alpha:Float,texCoords:Vec2}>;
	var viewport : Viewport = new Viewport({type : KeepRatioUsingBorder(FOCUS_WIDTH, FOCUS_HEIGHT), position: Center});
	var camera : OrthoCamera = new OrthoCamera(FOCUS_WIDTH,FOCUS_HEIGHT);

	var sprites : Sprites;

	public function new() {
	}

	public function enter(input : Input){
		testBuffer = new Buffer<{position:Vec3,alpha:Float,texCoords:Vec2}>(1000,1000,DynamicUsage);
		backgroundBuffer = new Buffer<{pos:Vec3}>(4,6,StaticUsage);

		backgroundBuffer.rewind();
		backgroundBuffer.write_pos(-1.0, -1.0, 0.0); // Bottom-left
	  backgroundBuffer.write_pos(1.0, -1.0, 0.0); // Bottom-right
	  backgroundBuffer.write_pos(1.0,  1.0, 0.0);  // Top
		backgroundBuffer.write_pos(-1.0, 1.0, 0.0);
		backgroundBuffer.writeIndex(0);
		backgroundBuffer.writeIndex(1);
		backgroundBuffer.writeIndex(2);
		backgroundBuffer.writeIndex(0);
		backgroundBuffer.writeIndex(2);
		backgroundBuffer.writeIndex(3);

		sprites = Sprites.load("dummy_sprites.json");
	}

  public function exit(elapsedTime : Float){
		testBuffer = null;
		backgroundBuffer = null;
	}

	public function update(elapsedTime : Float, dt : Float, input : Input) : Bool{
		return input.isKeyDown(kha.Key.ENTER) && elapsedTime > 0.5;
	}

	public function render(elapsedTime : Float, frame:Framebuffer, input : Input) {
		viewport.ensureSize(frame.width, frame.height);
		camera.handleViewport(viewport);
		camera.centerOn(0,0);//Math.sin(now),Math.cos(now));

		frame.usingG4({

			viewport.apply(g4);

			g4.clear(Color.Black);

			g4.usingProgram("simple.vert","simple.frag",{
				program.set_viewproj(Matrix4.identity());
				program.set_color(0.2,0.2,0.2,1);
				program.draw(backgroundBuffer);
			});


			var context = new ys.g.Context();
			context.save();
			testBuffer.rewind();
			sprites.writeToBuffer(testBuffer,context,"dummy", "idle",elapsedTime, 20,20,0, 100, 100, true);
			context.restore();

			g4.usingProgram("texture.vert","texture.frag",{
				program.set_viewproj(camera.viewproj);
				program.set_tex(sprites.image);
				program.draw(testBuffer);
			});

		});



		frame.usingG2({
			g2.color = Color.White;
			g2.pushTransformation(camera.g2Transformation);
		 	sprites.draw(g2, "dummy", "idle",elapsedTime, 30,30, 100, 100, true);
			g2.popTransformation();
		 });

  }

}
