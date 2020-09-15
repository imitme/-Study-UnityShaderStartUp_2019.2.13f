﻿Shader "ShaderStudy/Part14/14-06-fresnelToon"
{
    Properties
    {
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _BumpMap("NirmalMap", 2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }

        cull back
		CGPROGRAM
		#pragma surface surf Toon 

		sampler2D _MainTex;
		sampler2D _BumpMap;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}

        float4 LightingToon(SurfaceOutput s, float3 lightDir, float atten)
        {
            float ndotl = dot(s.Normal, lightDir) * 0.5 + 0.5;
            if (ndotl > 0.7)
            {
                ndotl = 1;
            }
            else
            {
                ndotl = 0.3;
            }

            float4 final;
            final.rgb = s.Albedo * ndotl *_LightColor0.rgb;
            final.a = s.Alpha;

            return final;
        }
        ENDCG
    }
	FallBack "Diffuse"
}
