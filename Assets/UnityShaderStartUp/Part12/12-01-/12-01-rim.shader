Shader "ShaderStudy/Part12/12-01-rim"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _BumpMap ("NormalMap", 2D) = "Bump" {}
        _RimColor ("RimColor", Color) = (1,1,1,1)
        _RimPower ("RimPower", Range(1,10)) = 3
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Lambert noambient

        sampler2D _MainTex;
        sampler2D _BumpMap;
		float4 _RimColor;	//색이니까, float4
		float _RimPower;	//제곱근 수 하나이기에, float

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
			float3 viewDir; //2. view Direction 받아오기(vertex to Camera) //lightDir (vertex to Light)
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb; //텍스쳐 색상
			o.Normal = UnpackNormal(tex2D(_BumpMap,IN.uv_BumpMap)); //Rim연산에서, Normal사용하기에, 반드시, Rim 연산 전에, NormalMap연산하기!
            o.Alpha = c.a;

			float rim = dot(o.Normal, IN.viewDir);
			o.Emission = pow(1 - rim, _RimPower) * _RimColor.rgb; //얇게 만들기위해, 3제곱 만들기!
			
        }
        ENDCG
    }
    FallBack "Diffuse"
}
