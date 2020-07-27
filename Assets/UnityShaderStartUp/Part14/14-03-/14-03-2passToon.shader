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

        //1st Pass
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG

        ////2nd Pass
        //CGPROGRAM
        //#pragma surface surf Lambert

        //sampler2D _MainTex;

        //struct Input
        //{
        //    float2 uv_MainTex;
        //};

        //void surf(Input IN, inout SurfaceOutput o)
        //{
        //    fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
        //    o.Albedo = c.rgb;
        //    o.Alpha = c.a;
        //}
        //ENDCG

    }
    FallBack "Diffuse"
}
