Shader "Custom/AntiColor"
{
    Properties
    {
        _MainTex ("MainTex (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        pass{

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;

            struct a2v{
                float4 vertex:POSITION;
                float2 uv:TEXCOORD0;   
            };

            struct v2f{
                float4 vertex:SV_POSITION;
                float2 uv:TEXCOORD1;   
            };

            v2f vert(a2v a){
                v2f o;
                o.vertex=UnityObjectToClipPos(a.vertex);
                o.uv=a.uv;
                return o;
            }

            float4 frag(v2f v):SV_TARGET{
                float4 Color=tex2D(_MainTex,v.uv);
                Color=float4(1,1,0,0)-float4(Color.r,Color.g,-0.5,-1);
                return Color;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
