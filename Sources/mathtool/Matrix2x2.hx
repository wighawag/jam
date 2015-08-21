package mathtool;

class Matrice2x2
{
    public var m00:Float;
    public var m01:Float;
    
    public var m10:Float;
    public var m11:Float;

    
    public function new(
        m00:Float, m10:Float,
        m01:Float, m11:Float)
    {
        this.m00 = m00;
        this.m10 = m10;
        
        this.m01 = m01;
        this.m11 = m11;
    }
    
    
}

@:forward(
    m00, m01,
    m10, m11)
abstract Matrix2x2(Matrice2x2) from Matrice2x2 to Matrice2x2{

    public static inline var numElem:Int = 4;
    public static var matZero(get, never):Matrix2x2;
    public static var matId(get, never):Matrix2x2;
    public var det(get, never):Float;
    public var trans(get, never):Matrix2x2;
    
    public inline function new(
        m00:Float, m10:Float,
        m01:Float, m11:Float)
    {
        this = new Matrice2x2(
            m00, m10,
            m01, m11);
    }

    public static inline function fromArray(rawData:Array<Float>):Matrix2x2
    {
        if (rawData.length != Matrix2x2.numElem)
        {
            throw "Invalid rawData.";
        }
        
        return new Matrix2x2(rawData[0], rawData[1], rawData[2], rawData[3]);
    }

	@:op(A * B)
    public static inline function productScalar(s:Float, a:Matrix2x2):Matrix2x2{
        return
            new Matrix2x2(
            s * a.m00, s * a.m10,
            s * a.m01, s * a.m11);
    }

    @:op(A * B)
    public static inline function productVector(a:Matrix2x2, v:Vector2):Vector2
    {   
        return new Vector2(
            a.m00 * v.x + a.m10 * v.y,
           a.m01* v.x + a.m11 * v.y);
    }

    @:op(A * B)
    public static inline function productmatrix(a:Matrix2x2, b:Matrix2x2):Matrix2x2
    {
        return new Matrix2x2(
            a.m00 * b.m00 + a.m10 * b.m01,  
            a.m00 * b.m10 + a.m10 * b.m11, 
            a.m01 * b.m00 + a.m11 * b.m01, 
            a.m01 * b.m10 + a.m11 * b.m11);
    }

     @:op(A + B)
    public static inline function add(a:Matrix2x2, b:Matrix2x2):Matrix2x2
    {
        return new Matrix2x2(
            a.m00 + b.m00 ,  
            a.m10 + b.m10 , 
            a.m01 + b.m01 , 
            a.m11 + b.m11);
    }

    @:op(A - B)
    public static inline function subtract(a:Matrix2x2, b:Matrix2x2):Matrix2x2
    {
        return new Matrix2x2(
            a.m00 - b.m00 ,  
            a.m10 - b.m10 , 
            a.m01 - b.m01 , 
            a.m11 - b.m11);
    }

    @:op(-A)
    public static inline function negate(a:Matrix2x2):Matrix2x2
    {
        return new Matrix2x2(
            -a.m00, -a.m10,
            -a.m01, -a.m11);
    }

    @:op(A == B)
    public static inline function equals(a:Matrix2x2, b:Matrix2x2):Bool
    {
        return (a != null &&
            b != null &&
            a.m00 == b.m00 &&  
            a.m10 == b.m10 && 
            a.m01 == b.m01 && 
            a.m11 == b.m11);          
    }

    public static inline function rotationMatrix(angle:Float):Matrix2x2
    {
        var s = Math.sin(angle);
        var c = Math.cos(angle);
        return new Matrix2x2(
            c, -s,
            s, c
            );
    }

    public static inline function scaleMatrix(sx:Float, sy:Float):Matrix2x2
    {
        return new Matrix2x2(
            sx, 0.0,
            0.0, sy);
    }

    @:arrayAccess
    public inline function getArrayElement(i:Int):Float
    {
        var self:Matrix2x2 = this;
        
        switch (i)
        {
            case 0:
                return self.m00;
            case 1:
                return self.m10;
            case 2:
                return self.m01;
            case 3:
                return self.m11;
            default:
                throw "Invalid element";
        }
    }

    @:arrayAccess
    public inline function setArrayElement(i:Int, value:Float):Float
    {
        var self:Matrix2x2 = this;
        
        switch (i)
        {
            case 0:
                return self.m00 = value;
            case 1:
                return self.m10 = value;
            case 2:
                return self.m01 = value;
            case 3:
                return self.m11 = value;
            default:
                throw "Invalid element";
        }
    }

    public inline function getElement(column:Int, row:Int):Float
    {
        var self:Matrix2x2 = this;
        return self[row * 2 + column];
    }

    public inline function setElement(column:Int, row:Int, value:Float):Float
    {
        var self:Matrix2x2 = this;
        return self[row * 2 + column] = value;
    }

    public inline function col(index:Int):Vector2
    {
        var self:Matrix2x2 = this;
        
        switch (index)
        {
            case 0:
                return new Vector2(self.m00, self.m01);
            case 1:
                return new Vector2(self.m10, self.m11);
            default:
                throw "Invalid column";
        }
    }

    public inline function row(index:Int):Vector2
    {
        var self:Matrix2x2 = this;
        
        switch (index)
        {
            case 0:
                return new Vector2(self.m00, self.m10);
            case 1:
                return new Vector2(self.m01, self.m11);
            default:
                throw "Invalid row";
        }
    }


/**
     * Multiply the tranpose of the matrix with a vector. Useful for fast inverse rotations.
     * 
     * @param v     The vector to multiply with.
     * @return      this^T * v.    
     */
    public inline function transposeMultiplyVector(v:Vector2):Vector2
    {
        var self:Matrix2x2 = this;
        
        return new Vector2(
            self.m00 * v.x + self.m01 * v.y,
            self.m10 * v.x + self.m11 * v.y);
    }
    

    public inline function applyScalarFunc(func:Float->Float):Matrix2x2
    {
        var self:Matrix2x2 = this;
        
        for (i in 0...numElem)
        {
            self[i] = func(self[i]);
        }
        
        return self;
    }
    
    private static inline function get_matZero():Matrix2x2
    {
        return new Matrix2x2(
            0.0, 0.0,
            0.0, 0.0);
    }
    
    private static inline function get_matId():Matrix2x2
    {
        return new Matrix2x2(
            1.0, 0.0,
            0.0, 1.0);
    }
    
    private inline function get_det():Float
    {
        var self:Matrix2x2 = this;
        return Util.detM2x2(
            self.m00, self.m10,
            self.m01, self.m11);
    }
    
    private inline function get_trans():Matrix2x2
    {
        var self:Matrix2x2 = this;
        return new Matrix2x2(
            self.m00,self.m01,
            self.m10,self.m11);
    }

}