// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JAM/Water"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Color("Color", Color) = (0.5424528,0.8558081,1,0)
		_Speed("Speed", Range( 0 , 1)) = 0.4470588
		_WaterDaknessBlend("WaterDaknessBlend", Range( 0 , 1)) = 0
		_Noise("Noise", 2D) = "white" {}
		_NoiseDistortIntensity("NoiseDistortIntensity", Range( 0 , 1)) = 0

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
	LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		AlphaToMask Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform float4 _Color;
			uniform sampler2D _TextureSample0;
			uniform float _Speed;
			uniform sampler2D _Noise;
			SamplerState sampler_Noise;
			uniform float _NoiseDistortIntensity;
			uniform float _WaterDaknessBlend;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				float2 appendResult12 = (float2(0.0 , -_Speed));
				float2 texCoord2 = i.ase_texcoord1.xy * float2( 1,1 ) + float2( 0,0 );
				float2 break21 = texCoord2;
				float2 panner23 = ( _Time.y * appendResult12 + texCoord2);
				float lerpResult28 = lerp( ( tex2D( _Noise, panner23 ).g * break21.y ) , break21.y , _NoiseDistortIntensity);
				float2 appendResult26 = (float2(break21.x , lerpResult28));
				float2 panner3 = ( _Time.y * appendResult12 + appendResult26);
				float4 tex2DNode1 = tex2D( _TextureSample0, panner3 );
				float4 lerpResult16 = lerp( ( _Color + tex2DNode1 ) , ( _Color * tex2DNode1 ) , _WaterDaknessBlend);
				
				
				finalColor = lerpResult16;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18500
1536;0;1920;1019;3055.781;1223.596;2.078479;True;False
Node;AmplifyShaderEditor.RangedFloatNode;14;-2135.845,208.401;Inherit;False;Property;_Speed;Speed;2;0;Create;True;0;0;False;0;False;0.4470588;0.527;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1870.844,119.401;Inherit;False;Constant;_Zero;Zero;2;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;31;-1835.565,220.175;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;5;-1538.095,300.1174;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-2358.197,-106.0825;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;12;-1669.844,147.401;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;23;-2246.901,-385.9181;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;21;-1985.202,-282.8181;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;24;-2004.202,-539.8181;Inherit;True;Property;_Noise;Noise;4;0;Create;True;0;0;False;0;False;-1;None;684bbe17fe208bb429b2fdf25c923503;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;-1586.246,-75.35963;Inherit;False;Property;_NoiseDistortIntensity;NoiseDistortIntensity;5;0;Create;True;0;0;False;0;False;0;0.6901526;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-1634.202,-441.8181;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;28;-1364.894,-157.8103;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;-1074.202,-438.8181;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;3;-1311.095,124.1174;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-589.3853,101.0677;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;False;-1;965103e71fa9b8149b0b2bceb8e9ab29;965103e71fa9b8149b0b2bceb8e9ab29;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-513.6584,-142.4604;Inherit;False;Property;_Color;Color;1;0;Create;True;0;0;False;0;False;0.5424528,0.8558081,1,0;0,0.7524567,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-164.6581,-43.46035;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-146.5503,-308.3297;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;106.0288,72.71591;Inherit;False;Property;_WaterDaknessBlend;WaterDaknessBlend;3;0;Create;True;0;0;False;0;False;0;0.203;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;16;491.4498,-193.3297;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.7830189;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;10;-152.1352,232.3513;Inherit;False;True;False;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;32;860,-77;Float;False;True;-1;2;ASEMaterialInspector;100;1;JAM/Water;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;True;0;False;-1;True;0;False;-1;True;True;True;True;True;0;False;-1;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ForwardBase;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;;False;0
WireConnection;31;0;14;0
WireConnection;12;0;13;0
WireConnection;12;1;31;0
WireConnection;23;0;2;0
WireConnection;23;2;12;0
WireConnection;23;1;5;0
WireConnection;21;0;2;0
WireConnection;24;1;23;0
WireConnection;22;0;24;2
WireConnection;22;1;21;1
WireConnection;28;0;22;0
WireConnection;28;1;21;1
WireConnection;28;2;29;0
WireConnection;26;0;21;0
WireConnection;26;1;28;0
WireConnection;3;0;26;0
WireConnection;3;2;12;0
WireConnection;3;1;5;0
WireConnection;1;1;3;0
WireConnection;7;0;6;0
WireConnection;7;1;1;0
WireConnection;15;0;6;0
WireConnection;15;1;1;0
WireConnection;16;0;15;0
WireConnection;16;1;7;0
WireConnection;16;2;17;0
WireConnection;10;0;1;0
WireConnection;32;0;16;0
ASEEND*/
//CHKSM=CFF8A3E3232AB5A1078D3ECE46E4FEF24C25EC6F