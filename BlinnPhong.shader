Shader "Custom/BlinnPhongShader" {
	Properties {
		_MainTint ("Diffuse Tint", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SpecularColor ("Specular Color", Color) = (1,1,1,1)
		_SpecPower ("Specular Power", Range(0.1, 60)) = 3
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf CustomBlinnPhong
		#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _MainTint;
		fixed4 _SpecularColor;
		fixed _SpecPower;

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 LightingCustomBlinnPhong (SurfaceOutput s, fixed3 lightDir, fixed3 viewDir, fixed atten)
		{
			float NdotL = max(0, dot(lightDir, s.Normal));

			float3 halfVector = normalize(lightDir + viewDir);

			float NdotH = max(0, dot(s.Normal, halfVector));

			float spec = pow(NdotH, _SpecPower) * _SpecularColor;

			float4 c;
			c.rgb = (s.Albedo * _LightColor0.rgb * NdotL) + (_LightColor0.rgb *_SpecularColor.rgb * spec) * atten;
			c.a = s.Alpha;

			return c;
		}


		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _MainTint;
			o.Albedo = c.rgb;

		}
		ENDCG
	}
	FallBack "Diffuse"
}
