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

  public function new(){
    reset();
    jumping = false;
    rolling=false;
    distroll=0;
  }

  public function reset(){
    goingLeft = false;
    goingRight = false;
    jump = false;
    roll = false;
  }
  
}
