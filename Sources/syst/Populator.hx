package syst;

import cosmos.EntityType;
import cosmos.System;

using cosmos.ModelAccess;

import comp.Placement;
import comp.State;
import comp.Asset;
import comp.ColorComp;

import kha.Color;



class Populator implements System{

	public function start(now : Float) {

		model.addEntity([new Placement(100,100,200,200), new ColorComp(Color.Blue)]);

    model.addEntity([new Placement(100,100,50,50), new State("idle", now), new Asset("dummy")]);

	}

}
