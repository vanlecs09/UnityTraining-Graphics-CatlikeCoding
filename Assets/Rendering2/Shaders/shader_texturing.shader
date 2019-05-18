// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/SimpleTexture" {

    Properties {
        _Tint ("Tint", Color) = (1, 1, 1, 1)
		_MainTex ("Texture", 2D) = "white" {}		
		_MainTex_ST("ST", Vector) = (1,2,3,4)
	}


	SubShader {

		Pass {
            CGPROGRAM
			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram

			float4 _MainTex_ST;
            float4 _Tint;
			struct Interpolators {
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			struct VertexData {
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};
			sampler2D _MainTex;

			Interpolators MyVertexProgram (VertexData v) {
				Interpolators i;
				// i.uv = v.uv;
				i.uv = v.uv * _MainTex_ST.xy + _MainTex_ST.zw;;
               	i.position = UnityObjectToClipPos(v.position);
				return i;
			}

			float4 MyFragmentProgram (Interpolators i) : SV_TARGET {
                return tex2D(_MainTex, i.uv ) * _Tint;;
			}
            ENDCG
		}
	}
}