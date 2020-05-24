// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Unity Shaders Book/Chapter 6/Diffuse Vertex-Level"{
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
				fixed3 color:COLOR;
			};

			v2f vert(a2v v){
				v2f o;
				//将顶点从对象空间变换到投影空间
				o.pos = UnityObjectToClipPos(v.vertex);
				//获取环境项
				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
				//将对象空间转换为世界空间
				fixed3 worldNormal = normalize(mul(v.normal,(float3x3)unity_WorldToObject));
				//获取世界空间中的灯光方向
				fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
				//计算扩散项
				fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal,worldLight));

				o.color = ambient + diffuse;
				return o;
			}

			fixed4 frag(v2f v):SV_TARGET{
				return fixed4(v.color,1.0);
			}
			ENDCG
		}
	}
}