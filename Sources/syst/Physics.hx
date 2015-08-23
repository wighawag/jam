package syst;

import cosmos.Entities;
import cosmos.EntityType;
import cosmos.System;

using cosmos.ModelAccess;

import comp.Placement;
import comp.State;
import comp.Asset;
import comp.ColorComp;
import comp.Player;
import comp.Scene;
import comp.Mob;

import kha.Color;

import ys.Input;
import kha.Key;

class Physics implements System{

  var players : Entities<{placement : Placement,state:State, player : Player}>;
  var mobs : Entities<{placement : Placement, mob : Mob}>;
  var scenes : Entities<{scene:Scene}>;

	public function update(now : Float, dt : Float){
    
    var sceneEntity : Scene = null;
    for(p in scenes){
      sceneEntity = p.scene;
      break;
    }
    

    for(m in mobs){
      m.placement.vx =  310;
      m.placement.x+= dt * m.placement.vx;
      m.placement.rect.x=m.placement.x-10;
      m.placement.rect.y=m.placement.y;
      m.placement.rect.width=130;
     }  

    for(p in players){
      p.placement.vx =  300;
        /*if(p.player.goingLeft&& p.player.jumping==false){
          p.placement.vx =  -300;
        }
        else if(p.player.goingRight&& p.player.jumping==false){
          p.placement.vx =  300;
        }
        else if( p.player.jumping==false){ p.placement.vx =0;}*/

        

        if(p.player.jump==true && p.player.jumping==false){
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
        }
        p.placement.x+= dt * p.placement.vx;
        p.placement.y+= dt * p.placement.vy;

        p.placement.rect.x=p.placement.x-10;
        p.placement.rect.y=p.placement.y;
        p.placement.rect.width=40;

        if(p.player.crouch){
          p.state.setState("crouch",now);
        }
        else if(p.player.jumping){
          p.state.setState("jump",now);
        }
        else{
          p.state.setState("idle",now);
        }

        //////scene
        if(sceneEntity.interlude==false){

          if(p.placement.x>9000){
          sceneEntity.screen=2;
          sceneEntity.interlude=true;
          }
          if(p.player.life==0){
            sceneEntity.gameover=true;
          }
        }


    }

  }

}
