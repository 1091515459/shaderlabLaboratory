Shader "Custom/shaderLearn1"
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
					        float2 s = float2(z.uv.x+_SinTime.y/2,z.uv.y+_SinTime.y/2);
					        float2 d =tex2D(_DisplacementTex,s).xy;
					        d = ((d*2)-1)*_Magnitude;
					        float4 color = tex2D(_MainTex,z.uv+d);
					        return color;
				    }
				    ENDCG
			}			
		}
			FallBack "Diffuse"
}
