Shader "ShaderStudy/Part11/11-01-CustomLight"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap("NormalMap", 2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Test noambient 

        sampler2D _MainTex;
		sampler2D _BumpMap;

        struct Input
        {
            float2 uv_MainTex;
			float2 uv_BumpMap;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            o.Alpha = c.a;
        }
		float4 LightingTest(SurfaceOutput s, float3 lightDir, float atten) 
		{
			float ndotl = dot(s.Normal, lightDir); //step 1 : -1 ~ 1 범위 출력
			ndotl = ndotl *0.5 +0.5; //step 2 :  라이팅 결과물에 *0.5 + 0.5 라는 마법의 공식 넣어 음영결과 부드럽게 하기 (반대의 공식 ; *2 -1)
			ndotl = pow(ndotl, 3); //step 3 :  음영이 너무 브드러워, 물리적으로 전혀 옳지 않게, 180도 영향을 끼쳐, 이를 줄이고자, 결과물에 제곱해준다. :: ndotl의 3제곱 == pow(ndotl, 3)
			return ndotl;
		}
	
        ENDCG
    }
    FallBack "Diffuse"
}
