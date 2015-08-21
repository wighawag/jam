package mathtool;

class Vecteur2
{
    public var x:Float;
    public var y:Float;
    
    public function new(x:Float, y:Float)
    {
        this.x = x;
        this.y = y;
    }
}

@:forward(x, y)
abstract Vector2(Vecteur2) from Vecteur2 to Vecteur2{

	public static var UVX(get, never):Vector2;

    public static var UVY(get, never):Vector2;
    
    public var length(get, never):Float;

    public var lengthSquare(get, never):Float;

    public var angle(get, never):Float;

    public var normal(get, never):Vector2;


	public inline function new(x:Float, y:Float){
		this = new Vecteur2(x, y);
	}

	@:op(A * B)
    public static inline function dotproduct(a:Vector2, b:Vector2):Float
    {
        return
            a.x * b.x +
            a.y * b.y;
    }

    @:op(A ^ B)
    public static inline function falsecrossproduct2(a:Vector2, b:Vector2):Float
    {
        return  (a.x * b.y -
            a.y * b.x);
    }

    @:op(A * B)
    @:commutative
    public static inline function multiply(a:Vector2, s:Float):Vector2
    {
    	var bx=a.x*s;
    	var by=a.y*s;
        return new Vector2(bx,by);
    }

    public inline function normalize():Vector2
    {
        var vec:Vector2 = this;
        
        var length = vec.length;
        
        if (length > 0.0)
        {
            vec.x=vec.x/length;
            vec.y=vec.y/length;
        }
        
        return vec;
    }

    public inline function normalizeTo(newLength:Float):Vector2
    {
       var vec:Vector2 = this;
        
        vec.normalize();
        vec.x=vec.x*newLength;
        vec.y=vec.y*newLength;
        
        return vec;
    }

    private static inline function get_UVX():Vector2
    {
        return new Vector2(1.0, 0.0);
    }
    
    private static inline function get_UVY():Vector2
    {
        return new Vector2(0.0, 1.0);
    }
    
    private inline function get_length():Float
    {
        var vec:Vector2 = this;
        return Math.sqrt(
            vec.x * vec.x +
            vec.y * vec.y);
    }
    
    private inline function get_lengthSquare():Float
    {
        var vec:Vector2 = this;
        return
            vec.x * vec.x +
            vec.y * vec.y;
    }
    
    private inline function get_angle():Float
    {
        var vec:Vector2 = this;
        return Math.atan2(vec.y, vec.x);
    }
    
    private inline function get_normal():Vector2
    {
         var vec:Vector2 = this;
        
        var length = vec.length;
        
        if (length > 0.0)
        {
            vec.x=vec.x/length;
            vec.y=vec.y/length;
        }
        
        return vec;
    }
}