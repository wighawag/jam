package;

import kha.Framebuffer;

using Khage;
import kha.Color;
import cosmos.Entities;
import comp.Placement;
import comp.State;
import comp.Asset;
import comp.ColorComp;
import comp.Player;
import comp.Scene;

import kha.math.Vector3;

import ys.Input;

import ys.sprite.Sprites;

using Khage;
import khage.g4.Buffer;
import khage.g4.OrthoCamera;
import khage.g4.Viewport;

import kha.math.Matrix4;

class RectanglesAndSpritesPresenter implements CosmosKhaPresenter{

  inline static var FOCUS_WIDTH = 600;
	inline static var FOCUS_HEIGHT = 400;

	var backgroundBuffer : Buffer<{pos:Vec3}>;
	var testBuffer : Buffer<{position:Vec3,alpha:Float,texCoords:Vec2}>;
	var viewport : Viewport = new Viewport({type : Fill, position: Center});
	var camera : OrthoCamera = new OrthoCamera(FOCUS_WIDTH,FOCUS_HEIGHT);

  var spriting : Sprites;

  var rectangles : Entities<{placement:Placement, color : ColorComp}>;
  var sprites : Entities<{placement:Placement, state: State, asset : Asset}>;
  var players : Entities<{placement:Placement,player:Player}>; //the focus should probably done in the model ? maybe an entity with a component focus?
  var scenes : Entities<{scene:Scene}>;

  public function new(spriting : Sprites){
      this.spriting = spriting;

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
  }

  public function render(elapsedTime : Float, frame:Framebuffer, input : Input) : Void{

    var sceneEntity : Scene = null;
    for(p in scenes){
      sceneEntity = p.scene;
      break;
    }

    var playerPlacement : Placement = null;
    for(p in players){
      playerPlacement = p.placement;
      break;
    }
    if(playerPlacement != null){
        camera.centerOn(playerPlacement.x,0);
    }else{
      camera.centerOn(0,0);
    }
    
    if(sceneEntity.interlude==false){
      if(playerPlacement.x>FOCUS_WIDTH*4-400){
      sceneEntity.screen=2;
    sceneEntity.interlude=true;
  }
    viewport.ensureSize(frame.width, frame.height);
 		camera.handleViewport(viewport);

   
    frame.usingG4({

 			viewport.apply(g4);

 			g4.clear(Color.Black);

 			g4.usingProgram("simple.vert","simple.frag",{
 				program.set_viewproj(Matrix4.identity());
 				program.set_color(0,0,0,1);
 				program.draw(backgroundBuffer);
 			});
    });

    /*frame.usingG2({
      g2.pushTransformation(camera.g2Transformation);
      for(rectangle in rectangles){
        var placement = rectangle.placement;
        g2.color = rectangle.color.color;
        g2.drawRect(placement.x, placement.y, placement.width, placement.height);
      }

      // g2.color = Color.White;
      //
      // for(sprite in sprites){
      //   var placement = sprite.placement;
      //   var state = sprite.state;
      //   var asset = sprite.asset;
      //
      //   spriting.draw(g2,asset.id,state.state,state.getElapsedTime(elapsedTime),placement.x,placement.y, placement.width, placement.height, true);
      // }
      //

      g2.popTransformation();
		 });*/


 		frame.usingG4({

 			viewport.apply(g4);


 			var context = new ys.g.Context();
 			context.save();
 			testBuffer.rewind();
      spriting.writeToBuffer(testBuffer,context,"night", "idle",elapsedTime,0+ (270+playerPlacement.x)*3/4,0, 0, FOCUS_WIDTH, FOCUS_HEIGHT, true);
      /*spriting.writeToBuffer(testBuffer,context,"prarie", "idle",elapsedTime, FOCUS_WIDTH,0, 0, FOCUS_WIDTH, FOCUS_HEIGHT, true);
      spriting.writeToBuffer(testBuffer,context,"castle", "idle",elapsedTime, 2*FOCUS_WIDTH,0, 0, FOCUS_WIDTH, FOCUS_HEIGHT, true);*/
      spriting.writeToBuffer(testBuffer,context,"greengrass", "idle",elapsedTime,0+ ((FOCUS_WIDTH*2)-300), 160, 0, FOCUS_WIDTH*4, 56, false);
     
      for(sprite in sprites){
        var placement = sprite.placement;
        var state = sprite.state;
        var asset = sprite.asset;
        spriting.writeToBuffer(testBuffer,context,asset.id,state.state,state.getElapsedTime(elapsedTime),placement.x,placement.y,0, placement.width, placement.height, true);
      }

      
 			context.restore();

 			g4.usingProgram("texture.vert","normal.frag",{
 				program.set_viewproj(camera.viewproj);
 				program.set_tex(spriting.image);
        program.set_normal(spriting.normal);
        /*program.set_ambientColor(1,1,1,1);*/
        /*program.set_ambientColor(0.5,0.5,0.5,0.5);*/
        /*program.set_ambientColor(0.1,0.1,0.1,0.1);*/
        program.set_ambientColor(0.25,0.25,0.25,0.25);
        if(playerPlacement != null){
          var lightPosVec = new Vector3(80+ (270+playerPlacement.x)*3/4,-30,0.075);
          /*var lightPosVec = new Vector3(playerPlacement.x+30,playerPlacement.y-30,0.075);*/
          var newLightPosVec = camera.toBufferCoordinates(lightPosVec);

          program.set_lightPos(newLightPosVec.x, newLightPosVec.y, newLightPosVec.z);
          /*program.set_lightPos(newLightPosVec.x, newLightPosVec.y, newLightPosVec.z);*/
          trace(newLightPosVec);
        }else{
          program.set_lightPos(input.getMouseX(),input.getMouseY(),0.075);//lightPosVec.x, lightPosVec.y, lightPosVec.z);
        }

        program.set_lightColor(1,1,1,1);
        /*program.set_lightColor(1,0,0,1);*/

        program.set_resolution(frame.width, frame.height); //TODO use bufferWidth ...
        program.set_falloff(0.2,0.4,5); //TODO? would clear cache and set values to be uploaded only
        /*program.set_falloff(0.2,0.4,40);*/

       
        var lightPosVec2 = new Vector3(playerPlacement.x+30,playerPlacement.y-30,0.075);
        var newLightPosVec2 = camera.toBufferCoordinates(lightPosVec2);
        program.set_lightPos2(newLightPosVec2.x, newLightPosVec2.y, newLightPosVec2.z);
        program.set_lightColor2(1,1,0,1);
        program.set_falloff2(0.2,0.8,40);   

 				program.draw(testBuffer);

 			});

 		});
  }
  else{
    frame.usingG2({
      g2.clear();
      g2.color = Color.Green;
      g2.drawLine(0,0,frame.width,frame.height);
      g2.drawString("Once upon a Time...",frame.width/2,frame.height/2);

     });
  }


  }
}