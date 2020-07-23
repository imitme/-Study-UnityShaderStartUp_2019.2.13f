Shader "ShaderStudy/Part13/13-02-"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _BumpMap ("NormalMap", 2D) = "bump" {}
        _SpecCol ("Specular Color",Color) = (1,0,0,1)
        _SpecPow ("Specular Power",Range(10,200)) = 100
        _GlossTex("Gloss Tex",2D) = "white"{}
        
        _SpecCol2("Specular Color2",Color) = (1,1,1,1)
        _SpecPow2("Specular Power2",Range(10,200)) = 100
        _RimCol("Rim Color",Color) = (1,1,1,1)
        _RimcPow("Rim Power",Range(1,10)) = 3
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf Test

        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _GlossTex;
        float4 _SpecCol;
        float _SpecPow;

        float4 _SpecCol2;
        float _SpecPow2;
        float4 _RimCol;
        float _RimcPow;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float2 uv_GlossTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 m = tex2D (_GlossTex, IN.uv_GlossTex);
            o.Albedo = c.rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            o.Gloss = m.a;
            o.Alpha = c.a;
        }

        float4 LightingTest(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten) 
        {
            //Lambert term
            float3 DiffColor;
            float ndotl = saturate(dot(s.Normal, lightDir));
            DiffColor = ndotl * s.Albedo * _LightColor0.rgb * atten;

            //Spec term
            float3 H = normalize(lightDir + viewDir); 
            float spec = saturate(dot(H, s.Normal)); 
            spec = pow(spec, _SpecPow); 
            float3 SpecColor;
            SpecColor = spec * _SpecCol.rgb * s.Gloss;

            //Rim term
            float3 rimColor;
            float rim = abs(dot(viewDir, s.Normal));
            float invrim = 1 - rim;
            rimColor = pow(invrim, _RimcPow) * _RimCol.rgb;

            //Fake Spec term
            float3 SpecColor2;
            SpecColor2 = pow(rim, _SpecPow2) * _SpecCol2.rgb * s.Gloss;

            //final term
            float4 final;
            final.rgb = DiffColor.rgb + SpecColor.rgb + rimColor.rgb + SpecColor2.rgb; 
            final.a = s.Alpha;
            return final; 
        }
        ENDCG
    }
    FallBack "Diffuse"
}
