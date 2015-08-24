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

class SceneSys implements System{

  public var screen : Float;
  public var interlude : Bool;
  public var gameover:Bool;
  public var highScore:Float;
  

  public function new(){
    screen=1;
    interlude=false;
    gameover=false;
    highScore=0;
  }

   }