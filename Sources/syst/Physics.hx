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

import kha.Color;

import ys.Input;
import kha.Key;

class Physics implements System{

  var players : Entities<{placement : Placement, player : Player}>;

	public function update(now : Float, dt : Float){

    for(p in players){
        if(p.player.goingLeft&& p.player.jumping==false){
          p.placement.vx =  -200;
        }
        else if(p.player.goingRight&& p.player.jumping==false){
          p.placement.vx =  200;
        }
        else if( p.player.jumping==false){ p.placement.vx =0;}

        

        if(p.player.jump==true && p.player.jumping==false){
          p.player.jumping=true;
          p.placement.vy = - dt * 10000;
        }

        if(p.player.jumping){
          p.placement.vy += dt * 200;
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

       if(p.player.crouch){
          
        }
    }

  }

}
