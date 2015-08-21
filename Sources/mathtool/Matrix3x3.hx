package mathtool;

class Matrice3x3
{
    public var m00:Float;
    public var m01:Float;
    public var m02:Float;
    
    public var m10:Float;
    public var m11:Float;
    public var m12:Float;
    
    public var m20:Float;
    public var m21:Float;
    public var m22:Float;
    
    public function new(
        m00:Float, m10:Float, m20:Float,
        m01:Float, m11:Float, m21:Float,
        m02:Float, m12:Float, m22:Float)
    {
        this.m00 = m00;
        this.m10 = m10;
        this.m20 = m20;
        
        this.m01 = m01;
        this.m11 = m11;
        this.m21 = m21;
        
        this.m02 = m02;
        this.m12 = m12;
        this.m22 = m22;
    }
    
    
}

@:forward(
    m00, m01, m02,
    m10, m11, m12,
    m20, m21, m22)
abstract Matrix3x3(Matrice3x3) from Matrice3x3 to Matrice3x3{

    public static inline var numElem:Int = 9;

    public static var matZero(get, never):Matrix3x3;
    public static var matId(get, never):Matrix3x3;
    public var det(get, never):Float;
    public var trans(get, never):Matrix3x3;

    public inline function new(
        m00:Float, m10:Float, m20:Float,
        m01:Float, m11:Float, m21:Float,
        m02:Float, m12:Float, m22:Float)
    {
        this = new Matrice3x3(
            m00, m10, m20,
            m01, m11, m21,
            m02, m12, m22);
    }

	public static inline function fromArray(rawData:Array<Float>):Matrix3x3
    {
        if (rawData.length != Matrix3x3.numElem)
        {
            throw "Invalid rawData.";
        }
        
        return new Matrix3x3(
            rawData[0], rawData[1], rawData[2],
            rawData[3], rawData[4], rawData[5],
            rawData[6], rawData[7], rawData[8]);
    }

    @:op(A * B)
    public static inline function productScalar(s:Float, a:Matrix3x3):Matrix3x3{
        return new Matrix3x3(
            s * a.m00, s * a.m10, s * a.m20,
            s * a.m01, s * a.m11, s * a.m21,
            s * a.m02, s * a.m12, s * a.m22);
    }

    @:op(A * B)
    public static inline function productVector(a:Matrix3x3, v:Vector3):Vector3
    {
        return new Vector3(
            a.m00 * v.x + a.m10 * v.y + a.m20 * v.z,
            a.m01 * v.x + a.m11 * v.y + a.m21 * v.z,
            a.m02 * v.x + a.m12 * v.y + a.m22 * v.z);
    }

    @:op(A * B)
    public static inline function productmatrix(a:Matrix3x3, b:Matrix3x3):Matrix3x3
    {
        return new Matrix3x3(
            a.m00 * b.m00 + a.m10 * b.m01 + a.m20 * b.m02,
            a.m00 * b.m10 + a.m10 * b.m11 + a.m20 * b.m12,
            a.m00 * b.m20 + a.m10 * b.m21 + a.m20 * b.m22,
            
            a.m01 * b.m00 + a.m11 * b.m01 + a.m21 * b.m02,
            a.m01 * b.m10 + a.m11 * b.m11 + a.m21 * b.m12,
            a.m01 * b.m20 + a.m11 * b.m21 + a.m21 * b.m22,
            
            a.m02 * b.m00 + a.m12 * b.m01 + a.m22 * b.m02,
            a.m02 * b.m10 + a.m12 * b.m11 + a.m22 * b.m12,
            a.m02 * b.m20 + a.m12 * b.m21 + a.m22 * b.m22);
    }

     @:op(A + B)
    public static inline function add(a:Matrix3x3, b:Matrix3x3):Matrix3x3
    {
        return new Matrix3x3(
            a.m00 + b.m00 ,  
            a.m10 + b.m10 , 
            a.m20 + b.m20 ,
            a.m01 + b.m01 ,  
            a.m11 + b.m11 , 
            a.m21 + b.m21 , 
            a.m02 + b.m02, 
            a.m12 + b.m12,
            a.m22 + b.m22);
    }

    @:op(A - B)
    public static inline function subtract(a:Matrix3x3, b:Matrix3x3):Matrix3x3
    {
        return new Matrix3x3(
            a.m00 - b.m00 ,  
            a.m10 - b.m10 , 
            a.m20 - b.m20 ,
            a.m01 - b.m01 ,  
            a.m11 - b.m11 , 
            a.m21 - b.m21 , 
            a.m02 - b.m02, 
            a.m12 - b.m12,
            a.m22 - b.m22);
    }

    @:op(-A)
    public static inline function negate(a:Matrix3x3):Matrix3x3
    {
        return new Matrix3x3(
            -a.m00, -a.m10, -a.m20,
            -a.m01, -a.m11, -a.m21,
            -a.m02, -a.m12, -a.m22);
    }

    @:op(A == B)
    public static inline function equals(a:Matrix3x3, b:Matrix3x3):Bool
    {
        return a != null &&
            b != null &&
            a.m00 == b.m00 &&
            a.m10 == b.m10 &&
            a.m20 == b.m20 &&
            a.m01 == b.m01 &&
            a.m11 == b.m11 &&
            a.m21 == b.m21 &&
            a.m02 == b.m02 &&
            a.m12 == b.m12 &&
            a.m22 == b.m22;        
    }

    public static inline function rotationXMatrix(angle:Float):Matrix3x3
    {
        var s = Math.sin(angle);
        var c = Math.cos(angle);
        return new Matrix3x3(
            1, 0,  0,
            0, c, -s,
            0, s,  c);
    }
    public static inline function rotationYMatrix(angle:Float):Matrix3x3
    {
        var s = Math.sin(angle);
        var c = Math.cos(angle);
        return new Matrix3x3(
             c,  0, s,
             0,  1, 0,
            -s,  0, c);
    }
    public static inline function rotationZMatrix(angle:Float):Matrix3x3
    {
        var s = Math.sin(angle);
        var c = Math.cos(angle);
        return new Matrix3x3(
            c, -s, 0,
            s,  c, 0,
            0,  0, 1);
    }

    public static inline function scaleMatrix(sx:Float, sy:Float, sz:Float):Matrix3x3
    {
        return new Matrix3x3(
            sx, 0.0, 0.0,
            0.0, sy, 0.0,
            0.0, 0.0, sz);
    }

    @:arrayAccess
    public inline function getArrayElement(i:Int):Float
    {
        var self:Matrix3x3 = this;
        
        switch (i)
        {
            case 0:
                return self.m00;
            case 1:
                return self.m10;
            case 2:
                return self.m20;
            case 3:
                return self.m01;
            case 4:
                return self.m11;
            case 5:
                return self.m21;
            case 6:
                return self.m02;
            case 7:
                return self.m12;
            case 8:
                return self.m22;
            default:
                throw "Invalid element";
        }
    }

    @:arrayAccess
    public inline function setArrayElement(i:Int, value:Float):Float
    {
        var self:Matrix3x3 = this;
        
        switch (i)
        {
            case 0:
                return self.m00 = value;
            case 1:
                return self.m10 = value;
            case 2:
                return self.m20 = value;
            case 3:
                return self.m01 = value;
            case 4:
                return self.m11 = value;
            case 5:
                return self.m21 = value;
            case 6:
                return self.m02 = value;
            case 7:
                return self.m12 = value;
            case 8:
                return self.m22 = value;
            default:
                throw "Invalid element";
        }
    }

    public inline function getElement(column:Int, row:Int):Float
    {
        var self:Matrix3x3 = this;
        return self[row * 3 + column];
    }

    public inline function setElement(column:Int, row:Int, value:Float):Float
    {
        var self:Matrix3x3 = this;
        return self[row * 3 + column] = value;
    }

    public inline function col(index:Int):Vector3
    {
        var self:Matrix3x3 = this;
        
        switch (index)
        {
            case 0:
                return new Vector3(self.m00, self.m01, self.m02);
            case 1:
                return new Vector3(self.m10, self.m11, self.m12);
            case 2:
                return new Vector3(self.m20, self.m21, self.m22);
            default:
                throw "Invalid column";
        }
    }

    public inline function row(index:Int):Vector3
    {
        var self:Matrix3x3 = this;
        
        switch (index)
        {
            case 0:
                return new Vector3(self.m00, self.m10, self.m20);
            case 1:
                return new Vector3(self.m01, self.m11, self.m21);
            case 2:
                return new Vector3(self.m02, self.m12, self.m22);
            default:
                throw "Invalid row";
        }
    }
  

    public inline function applyScalarFunc(func:Float->Float):Matrix3x3
    {
        var self:Matrix3x3 = this;
        
        for (i in 0...numElem)
        {
            self[i] = func(self[i]);
        }
        
        return self;
    }
    
    private static inline function get_matZero():Matrix3x3
    {
        return new Matrix3x3(
            0.0, 0.0, 0.0,
            0.0, 0.0, 0.0,
            0.0, 0.0, 0.0);
    }
    
    private static inline function get_matId():Matrix3x3
    {
        return new Matrix3x3(
            1.0, 0.0, 0.0,
            0.0, 1.0, 0.0,
            0.0, 0.0, 1.0);
    }
    
    private inline function get_det():Float
    {
        var self:Matrix3x3 = this;
        return Util.detM3x3(
            self.m00, self.m10, self.m20,
            self.m01, self.m11, self.m21,
            self.m02, self.m12, self.m22);
    }
    
    private inline function get_trans():Matrix3x3
    {
        var self:Matrix3x3 = this;
        return new Matrix3x3(
            self.m00, self.m01, self.m02,
            self.m10, self.m11, self.m12,
            self.m20, self.m21, self.m22);
    }

}