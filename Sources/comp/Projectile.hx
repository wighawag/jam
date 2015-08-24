package comp;

class Projectile{

  public var speed : Float;
  public var lifetime:Float;
  public var contact:Bool;


  public function new(speed){
    this.speed=speed;
    contact=false;
    lifetime=100;
  }


  
}
