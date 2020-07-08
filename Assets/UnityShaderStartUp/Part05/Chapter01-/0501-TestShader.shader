Shader "ShaderStudy/Part5/01_TestShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
		#pragma surface surf Standard 

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };



        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Albedo = (c.r + c.g + c.b)/3; 
            o.Albedo = ( (c.r + c.g + c.b)/3, (c.r + c.g + c.b) / 3, (c.r + c.g + c.b) / 3 ); //정석
			//ㄴ 각 요소를 각각 더하고, /3하면, 각 요소의 평균을 구한 한자리 숫자가 나온다.
			//ㄴ float3 을 넣어야 하지만, 한자리 숫자를 넣어도 문제없이 처리됨.
			o.Albedo = c.r * 0.2989 + c.g * 0.5870 + c.b * 0.1140; 
			//ㄴ RGB to YIQ 변환 매트릭스 방식 **
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
