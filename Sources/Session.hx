package;

class Session{
  public var screen : Float;
  public var interlude : Bool;
  public var gameover:Bool;
  public var winning:Bool;
  public var highScore:Float;

  public function new(){
    reset();
  }
  
  public function reset(){
    screen=1;
    interlude=false;
    gameover=false;
    highScore=0;
    winning=false;
  }

}
