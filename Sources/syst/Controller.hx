package syst;

import cosmos.EntityType;
import cosmos.System;

using cosmos.ModelAccess;

import comp.Placement;
import comp.State;
import comp.Asset;
import comp.ColorComp;
import comp.Player;

import cosmos.Entities;

import kha.Color;

import ys.Input;
import kha.Key;

class Controller implements System{

  var players : Entities<{player : Player}>;
  var _input : Input;
  public function new(input : Input){
    _input = input;
  }

	public function update(now : Float, dt : Float){
    var player : Player = null;
    for(p in players){
      player = p.player;
      break;
    }
    if(player != null){
      player.reset();
      if(_input.isKeyDown(Key.LEFT)){
        player.goingLeft = true;
      }else if(_input.isKeyDown(Key.RIGHT)){
        player.goingRight = true;
      }
    }
  }

}
