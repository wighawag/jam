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

import kha.Color;



class Populator implements System{

	public function start(now : Float) {

	model.addEntity([new Scene()]);

	model.addEntity([new Placement(0,120,200,200), new ColorComp(Color.Blue)]);

    model.addEntity([new Placement(-270,110,80,80), new State("idle", now), new Asset("player"), new Player()]);


    model.addEntity([new Placement(200,110,50,50), new State("idle", now), new Asset("dummy"), new Bandit()]);

    model.addEntity([new Placement(500,110,50,50), new State("idle", now), new Asset("dummy"), new Bandit()]);

    model.addEntity([new Placement(700,110,50,50), new State("idle", now), new Asset("dummy"), new Bandit()]);

    //model.addEntity([new Placement(100,100,50,50), new State("idle", now), new Asset("dummy")]);

	}

}
