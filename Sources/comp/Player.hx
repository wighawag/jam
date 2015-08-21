package comp;

class Player{
  public var goingLeft : Bool;
  public var goingRight : Bool;

  public function new(){
    reset();
  }

  public function reset(){
    goingLeft = false;
    goingRight = false;
  }
  
}
