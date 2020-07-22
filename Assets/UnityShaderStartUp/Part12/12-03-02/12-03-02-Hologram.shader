Shader "ShaderStudy/Part12/12-03-02-Hologram"
{
    Properties
    {
        _BumpMap ("NormalMap", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" }	

        CGPROGRAM
        #pragma surface surf nolight noambient alpha:fade			

        sampler2D _BumpMap;

        struct Input
        {
            float2 uv_BumpMap;
            float3 viewDir;
            float3 worldPos;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            o.Emission =float3(0,1,0);
			float rim = saturate(dot(o.Normal, IN.viewDir));
			rim = saturate(pow(1 - rim, 3) + pow(frac(IN.worldPos.g * 30 - _Time.y), 5) *0.1); //속도 빠르게 하면 줄무늬 많아져!
            o.Alpha = rim;
        }

        float4 Lightingnolight(SurfaceOutput s, float3 lightDir, float atten) 
        {
            return float4(0,0,0,s.Alpha);
        }
        ENDCG
    }
    FallBack "Transparent/Diffuse" //그림자 생성하지 않도록 넣은 코드 << 이펙트 와 같은 쉐이더는 그림자 필요없기에, Transparent계열이 쉐이더를 FallBack으로 넣어 놓은것임.
}
