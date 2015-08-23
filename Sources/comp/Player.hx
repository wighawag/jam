package comp;

class Player{
  public var goingLeft : Bool;
  public var goingRight : Bool;
  public var jump : Bool;
  public var jumping : Bool;
  public var crouch : Bool;
  public var life : Float=1;

  public function new(){
    reset();
    jumping = false;
  }

  public function reset(){
    goingLeft = false;
    goingRight = false;
    jump = false;
     crouch = false;
  }
  
}
