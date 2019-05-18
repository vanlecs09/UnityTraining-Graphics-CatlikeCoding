// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/SimpleColor" {

    Properties {
        _Tint ("Tint", Color) = (1, 1, 1, 1)
	}


	SubShader {

		Pass {
            CGPROGRAM
			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram

            float4 _Tint;

			float4 MyVertexProgram (float4 position : POSITION) : SV_POSITION {
                return UnityObjectToClipPos(position);
			}

			float4 MyFragmentProgram (float4 position : SV_POSITION) : SV_TARGET {
                return _Tint;
			}
            ENDCG
		}
	}
}