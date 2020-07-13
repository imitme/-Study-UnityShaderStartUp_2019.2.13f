Shader "ShaderStudy/Part12/12-01-rim"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Lambert noambient

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
			float3 viewDir; //2. view Direction 받아오기(vertex to Camera) //lightDir (vertex to Light)
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = 0;// 1. 검정색으로 만들기 : 순수한 Fresnel 공식 확인을 위해.
            o.Alpha = c.a;

			float rim = dot(o.Normal, IN.viewDir);
			o.Emission = pow(1 - rim, 3); //얇게 만들기위해, 3제곱 만들기!
			
        }
        ENDCG
    }
    FallBack "Diffuse"
}
