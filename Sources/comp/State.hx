package comp;

class State{
  public var state(default,null) : String = "idle";


  public function new(state : String, time : Float){
    setState(state,time);
  }

  public function getElapsedTime(now : Float){
    return now - _startTime;
  }

  public function setState(state : String, time : Float){
    this.state = state;
    this._startTime = time;
  }

  private var _startTime : Float = 0;
}
