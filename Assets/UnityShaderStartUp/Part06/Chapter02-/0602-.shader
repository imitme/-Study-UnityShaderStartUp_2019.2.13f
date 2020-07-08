Shader "ShaderStudy/Part6/0602-"
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
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = IN.uv_MainTex.x; // (x,x,x) 로 나오기에 > 검,흰으로 나옴
            o.Albedo = IN.uv_MainTex.y; // (y,y,y) 로 나오기에 > 검,흰으로 나옴
            o.Albedo = float3(IN.uv_MainTex.x, IN.uv_MainTex.y, 0); //(R , G , B) 이기에!  > 색으로 나옴
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
