Shader "ShaderStudy/Part13/13-02-"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _BumpMap ("NormalMap", 2D) = "bump" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Test noambient //환경광 꺼서, 음영 확실하게 보이게 하기

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

        float4 LightingTest(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten) //커스텀 라이트 함수 인자는 지정되어 있으며, 임의로 인자 순서를 바꿀 수 없다!
        {
            //Lambert term
            float3 DiffColor;
            float ndotl = saturate(dot(s.Normal, lightDir));
            DiffColor = ndotl * s.Albedo * _LightColor0.rgb * atten;

            //Spec term
            float3 H = normalize(lightDir + viewDir); //조명벡터와 카메라 벡터 더한 값을 normalize해서, 1로 만든 후 H에 집어넣음. 즉, 조명벡터와 카메라벡터의 중간인 하프벡터!
            float spec = saturate(dot(H, s.Normal)); //H : 벡터 덧셈연산이기에 float3 // spec : 벡터 내적연산이기에, float
            spec = pow(spec, 100); //내적영역 줄여주어, 스펙큘러 넓이 줄여주기

            //final term
            float4 final;
            final.rgb = DiffColor.rgb;
            final.a = s.Alpha;
            return spec; //스펙큘러 연산결과 확인용
            return float4(H,1); //H 확인용
            return final;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
