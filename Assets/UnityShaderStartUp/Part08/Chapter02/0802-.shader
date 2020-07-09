Shader "ShaderStudy/Part8/0802-"
{
	/*
	물리기반 렌더링 기본개념 == 에너지 보존법칙
	: 나가는 빛의 양은 들어온 빛이ㅡ 양을 넘을 수 없다.
	: 재질의 거칠기에 따라 난반사와 정반사의 비율이 결정된다.
	ㄴ 정반사가 높아지면, 그만큼 난반사는 줄게된다.
	
	cf. Metallic Value Chart 참조
	*/
		
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Metallic ("Metallic", Range(0,1)) = 0			//반사정도(0:난반사Diffuse :스페큘러컬러흑백, 1:정반사Specular :스체큘러 컬러 albedo) >>금속은 고유의 스페큘러 컬러를 가지고 있기 떄문에, 그급적 0,1을 사용하는 것이 정확한 물리 기반 쉐이더를 다루는 방법이다.
        _Smoothness ("Smoothness", Range(0,1)) = 0.5	//재질이 매끄러운지 거친지 결정(UNREAL-Roughness)
		_BumpMap("Normalmap", 2D) = "bump" {}			//이상하지만, 유니티에서 내장으로 bump라고 명칭해 사용하고 있음. //1. 입력받는공간만들고
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard 

        sampler2D _MainTex;
        sampler2D _BumpMap; //2. 변수선언하고
        float _Metallic;
        float _Smoothness;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap; //3.연결공간만들고
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap)); //4. 변수사용//텍스쳐를 받아서, UnpackNormal함수로 추출해 사용!
            o.Albedo = c.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
