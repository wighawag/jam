package syst;

import cosmos.EntityType;
import cosmos.System;

using cosmos.ModelAccess;

import comp.Placement;
import comp.State;
import comp.Asset;
import comp.ColorComp;
import comp.Player;
import comp.Bandit;
import comp.Scene;
import comp.Mob;

import kha.Color;



class Populator implements System{

	public function start(now : Float) {

	model.addEntity([new Scene()]);

	model.addEntity([new Placement(0,120,200,200), new ColorComp(Color.Black)]);

    model.addEntity([new Placement(0,110,60,80), new State("idle", now), new Asset("player"), new Player()]);

    model.addEntity([new Placement(-300,110,150,150), new State("idle", now), new Asset("village"), new Mob(1,0,0)]);

    model.addEntity([new Placement(200,110,50,50), new State("idle", now), new Asset("dummy"), new Bandit()]);

    model.addEntity([new Placement(500,110,50,50), new State("idle", now), new Asset("dummy"), new Bandit()]);

    model.addEntity([new Placement(700,110,50,50), new State("idle", now), new Asset("dummy"), new Bandit()]);

	}

}
