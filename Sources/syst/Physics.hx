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
        if(p.player.goingLeft){
          p.placement.x -= dt * 100;
        }else if(p.player.goingRight){
          p.placement.x += dt * 100;
        }
    }

  }

}
