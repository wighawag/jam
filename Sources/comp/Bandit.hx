package comp;

class Bandit{
  public var goingLeft : Bool;
  public var goingRight : Bool;
  public var jump : Bool;
  public var jumping : Bool;
  public var crouch : Bool;

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
