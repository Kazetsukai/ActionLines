Shader "Hidden/ScreenSpikeShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_SpikeTex ("Spike Texture", 2D) = "white" {}
		_CenterRadius ("Center Radius", float) = 0
		_CenterPos ("Center Position", Vector) = (0, 0, 0, 0)
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			sampler2D _SpikeTex;
			float _CenterRadius;
			float2 _CenterPos;

			fixed4 frag (v2f i) : SV_Target
			{
                const float PI = 3.14159;
				
				float2 center = (i.uv - _CenterPos);
				float r = sqrt(dot(center, center));
				float u = atan2(center.y, center.x);


				fixed4 col = tex2D(_MainTex, i.uv);
				fixed4 spikecol = tex2D (_SpikeTex, float2((u + PI) / (2 * PI), 1 + _CenterRadius - r));

				col = col + spikecol;

				return col;
			}
			ENDCG
		}
	}
}
