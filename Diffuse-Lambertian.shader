Shader "CustomShader/StandardDiffuse"
{
	Properties
	{
		_AmbientColor ("Ambient Color", Color) = (1,1,1,1)

	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 200


			CGPROGRAM
			#pragma surface surf Lambert fullforwardshadows

			#pragma target 3.0
			
			//#include "UnityCG.cginc"


			struct Input 
			{
				float2 uv_MainTex;
			};

			fixed4 _AmbientColor;

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo = _AmbientColor.rgb;
			}

			ENDCG
		}
		Fallback "Diffuse"
}
