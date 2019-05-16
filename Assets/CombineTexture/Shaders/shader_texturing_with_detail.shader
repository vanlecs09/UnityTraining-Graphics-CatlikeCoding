Shader "Custom/Textured With Detail" {

	Properties {
		_Tint ("Tint", Color) = (1, 1, 1, 1)
		_MainTex ("Texture", 2D) = "white" {}
		_DetailTex ("Detail Texture", 2D) = "gray" {}
		_MainTex_ST("ST", Vector) = (1,2,3,4)
		_DetailTex_ST("ST", Vector) = (1,2,3,4)
	}

	SubShader {
		Pass {
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma vertex MyVertexProgram
		#pragma fragment MyFragmentProgram

		float4 _MainTex_ST, _DetailTex_ST;
		float4 _Tint;
		struct Interpolators {
			float4 position : SV_POSITION;
			float2 uv : TEXCOORD0;
			float2 uvDetail : TEXCOORD1;
		};

		struct VertexData {
			float4 position : POSITION;
			float2 uv : TEXCOORD0;
			
		};
		sampler2D _MainTex;
		sampler2D _DetailTex;

		Interpolators MyVertexProgram (VertexData v) {
			Interpolators i;
			// i.uv = v.uv;
			i.uv = TRANSFORM_TEX(v.uv, _MainTex);
			i.uvDetail = TRANSFORM_TEX(v.uv, _DetailTex);
			i.position = UnityObjectToClipPos(v.position);
			return i;
		}

		float4 MyFragmentProgram (Interpolators i) : SV_TARGET {
			float4 color = tex2D(_MainTex, i.uv) * _Tint;
			// color = tex2D(_MainTex, i.uv * 10);
			// color *= tex2D(_MainTex, i.uv);
			color *= tex2D(_DetailTex, i.uvDetail) * 2;
			// color *= tex2D(_MainTex, i.uv * 10);
			return color;
		}
		ENDCG
	}
	}
}