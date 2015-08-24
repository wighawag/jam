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
  public var life : Float=10;
  public var speed:Float;
  public var maxspeed:Float;
  public var contact:Bool;
  public var contactnumber:Float=0;
  public var contactroc:Bool=false;
  public var contactpiece:Float=0;
  public var fall : Bool;

  public function new(speed){
    reset();

    jumping = false;
    rolling=false;
    distroll=0;
    this.speed=speed;
    maxspeed=speed;
    contact=false;
    fall=false;
  }

  public function reset(){
    goingLeft = false;
    goingRight = false;
    jump = false;
    roll = false;
  }
  
}
