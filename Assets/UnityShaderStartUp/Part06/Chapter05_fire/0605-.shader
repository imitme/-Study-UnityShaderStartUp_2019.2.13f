Shader "ShaderStudy/Part6/0605-"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Transparent"}//2.투명을 위해
		LOD 200

        CGPROGRAM
        #pragma surface surf Standard alpha:fade //2.투명을 위해

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Emission = c.rgb;  // 1.빛영향X
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
