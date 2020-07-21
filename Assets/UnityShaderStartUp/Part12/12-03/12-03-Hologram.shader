Shader "ShaderStudy/Part12/12-03-Hologram"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _HolColor ("HologramColor (RGB)", Color) = (1,1,1,1)
		_RimPower("RimPower", Range(0.1,10)) = 3
		_AlphaSpeed("AlphaSpeed", Range(0.1,100)) = 10
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" }		//반투명구현 위해 넣어야 하는 부분2

        CGPROGRAM
        #pragma surface surf Lambert noambient alpha:fade					//반투명구현 위해 넣어야 하는 부분1

        sampler2D _MainTex;
        float4 _HolColor;
		float _RimPower;
		float _AlphaSpeed;

        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Emission = _HolColor;
			float rim = saturate(dot(o.Normal, IN.viewDir));
			rim = pow(1 - rim, _RimPower);
            /*

            //o.Alpha = rim * sin(_Time.y * 3);		//깜빡이게 하기위해, sin사용     >>안보이는 시간이 길다.(-1~1사이이기에, 0 이하 부분이 절반이기떄문이다.)
            //o.Alpha = rim * sin(((_Time.y * 3) * 0.5 + 0.5));		// 안보이는것 해결을 위한 방법 1: 하프램버트 공식 사용 *0.5+0.5 : -1~1 을 0~1 로 변경!
            //o.Alpha = rim * abs(sin(((_Time.y * 3) * 0.5 + 0.5)));		// 안보이는것 해결을 위한 방법 2: abs()사용 :   음수를 양수로 전환 >> 통통튀는 느낌이 난다.

            */
            //o.Alpha = rim * sin(_Time.y * _AlphaSpeed);
            //o.Alpha = rim * sin(((_Time.y * _AlphaSpeed) * 0.5 + 0.5));	
            o.Alpha = rim * abs(sin(((_Time.y * _AlphaSpeed) * 0.5 + 0.5)));
        }
        ENDCG
    }
    FallBack "Diffuse"
}
