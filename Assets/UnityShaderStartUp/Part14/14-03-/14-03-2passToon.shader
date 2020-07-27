Shader "ShaderStudy/Part14/14-03-2passToon"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        //cull back // 뒷면을 날리고, 앞면을 살리는(백페이스 컬링:뒷면 그리지 않는다는 것), 명시적 표현
        //cull front // 뒷면을 살리고, 앞면을 날리는(프론트 페이스 컬링:) 보여주는 면만 뒤집힌 것이지, 노멀이 뒤집힌 것은 아니다.
        //cull off // 뒷면을 살리고, 앞면도 살리는(일면 2side:)
        cull front

        //1st Pass
        CGPROGRAM
        #pragma surface surf Nolight Lambert vertex:vert noshadow noambient //addshadow//noshadow

        sampler2D _MainTex;

        void vert(inout appdata_full v)
        {
            v.vertex.xyz = v.vertex.xyz + v.normal.xyz * 0.01;// *sin(_Time.y); //모든 벡터는 길이가 1로 되어 있기에, 각 버텍스가 노멀 방향으로 1유닛(1m) 으로 이동하니, *0.01 해주면(1cm) 확장된 모습 확인가능.
        }

        struct Input
        {
            float2 uv_MainTex;
            //ㄴ아무것도 받지 않으면, 문제가 일어나기에, //float4 color:COLOR; 해도 됨.
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
        }

        float4 LightingNolight(SurfaceOutput s , float3 lightDir, float atten)
        {
            return float4(0,0,0,1);
        }

        ENDCG

        //2nd Pass
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG

    }
    FallBack "Diffuse"
}
