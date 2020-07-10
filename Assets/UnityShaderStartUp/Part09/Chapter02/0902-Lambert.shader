Shader "ShaderStudy/Part9/0902-Lambert"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SpecColor("Specular Color",color) = (1,1,1,1) //절대 코드에서 받으면 안되고,여기서(Properties)에만 만들어야 한다(예약어이기에, 내부에서 받아서 안된다.). 이 이름(_SpecColor)은 예약어이고, 이 이름만 써야 한다.
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf BlinnPhong 
        //#pragma surface surf BlinnPhong noambient //환경광 제거되어, Specular확인하기 좋다.

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o) //Lambert와 동일
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            //o.Albedo = c.rgb * 0.5; //하이라이트 더 잘보이게 하는 법
			o.Specular = 0.5;	//Specular크기:: 0:커짐 1:작아짐
			o.Gloss = 1;		//Specular강도:: 0:둔탁 1:매끈
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
