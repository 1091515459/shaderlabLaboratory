Shader "Custom/EdgeDetection"
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
            //这两行打开效果也不是很好
            // ZTest Always
            // Blend one one
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
                float3 viewDir:TEXCOORD2;
            };

            v2f vert(a2v v){
                v2f o;
                o.vertex=UnityObjectToClipPos(v.vertex);
                // o.normal=normalize(mul(v.normal,(float3x3)unity_WorldToObject));
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.viewDir = normalize(_WorldSpaceCameraPos.xyz - mul(unity_ObjectToWorld,v.vertex).xyz);
                return o;
            }

            float4 frag(v2f v):SV_TARGET{
                float ndotv = 1 - dot(v.normal,v.viewDir)*2;
                return float4(ndotv,ndotv,ndotv,0);
            };

            ENDCG
        }
    }
    FallBack "Diffuse"
}
