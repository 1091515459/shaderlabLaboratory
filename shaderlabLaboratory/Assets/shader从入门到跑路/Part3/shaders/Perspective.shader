Shader "Custom/Perspective"
{
    Properties
    {
        _Main("Main",2D) = "white"{}
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        pass{
            Stencil{
                Ref 4
                Comp Always
                Pass Replace
                ZFail Keep
            }
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _Main;

            struct a2v{
                float4 vertex:POSITION;
                float3 uv:TEXCOORD0;
            };

            struct v2f{
                float4 vertex:SV_POSITION;
                float3 uv:TEXCOORD1;
            };

            v2f vert(a2v v){
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                o.uv=v.uv;
                return o;
            }

            float4 frag(v2f v):SV_TARGET{
                float4 color1=tex2D(_Main,v.uv);
                return color1;
            };

            ENDCG
        }
        pass{
            Tags { "Queue" = "Transparent" }
            Stencil{
                Ref 3
                Comp Greater
                Fail keep
                Pass Replace
            }
            ZTest Always
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float4 _Color;

            struct a2v{
                float4 vertex:POSITION;
                float3 uv:TEXCOORD0;
            };

            struct v2f{
                float4 vertex:SV_POSITION;
                float3 uv:TEXCOORD1;
            };

            v2f vert(a2v v){
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                o.uv=v.uv;
                return o;
            }

            float4 frag(v2f v):SV_TARGET{
                float4 color=float4(v.uv.rgb,1);
                return color;
            };

            ENDCG
        }
    }
    FallBack "Diffuse"
}
