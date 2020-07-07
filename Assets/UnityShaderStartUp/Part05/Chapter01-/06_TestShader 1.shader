Shader "ShaderStudy/Part4/06_TestShader"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_TestColor("testcolor", Color) = (1,1,1,1) //Color 는 float4(R,G,B,A) 가짐.
	}
		SubShader
		{
			Tags { "RenderType" = "Opaque" }
			LOD 200

			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
			#pragma surface surf Standard fullforwardshadows

			// Use shader model 3.0 target, to get nicer looking lighting
			#pragma target 3.0

			sampler2D _MainTex;

			struct Input
			{
				float2 uv_MainTex;
			};

			half _Glossiness;
			half _Metallic;
			fixed4 _Color;
			float4 _TestColor;

			//출력부분 ㄱ
			void surf(Input IN, inout SurfaceOutputStandard o)
			{
				fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
				//o.Albedo = c.rgb;
				o.Albedo = _TestColor.rgb; //SurfaceOutputStandard 의 Albedo는 float3 이고 >>_TestColor는 float4이기에, .rgb 로 3개만 사용!
				o.Emission = _TestColor.rgb; //Albedo대신 사용 가능, 취향에 따라 선택
				o.Metallic = _Metallic;
				o.Smoothness = _Glossiness;
				o.Alpha = c.a;
			}
			ENDCG
		}
			FallBack "Diffuse"
}