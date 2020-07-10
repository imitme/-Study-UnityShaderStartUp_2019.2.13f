Shader "ShaderStudy/Part11/11-01-CustomLight"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Test noambient // 커스텀(라이트명) 라이팅적기! // 환경광 제거


        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
		float4 LightingTest(SurfaceOutput s, float3 lightDir, float atten) //커스텀_라이팅함수만들기!  **함수명주의!!!  Lighting+(라이트명)   //해야, 라이트 함수로 받아드린다!
		{
			float ndotl = max(0, dot(s.Normal, lightDir));
			ndotl = saturate(dot(s.Normal, lightDir));
			return ndotl;

			/*
		//아직, Lambert 라이트 완성X : 조명의 색 받지 못하는 등의 문제가 있다.
		//빛을 비춰도 음수에 숫자를 더하게 되어 밝아지지 않는 문제 있음. >>0아래 전부 0으로 잘라버려라 라는 함수 필요!
		ㄴ 0아래 전부 0으로 잘라버려라 라는 함수 == staturate . max사용
			*/
		}
		/*
		라이팅 함수의 규격은 미리 정해져 있다. 해서, 수정 불가 - 주어진대로만 사용해야 한다.
		제일 나중에 실행되기에, 코드내함수위치는 상관없다.
		그외에, Properties에서 변수로 받아오는 값, SurfaceOutPut(구조체), float3 lightDir, float atten이 있다!
		- 구조체는 surf함수에서 넣은 값을 바로 꺼내서 사용할 수 있다!!
		- lightDir 은 조명방향벡터:-되고, 길이가 1인 단위벡터
		-atten 는 attenuation(감쇠)의 준말 ; 그람지를 받거나, 거리가 멀어지면서 점점 조명이 흐려지는 라이트의 거리별 감쇠현상을 나타낸다.(내가 빛 받는것을 없앨때 사용되는 부분)
		*/
        ENDCG
    }
    FallBack "Diffuse"
}
