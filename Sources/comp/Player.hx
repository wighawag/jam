package comp;

class Player{
  public var goingLeft : Bool;
  public var goingRight : Bool;
  public var jump : Bool;
  public var jumping : Bool;
  public var crouch : Bool;
   public var roll : Bool;
  public var rolling : Bool;
  public var distroll:Float;
  public var life : Float=1;
  public var speed:Float;

  public function new(speed){
    reset();

    jumping = false;
    rolling=false;
    distroll=0;
    this.speed=speed;
  }

  public function reset(){
    goingLeft = false;
    goingRight = false;
    jump = false;
    roll = false;
  }
  
}
