package;

import kha.Framebuffer;


import kha.Color;
import cosmos.Entities;
import comp.Placement;
import comp.State;
import comp.Asset;
import comp.ColorComp;
import comp.Player;
import comp.Scene;
import comp.Mob;
import comp.Projectile;
import comp.Roc;
import comp.Piece;

import kha.math.Vector3;

import ys.Input;

import ys.sprite.Sprites;

using Khage;
import khage.g4.Buffer;
import khage.g4.OrthoCamera;
import khage.g4.Viewport;

import kha.math.Matrix4;

import kha.Loader;
import kha.FontStyle;

import kha.audio1.Audio;


class RectanglesAndSpritesPresenter implements CosmosKhaPresenter{

  inline static var FOCUS_WIDTH = 600;
	inline static var FOCUS_HEIGHT = 400;

	var backgroundBuffer : Buffer<{pos:Vec3}>;
	var testBuffer : Buffer<{position:Vec3,alpha:Float,texCoords:Vec2}>;
	var viewport : Viewport = new Viewport({type : Fill, position: Center});
	var camera : OrthoCamera = new OrthoCamera(FOCUS_WIDTH,FOCUS_HEIGHT);

  var spriting : Sprites;

  var rectangles : Entities<{placement:Placement, color : ColorComp}>;
  var projs : Entities<{placement : Placement, proj :Projectile}>;
  var mobs : Entities<{placement:Placement, mob: Mob}>;
  var sprites : Entities<{placement:Placement, state: State, asset : Asset}>;
  var players : Entities<{placement:Placement,player:Player}>; //the focus should probably done in the model ? maybe an entity with a component focus?
  /*var scenes : Entities<{scene:Scene}>;*/

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

  // public function start(now : Float){
  //
  // }

  public function render(elapsedTime : Float, frame:Framebuffer, input : Input) : Void{

    /*var sceneEntity : Scene = null;
    for(p in scenes){
      sceneEntity = p.scene;
      break;
    }*/

    var mobPlacement : Placement = null;
    for(m in mobs){
      mobPlacement = m.placement;
      break;
    }

    var playerPlacement : Placement = null;
    var player : Player = null;
    for(p in players){
      playerPlacement = p.placement;
      player=p.player;
      break;
    }
    if(playerPlacement != null){
        camera.centerOn(playerPlacement.x,0);
    }else{
      camera.centerOn(0,0);
    }

    /*if(sceneEntity.interlude==false && sceneEntity.gameover==false){*/

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
      spriting.writeToBuffer(testBuffer,context,"night", "idle",elapsedTime,90+ (playerPlacement.x)*99/100,0, 0, 1.3*FOCUS_WIDTH, 1.3*FOCUS_HEIGHT, true);
      /*spriting.writeToBuffer(testBuffer,context,"prarie", "idle",elapsedTime, FOCUS_WIDTH,0, 0, FOCUS_WIDTH, FOCUS_HEIGHT, true);
      spriting.writeToBuffer(testBuffer,context,"castle", "idle",elapsedTime, 2*FOCUS_WIDTH,0, 0, FOCUS_WIDTH, FOCUS_HEIGHT, true);*/
      for(i in 0...206){
      spriting.writeToBuffer(testBuffer,context,"greengrass", "idle",elapsedTime,-300+i*60, 160, 0, 60, 67, false);
     }
     for(i in 0...20){
      spriting.writeToBuffer(testBuffer,context,"greengrass", "idle",elapsedTime,12200+i*60, 160, 0, 60, 67, false);
     }
     
      for(sprite in sprites){
        var placement = sprite.placement;
        var state = sprite.state;
        var asset = sprite.asset;
        if(asset.id == "player"){
          context.save();
          context.scale(0.4,0.4);
          spriting.writeToBuffer(testBuffer,context,asset.id,state.state,state.getElapsedTime(elapsedTime),placement.x,placement.y,0, 0, 0, true);
          context.restore();
        }else{
          spriting.writeToBuffer(testBuffer,context,asset.id,state.state,state.getElapsedTime(elapsedTime),placement.x,placement.y,0, placement.width, placement.height, true);
        }

      }


 			context.restore();

 			g4.usingProgram("texture.vert","normal.frag",{
 				program.set_viewproj(camera.viewproj);
 				program.set_tex(spriting.image);
        program.set_normal(spriting.normal);
        /*program.set_ambientColor(1,1,1,1);*/
        /*program.set_ambientColor(0.5,0.5,0.5,0.5);*/
        /*program.set_ambientColor(0.25,0.25,0.25,0.25);*/
        /*program.set_ambientColor(0.1,0.1,0.1,0.1);*/
        program.set_ambientColor(0.4,0.4,0.4,0.4);
        program.set_ambientColor2(0.4,0.4,0.4,0.4);

        if(playerPlacement != null){
          var lightPosVec = new Vector3(90+80+ (playerPlacement.x)*99/100,-30,0.075);
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


        var lightPosVec2 = new Vector3(mobPlacement.x+30,mobPlacement.y+30,0.075);
        var newLightPosVec2 = camera.toBufferCoordinates(lightPosVec2);
        program.set_lightPos2(newLightPosVec2.x, newLightPosVec2.y, newLightPosVec2.z);
        program.set_lightColor2(1,1,0,1);
        /*program.set_falloff2(0.2,0.8,20);*/
        program.set_falloff2(0.2,0.4,200);

 				program.draw(testBuffer);

 			});

 		});


    frame.usingG2({
      g2.pushTransformation(camera.g2Transformation);
      /*g2.color = Color.Red;
      g2.fillRect(12200, 50,50, 50);

      g2.color = Color.Red;
      g2.fillRect(12030, 110,1, 50);

      g2.color = Color.Red;
      g2.fillRect(12170, 110,1, 50);*/

        g2.color = Color.Black;
        g2.fillRect(-FOCUS_WIDTH*3/2+ (playerPlacement.x), -FOCUS_HEIGHT/2,FOCUS_WIDTH, FOCUS_HEIGHT);

        g2.color = Color.Black;
        g2.fillRect(FOCUS_WIDTH/2+ (playerPlacement.x),-FOCUS_HEIGHT/2, FOCUS_WIDTH, FOCUS_HEIGHT);

        g2.color = Color.Black;
        g2.fillRect(-FOCUS_WIDTH/2+ (playerPlacement.x),180, FOCUS_WIDTH, FOCUS_HEIGHT);

      for(sprite in sprites){
        var placement = sprite.placement;
        if(placement.contact==true){g2.color = Color.Red;}
        else{g2.color = Color.Blue;}
        /*g2.drawRect(placement.rect.x-placement.rect.width/2 , placement.rect.y-placement.rect.height/2, placement.rect.width, placement.rect.height);*/
      }
      g2.popTransformation();
     });


    frame.usingG2({
      
      g2.color = Color.Yellow;
      g2.font = Loader.the.loadFont("Arial", new FontStyle(false, false, false), 24);
      g2.drawString("PIECE",5,5);
      g2.drawString("COLLISION",5,25);
      g2.drawString("HIGHSCORE",5,45);

      g2.drawString(""+player.contactpiece+"",200,5);
      g2.drawString(""+player.contactnumber+"",200,25);
      g2.drawString(""+(player.contactnumber/5*1000+player.contactpiece*50)+"",200,45);
      
      
     });

   if(player.life==0){
    frame.usingG2({

      g2.color = Color.Green;
      g2.font = Loader.the.loadFont("Arial", new FontStyle(false, false, false), 24);
      g2.drawString("GameOver",frame.width/2,frame.height/2);


     });
    }

    if(playerPlacement.x>12500){
    frame.usingG2({

      g2.color = Color.Green;
      g2.font = Loader.the.loadFont("Arial", new FontStyle(false, false, false), 24);
      g2.drawString("You Win",frame.width/2,frame.height/2);


     });
    }

  /*}
  else if(sceneEntity.interlude==true && sceneEntity.gameover==false){
    frame.usingG2({
      g2.clear();
      g2.color = Color.Green;
      g2.drawString("Well Done Your HighScore is:...",frame.width/2,frame.height/2);


     });
  }
  else if(sceneEntity.interlude==false && sceneEntity.gameover==true){
    frame.usingG2({
      g2.clear();
      g2.color = Color.Green;
      g2.drawLine(0,0,frame.width,frame.height);
      g2.drawString("GameOver",frame.width/2,frame.height/2);


     });
  }
*/

  }
}
