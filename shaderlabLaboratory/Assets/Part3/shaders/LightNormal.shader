Shader "Custom/LightNormal"
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
            };

            struct v2f{
                float4 vertex:SV_POSITION;
                float3 normal:TEXCOORD1;
            };

            v2f vert(a2v v){
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                // o.normal=normalize(mul(v.normal,(float3x3)unity_WorldToObject));
                o.normal = UnityObjectToWorldNormal(v.normal);
                return o;
            }

            float4 frag(v2f v):SV_TARGET{
                return saturate(dot(v.normal,_WorldSpaceLightPos0));
            };

            ENDCG
        }
    }
    FallBack "Diffuse"
}
