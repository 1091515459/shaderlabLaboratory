Shader "Custom/DoubleTransparentRipple"
{
    Properties
    {
        _MainTex("MainTex",2D)="white"{}
        _SecondTex("SecondTex",2D)="white"{}
        _Ripple("Ripple",2D)="white"{}
        _RippleSize("RippleSize",Range(0,1))=0
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
            Cull Back
            ZWrite Off
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "unityCG.cginc"
            
            sampler2D _SecondTex;
            sampler2D _Ripple;
            float _RippleSize;

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
                float2 dispuv = float2(v.uv.x+_Time.x*2,v.uv.y+_Time.x*2);
                float2 disp = tex2D(_Ripple,dispuv).xy;
                disp = ((disp*2)-1)*_RippleSize;
                float4 col = tex2D(_SecondTex,v.uv+disp);
                return col;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
