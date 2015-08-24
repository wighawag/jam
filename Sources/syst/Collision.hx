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
import comp.Projectile;
import comp.Roc;
import comp.Piece;


import kha.Color;

import ys.Input;
import kha.Key;
import mathtool.RectPoly;
import mathtool.Util;

class Collision implements System{

  var players : Entities<{placement : Placement, player : Player}>;
  var mobs : Entities<{placement : Placement, mob : Mob}>;
    var projs : Entities<{placement : Placement, proj :Projectile}>;
    var pieces : Entities<{placement : Placement, piece :Piece}>;
    var rocs : Entities<{placement : Placement, roc :Roc}>;

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

      		var projPlacement : Placement = null;
    		for(j in projs){
      			projPlacement = j.placement;
 	
      			if(Util.AABB(playerPlacement.rect,projPlacement.rect)==true ){
      				p.player.contactnumber+=1;
             /* p.player.speed-=1;*/
      				p.player.contact=true;
      				p.placement.contact=true;
      				/*j.placement.contact=true;*/
               model.removeEntity(j);
      			}
      			else{
      				p.player.contact=false;
      				p.placement.contact=false;
      				j.placement.contact=false;
      			}
      		}
      		for(r in rocs){
 	
      			if(Util.AABB(playerPlacement.rect,r.placement.rect)==true){
      				p.player.contactroc=true;
      				p.player.contact=true;
      				p.placement.contact=true;
      				r.placement.contact=true;
      			}
      			else{
              p.player.contactroc=false;
      				p.player.contact=false;
      				p.placement.contact=false;
      				r.placement.contact=false;
      			}
      		}

          for(pi in pieces){
  
            if(Util.AABB(playerPlacement.rect,pi.placement.rect)==true){
              p.player.contactpiece+=1;
              /*p.player.speed+=0.1;*/
              p.player.contact=true;
              p.placement.contact=true;
              model.removeEntity(pi);
              /*pi.placement.contact=true;*/
            }
            else{
              p.player.contact=false;
              p.placement.contact=false;
              pi.placement.contact=false;
            }
          }

      		break;
    	}
    

    }

	
}