package mathtool;

class RectPoly
{
	public var x:Float;
    public var y:Float;
    public var width:Float;
    public var height:Float;
    public var x1:Float;
    public var x2:Float;
    public var y1:Float;
    public var y2:Float;

    public function new(x:Float, y:Float, width:Float, height:Float) 
    {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.x1=x-width/2;
        this.x2=x+width/2;
        this.y1=y-height/2;
        this.y2=y+height/2;

    }

}    