package;

import kha.Game;
import kha.Framebuffer;
import kha.Color;
import kha.graphics4.Usage;

import kha.math.Matrix4;


import khage.g4.Program;
import khage.g4.Buffer;
import khage.g4.Viewport;

using Khage;

import ys.Shell;
import ys.Input;

class TestScreen2 implements Screen {

	var testBuffer : Buffer<{pos:Vec3}>;

	public function new() {
	}

	public function enter(input : Input){
		testBuffer = new Buffer<{pos:Vec3}>(3,3,StaticUsage);

		testBuffer.rewind();
		testBuffer.write_pos(-1.0, -1.0, 0.0); // Bottom-left
		testBuffer.write_pos(1.0, -1.0, 0.0); // Bottom-right
		testBuffer.write_pos(0.0,  1.0, 0.0);  // Top

		testBuffer.writeIndex(0);
		testBuffer.writeIndex(1);
		testBuffer.writeIndex(2);

	}

  public function exit(elapsedTime : Float){

	}

	public function update(elapsedTime : Float, dt : Float, input : Input) : Bool{
		return input.isKeyDown(kha.Key.ENTER) && elapsedTime > 0.5;
	}

	public function render(elapsedTime : Float, frame:Framebuffer, input : Input) {
		frame.usingG4({
			g4.clear(Color.Green);


			g4.usingProgram("simple.vert","simple.frag",{
				program.set_viewproj(Matrix4.identity());
				if(input.isCharDown(" ")){
					program.set_color(0.3,0,0.5,1);
				}else{
					program.set_color(0.2,0.2,0.1,1);
				}

				program.draw(testBuffer);
			});

		});


  }

}
