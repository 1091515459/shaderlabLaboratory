
Shader "Custom/DepthShader"
{
    Properties{
        _Color("Color",Color)=(1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
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
                float depth:DEPTH;
            };

            v2f vert(a2v v){
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.depth = -mul(UNITY_MATRIX_MV, v.vertex).z * _ProjectionParams.w;
                return o;
            }

            half4 _Color;
            float4 frag(v2f v):SV_TARGET{
                float i=1-v.depth;
                float4 color=float4(i,i,i,1);
                return color*_Color;
            }
            ENDCG
        }
    }
    SubShader
    {
        Blend SrcAlpha OneMinusSrcAlpha//一般混合模式
        Tags { "RenderType"="Transparent" }
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
                float depth:DEPTH;
            };

            v2f vert(a2v v){
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.depth = -mul(UNITY_MATRIX_MV, v.vertex).z * _ProjectionParams.w;
                return o;
            }

            half4 _Color;
            float4 frag(v2f v):SV_TARGET{
                float i=1-v.depth;
                float4 color=float4(i,i,i,1);
                return color*_Color;
            }
            ENDCG
        }
    }
}
