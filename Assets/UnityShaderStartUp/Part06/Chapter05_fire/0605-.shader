Shader "ShaderStudy/Part6/0605-"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Transparent"}//2.투명을 위해
		LOD 200

        CGPROGRAM
        #pragma surface surf Standard alpha:fade //2.투명을 위해

        sampler2D _MainTex;
        sampler2D _MainTex2;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 d = tex2D (_MainTex2, IN.uv_MainTex2);
            o.Emission = d.rgb;  // 1.빛영향X
            o.Alpha = d.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
