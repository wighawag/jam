package comp;

class Mob{

  public var speed : Float;
  public var proj1 :  Bool;
  public var launching:Bool;
  public var timelaunch:Float;
  public var proj2 :  Bool;
    public var contact:Bool;


  public function new(speed,proj1,proj2){
    this.speed=speed;
    this.proj1 = proj1;
    this.proj2 = proj2;
    launching=false;
    timelaunch=50;
    contact=false;

  }


  
}
