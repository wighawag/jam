package mathtool;

class Util
{
	////////////DETERMINANT//////////////////
	public static inline function detM2x2(
        m00:Float, m10:Float,
        m01:Float, m11:Float):Float
    {
        return m00 * m11 - m10 * m01;
    }

    public static inline function detM3x3(
        m00:Float, m10:Float, m20:Float,
        m01:Float, m11:Float, m21:Float,
        m02:Float, m12:Float, m22:Float):Float
    {
        return
            m00 * detM2x2(
                m11, m21,
                m12, m22) -
            m10 * detM2x2(
                m01, m21,
                m02, m22) +
            m20 * detM2x2(
                m01, m11,
                m02, m12);
    }

    public static inline function detM4x4(
        m00:Float, m10:Float, m20:Float, m30:Float,
        m01:Float, m11:Float, m21:Float, m31:Float,
        m02:Float, m12:Float, m22:Float, m32:Float,
        m03:Float, m13:Float, m23:Float, m33:Float):Float
    {
        return
            m00 * detM3x3(
                m11, m21, m31,
                m12, m22, m32,
                m13, m23, m33) -
            m10 * detM3x3(
                m01, m21, m31,
                m02, m22, m32,
                m03, m23, m33) +
            m20 * detM3x3(
                m01, m11, m31,
                m02, m12, m32,
                m03, m13, m33) -
            m30 * detM3x3(
                m01, m11, m21,
                m02, m12, m22,
                m03, m13, m23);
    }
}    