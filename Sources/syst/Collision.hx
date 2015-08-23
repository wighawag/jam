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
import mathtool.RectPoly;
import mathtool.Util;

class Collision implements System{

  var players : Entities<{placement : Placement, player : Player}>;
  var mobs : Entities<{placement : Placement, mob : Mob}>;

	public function update(now : Float, dt : Float){
		var mobPlacement : Placement = null;
    	for(m in mobs){
      		mobPlacement = m.placement;
      		break;
    	}

    	var playerPlacement : Placement = null;
    	for(p in players){
      		playerPlacement = p.placement;
      		if(Util.AABB(playerPlacement.rect,mobPlacement.rect)==true){
      			p.player.life=0;
      		}
      		break;
    	}
    

    }

	
}