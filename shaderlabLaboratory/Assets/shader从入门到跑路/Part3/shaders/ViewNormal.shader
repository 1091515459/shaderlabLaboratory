Shader "Custom/ViewNormal"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct a2v{
                float4 vertex:POSITION;
                float3 normal:NORMAL;
                float2 uv:TEXCOORD0;
            };

            struct v2f{
                float4 vertex:SV_POSITION;
                float3 normal:NORMAL;
                float2 uv:TEXCOORD1;
            };

            v2f vert(a2v v){
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                o.normal=normalize(v.normal);
                o.uv=v.uv;
                return o;
            }

            float4 frag(v2f v):SV_TARGET{
                float3 color=(v.normal+1)*0.5;
                return float4(color.rgb,1);
            };

            ENDCG
        }
    }
    FallBack "Diffuse"
}
