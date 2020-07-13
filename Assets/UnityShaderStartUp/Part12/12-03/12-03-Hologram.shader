Shader "ShaderStudy/Part12/12-03-Hologram"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _HolColor ("HologramColor (RGB)", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" }		//반투명구현 위해 넣어야 하는 부분2

        CGPROGRAM
        #pragma surface surf Lambert noambient alpha:fade					//반투명구현 위해 넣어야 하는 부분1

        sampler2D _MainTex;
        float4 _HolColor;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Emission = _HolColor;
			float rim = saturate(dot(o.Normal, IN.viewDir));
			rim = pow(1 - rim, 3);
            o.Alpha = rim;		//홀로그램 원리핵심 : Rim라이트 연산을 알파 패널에 넣는다!
        }
        ENDCG
    }
    FallBack "Diffuse"
}
