Shader "ShaderStudy/Part11/11-01-CustomLight"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Test noambient // 커스텀(라이트명) 라이팅적기! // 환경광 제거


        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
		float4 LightingTest(SurfaceOutput s, float3 lightDir, float atten) //커스텀_라이팅함수만들기!  **함수명주의!!!  Lighting+(라이트명)   //해야, 라이트 함수로 받아드린다!
		{
			return float4(1,0,0,1); //색 출력할 것이기에 float4
		}
        ENDCG
    }
    FallBack "Diffuse"
}
