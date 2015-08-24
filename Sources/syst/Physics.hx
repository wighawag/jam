package syst;

import cosmos.Entities;
import cosmos.EntityType;
import cosmos.System;

using cosmos.ModelAccess;

import syst.SceneSys;

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

import kha.Color;

import ys.Input;
import kha.Key;

class Physics implements System{

  var players : Entities<{placement : Placement,state:State, player : Player}>;
  var mobs : Entities<{placement : Placement, mob : Mob}>;
  var projs : Entities<{placement : Placement, proj :Projectile}>;
  /*var scenes : Entities<{scene:Scene}>;*/
  var pieces : Entities<{placement : Placement, piece :Piece}>;
  var rocs : Entities<{placement : Placement, roc :Roc}>;
  public var sceneSys:SceneSys;

  public function new(sceneSys:SceneSys){
    this.sceneSys = sceneSys;
     }

	public function update(now : Float, dt : Float){
    
    var playerPlacement : Placement = null;
    /*var sceneEntity : Scene = null;
    for(p in scenes){
      sceneEntity = p.scene;
      break;
    }*/
    

    for(m in mobs){
      m.placement.vx =  m.mob.speed;
      m.placement.x+= dt * m.placement.vx;
      m.placement.rect.x=m.placement.x-10;
      m.placement.rect.y=m.placement.y;
      m.placement.rect.width=130;
      m.mob.timelaunch-=1;

      if(m.mob.proj1==false && m.mob.proj2==false && m.mob.timelaunch==0){
        var rand=Std.int(Math.random()*2);
        if(rand==0){
          m.mob.timelaunch=80;
          model.addEntity([new Placement(m.placement.x,80,60,20), new State("idle", now), new Asset("spear"), new Projectile(200+ m.placement.vx)]);
        }else if(rand==1){
          m.mob.timelaunch=80;
          model.addEntity([new Placement(m.placement.x,130,30,20), new State("idle", now), new Asset("fire"), new Projectile(200+ m.placement.vx)]);
        }
      }
     } 

     for(j in projs){
      j.placement.x+= dt * j.proj.speed;
      j.placement.rect.x=j.placement.x;
      j.placement.rect.y=j.placement.y;
      j.proj.lifetime-=1;
      if(j.proj.lifetime==0){model.removeEntity(j);}
      /*if(j.proj.contact==true){model.removeEntity(j);}*/

      } 


    for(p in players){
      /*if(p.player.speed>p.player.maxspeed){p.player.speed=p.player.maxspeed;}
      if(p.player.contactroc==true){p.placement.vx =  p.player.speed/2;}
      else{p.placement.vx =  p.player.speed;}*/

      p.placement.vx =  p.player.speed;
      
        /*if(p.player.goingLeft&& p.player.jumping==false){
          p.placement.vx =  -300;
        }
        else if(p.player.goingRight&& p.player.jumping==false){
          p.placement.vx =  300;
        }
        else if( p.player.jumping==false){ p.placement.vx =0;}*/

        

        if(p.player.jump==true && p.player.rolling==false && p.player.jumping==false){
          p.state.setState("jump",now);
          p.player.jumping=true;
          p.placement.vy = - dt * 15500;
        }

        if(p.player.jumping){
          p.placement.vy += dt * 500;
          /*if(p.placement.vx>=10){ p.placement.vx += dt * 200;}
          else if(p.placement.vx<=-10){}
          else{ } */
        }

        if(p.placement.y>110 && p.player.jumping==true){
          p.placement.vy=0;
          p.placement.y=110;
          p.player.jumping=false;
          p.state.setState("idle",now);
        }

        

        p.placement.x+= dt * p.placement.vx;
        p.placement.y+= dt * p.placement.vy;

        p.placement.rect.x=p.placement.x-10;
        p.placement.rect.y=p.placement.y;
        p.placement.rect.width=40;
        p.placement.rect.height=80;

        if(p.player.jumping==false && p.player.roll==true && p.player.rolling==false){
          p.player.rolling=true;
          p.player.distroll=0;
          p.state.setState("roll",now);
        }

        if(p.player.rolling==true){
          p.placement.y=120;
          p.player.distroll += p.placement.vx;
          p.placement.rect.y=10+p.placement.y;
          p.placement.rect.height=55;
        }

        if(p.player.distroll>12000 && p.player.rolling==true){
          p.placement.y=110;
          p.placement.rect.y=p.placement.y;
          p.placement.rect.height=80;
          p.player.rolling=false;
          p.state.setState("idle",now);
        }

        playerPlacement=p.placement;
        //////scene
        if(sceneSys.interlude==false){
          sceneSys.highScore=(p.player.contactnumber/5*1000+p.player.contactpiece*50);

          if(p.placement.x>11500){
          sceneSys.screen=2;
          sceneSys.interlude=true;
          }
          if(p.player.life==0){
            sceneSys.gameover=true;
          }
        }
      }
      for(pi in pieces){ if(pi.placement.x+100<playerPlacement.x){model.removeEntity(pi);}}

  }

}
