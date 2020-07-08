Shader "ShaderStudy/Part6/0605-"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        //_MainTex2 ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Albedo (RGB)", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Transparent"}
		LOD 200

        CGPROGRAM
        #pragma surface surf Standard alpha:fade 
		//ㄴ 최적화X ; 실무에서 사용 X
		//ㄴ Standard : 물리기반라이팅 작동
		//ㄴ 시스템자원낭비이기에, 불 작업에서는(물리기반쉐이더가 필요하지 않기에)비효율적인 쉐이더가 되었음.
		//ㄴ 후에, 라이팅 연산을 배운 후, 라이팅을 전혀 처리하지 않는 코드로 고치면 부담없이 사용 가능한 연산(surf부분)이다!

        sampler2D _MainTex;
        sampler2D _MainTex2;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			fixed4 d = tex2D (_MainTex2, float2(IN.uv_MainTex2.x, IN.uv_MainTex2.y + _Time.y)); //02. 이미지 흐르면서 구겨지게 만들기 : 위로 흐르게 : -_Time.y
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex + d.r); //01. 색을 숫자처럼 사용가능! 색은 즉 숫자이다!
            o.Emission = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
