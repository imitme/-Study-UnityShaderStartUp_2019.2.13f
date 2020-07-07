Shader "ShaderStudy/Part5/01_TestShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
	//ㄴ _MainTex  : 입력받는변수 //"Albedo (RGB)" :인스펙터에 나타나는이름 // 2D : 2D 텍스쳐받는다는 부분 **  //"white" {}: 흰색텍스쳐들어가 있다고 생각되도록 만들라는 의미.("gray" {} , "black" {}  등으로 대체 가능)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows


        sampler2D _MainTex;
	//ㄴ 입력받은 텍스쳐 smapler로 받음. //위치와 대소문자 중요 // 선언위치 중요!
	//ㄴ 텍스쳐는 UV와 만나기 전까지는, 메모리에 올라와 있는 이미지일뿐, UV와 만나서 제대로 자리잡아야 비로서, float4로 표현가능!
	//ㄴ 해서, sampler2D로 선언하는것!

        struct Input
        {
            float2 uv_MainTex;
			//ㄴ 미리 정해진 규칙대로 작성해야 함
			//ㄴ UV 는 버텍스 가지고 있어, 만든것이 아닌 외부파일인 vertex 내부에 있는 것을 엔진에게 내놓으라고 명령할 때에는 input 구조체 안에 넣어야 한다.
			//ㄴ uv 는 2가지 숫자로 이루어즈기에, float2.
			//ㄴ _MainTex의 uv라는 뜻으로, 텍스쳐샘플러 이름 앞에 uv라는 글자 붙임.
        };



        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			//ㄴ 텍스쳐 연산함수 tex2D를 이용해, 텍스쳐의 컬러를 화면에 출력! //ㄴ float4 결과 = tex2D(sampler, UV) 
			//ㄴ fixed인 이유 :fixed4(11bits) - float4(32bits) 텍스쳐 컬러가 채널당 8bit 이하이기에, fixed로도 충분!해, 텍스쳐변수는 fixed4로 사용하도록 되어 있으나, 익숙하지 않다면, float사용 가능.
			//ㄴ IN. 인 이유 ; Input IN 구조체를 불러와서 사용해야하기 때문에,
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
