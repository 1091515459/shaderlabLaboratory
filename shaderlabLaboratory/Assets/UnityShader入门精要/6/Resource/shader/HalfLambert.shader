// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Unity Shaders Book/Chapter 6/HalfLambert"{
	Properties {
		_Diffuse("Diffuse",Color)=(1,1,1,1)
	}
	SubShader {
		pass {
			Tags{"LightMode"="ForwardBase"}
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "LIghting.cginc"

			fixed4 _Diffuse;

			struct a2v{
				float4 vertex:POSITION;
				float3 normal:NORMAL;
			};

			struct v2f{
				float4 pos:SV_POSITION;
				fixed3 worldNormal:TEXCOORD0;
			};

			v2f vert(a2v v){
				v2f o;
				//将顶点从对象空间变换到投影空间
				o.pos = UnityObjectToClipPos(v.vertex);
				//将对象空间转换为世界空间
				o.worldNormal = normalize(mul(v.normal,(float3x3)unity_WorldToObject));

				return o;
			}

			fixed4 frag(v2f v):SV_TARGET{	
				//获取环境项
				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
				//获得世界空间的正常值
				fixed3 worldNormal = normalize(v.worldNormal);
				//获取世界空间中的灯光方向
				fixed3 worldLightDir = normalize(_WorldSpaceLightPos0.xyz);
				fixed halfLambert = dot(worldNormal,worldLightDir)*0.5+0.5;
				//计算扩散项
				fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * halfLambert;
				fixed3 color = ambient + diffuse;

				return fixed4(color,1.0);
			}
			ENDCG
		}
	}
}