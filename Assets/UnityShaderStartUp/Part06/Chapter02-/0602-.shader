﻿Shader "ShaderStudy/Part6/0602-"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
		LOD 200

        CGPROGRAM
        #pragma surface surf Standard 

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            //fixed4 c = tex2D (_MainTex, IN.uv_MainTex + _Time.y); //좌하단으로 흐름(-)
            //fixed4 c = tex2D (_MainTex, IN.uv_MainTex - _Time.y); //좌하단으로 흐름(+)
            //fixed4 c = tex2D (_MainTex, float2(IN.uv_MainTex.x + _Time.y, IN.uv_MainTex.y)); //x축, 좌측으로 흐름(-)
            fixed4 c = tex2D (_MainTex, float2(IN.uv_MainTex.x, IN.uv_MainTex.y + _Time.y)); //y축, 하단으로 흐름(-)
            o.Albedo = c.rgb; 
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
