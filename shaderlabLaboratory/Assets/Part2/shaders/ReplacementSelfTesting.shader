// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'


Shader "Custom/ReplacementSelfTesting"
{
    Properties
    {
        _MainTex1("MainTex1",2D)="white"{}
        _SecondTex("SecondTex",2D)="white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        pass{
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            sampler2D _MainTex1;

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

            v2f vert(a2v v){
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag(v2f v):SV_TARGET{
                float4 color=tex2D(_MainTex1,v.uv);
                return color;
            }
            ENDCG
        }
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        pass{
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
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

            v2f vert(a2v v){
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag(v2f v):SV_TARGET{
                float4 color=tex2D(_SecondTex,v.uv);
                return color;
            }
            ENDCG
        }
    }
}
