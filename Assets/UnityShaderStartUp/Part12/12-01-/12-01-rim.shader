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
			o.Emission = 1-rim; //dot연산은 -1까지 내려간다 잊지말기! >>Rim으로 보이나, 너무 두꺼워 느낌이 살지 않아, 흰 테두리를 더 얇게 만들어줄 필요가 있다.
			
        }
        ENDCG
    }
    FallBack "Diffuse"
}
