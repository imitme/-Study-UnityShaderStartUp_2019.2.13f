Shader "ShaderStudy/Part7/0703-VCMask"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Albedo (RGB)", 2D) = "white" {}
        _MainTex3 ("Albedo (RGB)", 2D) = "white" {}
        _MainTex4 ("Albedo (RGB)", 2D) = "white" {}
        _BumpMap ("NormalMap", 2D) = "bump" {}
		_Matallic("Matallic",Range(0,1)) = 0
		_Smoothness("Smoothness",Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
		#pragma target 3.0   //에러떄문에 추가 : Shader error in 'ShaderStudy/Part7/0703-VCMask': Too many texture interpolators would be used for ForwardBase pass (9 out of max 8), try adding #pragma target 3.0 at line 16
        #pragma surface surf Standard noambient

        sampler2D _MainTex;
        sampler2D _MainTex2;
        sampler2D _MainTex3;
        sampler2D _MainTex4;
        sampler2D _BumpMap;
        float _Matallic;
        float _Smoothness;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
            float2 uv_MainTex3;
            float2 uv_MainTex4;	//텍스쳐 담을공간
            float2 uv_BumpMap;
			float4 color:COLOR; //버텍스컬러 담은공간
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D (_MainTex2, IN.uv_MainTex2);
            fixed4 e = tex2D (_MainTex3, IN.uv_MainTex3);
            fixed4 f = tex2D (_MainTex4, IN.uv_MainTex4);
			o.Albedo = c.rgb;
			o.Albedo = lerp(c.rgb, d.rgb, IN.color.r);
			o.Albedo = lerp(o.Albedo, e.rgb, IN.color.g);
			o.Albedo = lerp(o.Albedo, f.rgb, IN.color.b);
			o.Albedo =	c.rgb * (1-(IN.color.r + IN.color.g + IN.color.b))
						+ d.rgb * IN.color.r
						+ e.rgb * IN.color.g
						+ f.rgb * IN.color.b				;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			o.Metallic = _Matallic;
			o.Smoothness =  (IN.color.b * 0.5) * _Smoothness + 0.35;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
