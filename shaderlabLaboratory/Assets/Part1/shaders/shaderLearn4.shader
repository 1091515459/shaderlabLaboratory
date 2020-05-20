Shader "Custom/shaderLearn4"
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
			pass{
				    Blend SrcAlpha OneMinusSrcAlpha//传统的透明度
				    CGPROGRAM
				    #pragma vertex vert
				    #pragma fragment frag
				    sampler2D _MainTex;
				    sampler2D _DisplacementTex;
				    float _Magnitude;
				    #include "UnityCG.cginc"


				    struct zhangxu{
					        float4 vertex :POSITION;
					        float4 uv:TEXCOORD0;
				    };

				    struct v2f{
					        float4 vertex:SV_POSITION;
					        float4 uv:TEXCOORD8;
				    };

				    v2f vert(zhangxu v){
					        v2f z;
					        z.vertex = UnityObjectToClipPos(v.vertex);
					        z.uv=v.uv;
					        return z;
				    }
				    float4 frag (v2f z):SV_TARGET{

					        float4 color = tex2D(_MainTex, z.uv);
					        float4 color1 = tex2D(_DisplacementTex, z.uv);
					        color*=_Magnitude;
					        color1*=1-_Magnitude;
					        float4 color2=color+color1;
					        return color2;
				    }
				    ENDCG
			}
		}
			FallBack "Diffuse"
}
