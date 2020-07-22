﻿Shader "ShaderStudy/Part12/12-03-02-Hologram"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" }	

        CGPROGRAM
        #pragma surface surf Lambert noambient alpha:fade			

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
            float3 worldPos;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Emission =float3(0,1,0);
			float rim = saturate(dot(o.Normal, IN.viewDir));
			rim = pow(1 - rim, 3) + pow(frac(IN.worldPos.g * 3 - _Time.y), 30);
            o.Alpha = rim; //불투명하게 만들기 //세로줄 넓ㅅ이나 개수 조정하도록
        }
        ENDCG
    }
    FallBack "Diffuse"
}
