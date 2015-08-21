package mathtool;

class Vecteur3
{
    public var x:Float;
    public var y:Float;
    public var z:Float;
    
    public function new(x:Float, y:Float, z:Float)
    {
        this.x = x;
        this.y = y;
        this.z = z;
    }
}

@:forward(x, y, z)
abstract Vector3(Vecteur3) from Vecteur3 to Vecteur3{

    public static var UVX(get, never):Vector3;

    public static var UVY(get, never):Vector3;

    public static var UVZ(get, never):Vector3;
    
    public var length(get, never):Float;

    public var lengthSquare(get, never):Float;

    //coord sphere
    public var angleTheta(get, never):Float;
    //corr sphere
    public var anglePhy(get,never):Float;

    public var normal(get, never):Vector3;

	public inline function new(x:Float, y:Float, z:Float){
		this = new Vecteur3(x, y, z);
	}

	@:op(A * B)
    public static inline function dotproduct(a:Vector3, b:Vector3):Float
    {
        return
            a.x * b.x +
            a.y * b.y +
            a.z * b.z ;
    }

    @:op(A ^ B)
    public static inline function crossproduct(a:Vector3, b:Vector3):Vector3
    {   
        var x=a.y * b.z -a.z * b.y;
        var y=a.z * b.x -a.x * b.z;
        var z=a.x * b.y -a.y * b.x;
        return  new Vector3(x, y, z);
    }

    @:op(A * B)
    @:commutative
    public static inline function multiply(a:Vector3, s:Float):Vector3
    {
        var bx=a.x*s;
        var by=a.y*s;
        var bz=a.z*s;
        return new Vector3(bx,by,bz);
    }

    public inline function normalize():Vector3
    {
        var vec:Vector3 = this;
        
        var length = vec.length;
        
        if (length > 0.0)
        {
            vec.x=vec.x/length;
            vec.y=vec.y/length;
            vec.z=vec.z/length;
        }
        
        return vec;
    }

    public inline function normalizeTo(newLength:Float):Vector3    {
       var vec:Vector3 = this;
        
        vec.normalize();
        vec.x=vec.x*newLength;
        vec.y=vec.y*newLength;
        vec.z=vec.z*newLength;
        
        return vec;
    }

    private static inline function get_UVX():Vector3{
        return new Vector3(1.0, 0.0, 0.0);
    }
    
    private static inline function get_UVY():Vector3{
        return new Vector3(0.0, 1.0, 0.0);
    }

    private static inline function get_UVZ():Vector3{
        return new Vector3(0.0, 0.0, 1.0);
    }
    
    private inline function get_length():Float{
        var vec:Vector3 = this;
        return Math.sqrt(
            vec.x * vec.x +
            vec.y * vec.y + 
            vec.z * vec.z);
    }
    
    private inline function get_lengthSquare():Float{
        var vec:Vector3 = this;
        return
            vec.x * vec.x +
            vec.y * vec.y + 
            vec.z * vec.z;
    }
    
    private inline function get_angleTheta():Float{
        var vec:Vector3 = this;
        return Math.atan2(vec.y, vec.x);
    }
    private inline function get_anglePhy():Float{
        var vec:Vector3 = this;
        return Math.atan2(vec.z, Math.sqrt(vec.x*vec.x+vec.y*vec.y));
    }
    
    private inline function get_normal():Vector3{
         var vec:Vector3 = this;
        
        var length = vec.length;
        
        if (length > 0.0)
        {
            vec.x=vec.x/length;
            vec.y=vec.y/length;
            vec.z=vec.z/length;
        }
        
        return vec;
    }

}