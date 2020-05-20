// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'


Shader "Custom/OverDrawShader"
{
    SubShader
    {
        ZTest Always
        ZWrite Off
        Blend One One
        Tags { "Queue"="Transparent" }
        pass{
            CGPROGRAM
            // Physically based Standard lighting model, and enable shadows on all light types
            #pragma vertex vert
            #pragma fragment frag
            // Use shader model 3.0 target, to get nicer looking lighting

            #include "UnityCG.cginc"

            struct a2v
            {
                float4 vertex:POSITION;
            };

            struct v2f
            {
                float4 vertex:SV_POSITION;
            };

            v2f vert(a2v v){
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            half4 _OverDrawColor;

            float4 frag(v2f v):SV_TARGET{

                return _OverDrawColor;
            }
            ENDCG
        }
    }
}
