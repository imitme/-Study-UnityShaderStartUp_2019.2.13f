Shader "ShaderStudy/Part4/05_TestShader"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
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

			// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
			// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
			// #pragma instancing_options assumeuniformscaling
			UNITY_INSTANCING_BUFFER_START(Props)
				// put more per-instance properties here
			UNITY_INSTANCING_BUFFER_END(Props)

				void surf(Input IN, inout SurfaceOutputStandard o)
			{
				float r = 1; //한 자리 숫자							// r.r
				float2 gg = float2(0.5, 0); //두 자리 숫자			// gg.r , gg.g
				float3 bbb = float3(1, 0, 1); //세 자리 숫자			// bbb.r, bbb.g, bbb.b
				//변수 안 값 부르기위해서, 각각, r,g,b 순서로 부르면 된다.

				fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
				o.Albedo = float3(0, 0, 0); //검정
				o.Albedo = float3(r, 0, 0); // ==(1, 0 ,0) //빨강
				o.Albedo = float3(0, gg); // ==(0, 0.5, 0) //0.5 어두운 녹색
				o.Albedo = float3(r.r, 0, 0); // ==(1, 0 ,0) //빨강 //한자리 숫자밖에 들어있지 않은 변수이지만, 내부적으로 rgba 중 'r'값만 들어있다고 되어있기에!
				o.Albedo = float3(0, gg.rg); // ==(0, 0.5, 0) //0.5 어두운 녹색 //두자리 숫자밖에 들어있지 않은 변수이지만, 내부적으로 rgba 중 'r', 'g'값만 들어있다고 되어있기에!

				o.Albedo = float3(bbb.b, gg.r, r.r); // ==(1, 0.5, 1)
				o.Albedo = float3(1, 0.5, 1); // ==(1, 0.5, 1)

				o.Albedo = float3(bbb.rgb); // ==(1, 0, 1)
				o.Albedo = float3(1, 0, 1); // ==(1, 0, 1)

				o.Albedo = float3(r.rrr); // ==(1, 1, 1)
				o.Albedo = float3(1, 1, 1);

				o.Alpha = c.a;
			}
			ENDCG
		}
			FallBack "Diffuse"
}