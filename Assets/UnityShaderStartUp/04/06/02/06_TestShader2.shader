Shader "ShaderStudy/Part4/06_TestShader2"
{
	Properties
	{
		_Red("Red", Range(0,1)) = 0
		_Green("Green", Range(0,1)) = 0
		_Blue("Blue", Range(0,1)) = 0 //Red,Green,Blue 변수선언시, '예약어'이기에 주의필요
		_BrightDark("Brightness $ Darkness", Range(-1,1)) = 0 //(0,1) 단순밝아짐. (-1,1) 어둡고 밝아짐
	}
		SubShader
		{
			Tags { "RenderType" = "Opaque" }

			CGPROGRAM
			#pragma surface surf Standard fullforwardshadows



			struct Input
			{
				float4 color : COLOR; //버텍스 컬러 받아오는 구문
			};

			//Properties 와 같은 크기&이름 변수 선언 ㄱ
			float _Red;
			float _Green;
			float _Blue;
			float _BrightDark;

			void surf(Input IN, inout SurfaceOutputStandard o)
			{

				o.Albedo = float3(_Red, _Green, _Blue) + _BrightDark;
				o.Alpha = 1; //불투명
			}
			ENDCG
		}
			FallBack "Diffuse"
}