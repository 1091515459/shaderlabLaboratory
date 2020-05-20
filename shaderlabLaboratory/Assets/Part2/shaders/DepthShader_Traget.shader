
Shader "Custom/DepthShader_Traget"
{
    Properties{
        _Color("Color",Color)=(1,1,1,1)
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
                float2 uv:TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex:SV_POSITION;
                float2 uv:TEXCOORD0;
            };

            v2f vert(a2v v){
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv=v.uv;
                return o;
            }

            half4 _Color;
            float4 frag(v2f v):SV_TARGET{

                return _Color*float4(v.uv.r,v.uv.g,0.5,1);
            }
            ENDCG
        }
    }
}
