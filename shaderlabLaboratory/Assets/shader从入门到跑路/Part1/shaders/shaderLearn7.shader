Shader "Custom/shaderLearn7"
{
	Properties
	{
		_MainTex("tex",2D) = "white"{}
		_DisplacementTex("Displacement Texture",2D) = "White"{}
		_Color("Color",Color) = (1.0,1.0,1.0,1.0)
		_Magnitude("Magnitude",Range(0,1)) = 0
	}
	SubShader
	{
		Tags{
			"Queue" = "Transparent"
		}
		LOD 200//要是只有一个subshader写多少都行

		pass {
			Blend SrcAlpha OneMinusSrcAlpha//传统的透明度
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			sampler2D _MainTex;
			sampler2D _DisplacementTex;
			float4 _Color;
			float _Magnitude;
			#include "UnityCG.cginc"


			struct a2v {
				float4 vertex :POSITION;
				float4 uv:TEXCOORD0;
			};

			struct v2f {
				float4 vertex:SV_POSITION;
				float4 uv:TEXCOORD8;
			};

			v2f vert(a2v v) {
				v2f z;
				z.vertex = UnityObjectToClipPos(v.vertex);
				z.uv = v.uv;
				return z;
			}
			float4 frag(v2f z) :SV_TARGET{
				fixed4 col;
				col = tex2D(_MainTex, z.uv);
				float grey = dot(col.rgb, float3(0.2125, 0.7154, 0.0721));
				col.rgb = float3(grey*_Color.r, grey*_Color.g, grey*_Color.b);
				col.a=_Magnitude;
				return col;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
