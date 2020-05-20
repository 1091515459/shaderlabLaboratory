Shader "Custom/DoubleTransparent"
{
    Properties
    {
        _MainTex("MainTex",2D)="white"{}
        _SecondTex("SecondTex",2D)="white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        pass{
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Back
            ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "unityCG.cginc"
            
            sampler2D _MainTex;

            struct a2v
            {
                float4 vertex:POSITION;
                float2 uv:TEXCOORD0;
            };

            struct v2f
            {
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
                float4 color=tex2D(_MainTex,v.uv);
                return color;
            }
            ENDCG
        }
        pass{
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Front
            ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "unityCG.cginc"
            
            sampler2D _SecondTex;

            struct a2v
            {
                float4 vertex:POSITION;
                float2 uv:TEXCOORD0;
            };

            struct v2f
            {
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
                float4 color=tex2D(_SecondTex,v.uv);
                return color;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
