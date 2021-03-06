﻿// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Unity Shaders Book/Chapter 8/Alpha Blend ZWrite8"
{
    Properties{
        _Color("Main Tint",Color) = (1,1,1,1)
        _MainTex("Main Tex",2D) = "white"{}
        _AlphaScale("Alpha Scale",Range(0,1)) = 1
    }
    SubShader{
        Tags{
            "Queue"="AlphaTest"
            "IgnoreProjector"="True"
            "RenderType"="TransparentCutout"
        }
        pass{
            ZWrite on
            ColorMask 0
        }
        pass{
            Tags{"LightModel"="ForwardBase"}
            ZWrite Off

            // //Blend SrcFactor DstFactor, SrcFactorA DstFactorA
            // Blend SrcAlpha OneMinusSrcAlpha, Zero One//输出的透明度是目标颜色的透明度

            // //正常（normal）即透明度混合
            // Blend SrcAlpha OneMinusSrcAlpha

            // //柔和相加（soft additive）
            // Blend OneMinusDstColor One

            // //正片叠底（multiply），即相乘
            // Blend DstColor Zero

            // //两倍相乘（2x multiply）
            // Blend DstColor SrcColor

            // //变暗（darken）
            // BlendOp min
            // Blend One One 

            // //变亮（lighten）
            // BlendOp Max
            // Blend One One

            // //滤色（screen）
            // Blend OneMinusDstColor One 
            // //等同于
            // Blend One OneMinusSrcColor 

            //线性减淡（linear dodge）
            Blend One One 

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Lighting.cginc"
            fixed4 _Color;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed _AlphaScale;

            struct a2v{
                float4 vertex :POSITION;
                float3 normal:NORMAL;
                float4 texcoord:TEXCOORD;
            };
            struct v2f{
                float4 pos:SV_POSITION;
                float3 worldNormal:TEXCOORD0;
                float3 worldPos:TEXCOORD1;
                float2 uv:TEXCOORD2;
            };

            v2f vert(a2v v){
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldNormal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld,v.vertex).xyz;
                o.uv = TRANSFORM_TEX(v.texcoord,_MainTex);
                return o;
            }

            fixed4 frag(v2f i):SV_TARGET{
                fixed3 worldNormal = normalize(i.worldNormal);
                fixed3 worldLightDir = normalize(UnityWorldSpaceLightDir(i.worldPos));
                fixed4 texColor = tex2D(_MainTex,i.uv);

                fixed3 albedo = texColor.rgb * _Color.rgb;
                fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz * albedo;
                fixed3 diffuse = _LightColor0.rgb * albedo * max(0,dot(worldNormal,worldLightDir));

                return fixed4(ambient + diffuse,texColor.a * _AlphaScale);
            }

            ENDCG
        }
    }
}
