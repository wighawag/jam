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
import comp.Roc;
import comp.Piece;

import kha.Color;



class Populator implements System{

	public function start(now : Float) {

	model.addEntity([new Scene()]);

	model.addEntity([new Placement(0,120,200,200), new ColorComp(Color.Black)]);

    model.addEntity([new Placement(	-500,110,60,80), new State("idle", now), new Asset("player"), new Player(200)]);



   ////////////////////////////////////roc
   model.addEntity([new Placement(100,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   model.addEntity([new Placement(400,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(1000,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(1400,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(2000,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(2700,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(3200,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(3800,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(4400,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(5600,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(5900,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(6150,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(6600,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(7800,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(8300,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(8700,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(9300,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(10000,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	model.addEntity([new Placement(11000,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	//model.addEntity([new Placement(11500,140,40,40), new State("idle", now), new Asset("roc"), new Roc()]);
   	///pit a 11500
   	/////////////////piece
   	for(i in 0...100 ){
   		var rand=Std.int(Math.random()*3);
   		if(rand==0){
   			model.addEntity([new Placement(100+i*120,60,15,15), new State("idle", now), new Asset("piece"), new Piece()]);
   			model.addEntity([new Placement(140+i*120,60,15,15), new State("idle", now), new Asset("piece"), new Piece()]);
   			model.addEntity([new Placement(180+i*120,60,15,15), new State("idle", now), new Asset("piece"), new Piece()]);
   		}
   		else if(rand==1){
   			model.addEntity([new Placement(100+i*120,85,15,15), new State("idle", now), new Asset("piece"), new Piece()]);
   			model.addEntity([new Placement(140+i*120,85,15,15), new State("idle", now), new Asset("piece"), new Piece()]);
   			model.addEntity([new Placement(180+i*120,85,15,15), new State("idle", now), new Asset("piece"), new Piece()]);
   		}
   		else if(rand==2){
   			model.addEntity([new Placement(100+i*120,160,15,15), new State("idle", now), new Asset("piece"), new Piece()]);
   			model.addEntity([new Placement(140+i*120,160,15,15), new State("idle", now), new Asset("piece"), new Piece()]);
   			model.addEntity([new Placement(180+i*120,160,15,15), new State("idle", now), new Asset("piece"), new Piece()]);
   		}
   	}
   	 model.addEntity([new Placement(-210 - 500,110,150,150), new State("idle", now), new Asset("village"), new Mob(200,false,false)]);

	}

}
