Shader "ShaderStudy/Part7/0701-"
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
        #pragma surface surf Standard noambient
		//ㄴ noambient : ambient컬러 영향을 없애서 온전한 색상으로 보일 수 있도록 하는 옵션!

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
            float4 color:COLOR;//1. input구조체 안에 (COLOR 상속받는?)color변수를 선언.
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            //o.Albedo = c.rgb; //결과값 빛영향 받지 않도록 Emission사용하려고, 주석 ;; 주석 풀면 Albedo+Emission 되어, 밝게(하얗게) 됨
            //o.Emission = IN.color.rgb; //2. input구조체 안에 (COLOR 상속받는?)color변수를 사용.
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
