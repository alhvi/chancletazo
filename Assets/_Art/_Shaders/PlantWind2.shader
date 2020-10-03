// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JAM/LeafAnim2"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_NoiseDirection("NoiseDirection", Vector) = (3.26,0,3.36,0)
		_NoiseIntensity("NoiseIntensity", Range( 0 , 1.5)) = 1.052941
		_WindSpeed("WindSpeed", Range( 0 , 10)) = 1
		_LeafBending("LeafBending", Range( 0 , 1)) = 0
		_MaxLeafMapMotion("MaxLeafMapMotion", Range( 0 , 1)) = 1
		_WindEffectValue("WindEffectValue", Range( 0 , 1)) = 0
		_LeafTextureMotionBlend("LeafTextureMotionBlend", Range( 0 , 1)) = 0.7381778
		_MainTex("MainTex", 2D) = "white" {}
		_Color("Color", Color) = (0.3901064,0.6603774,0.2710039,0)
		_DistortionAmount("DistortionAmount", Vector) = (0,0,0,0)
		_PositionOffset("PositionOffset", Vector) = (0,0,0,0)
		_MapTiling("MapTiling", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Off
		Blend One Zero , SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float _LeafBending;
		uniform float3 _NoiseDirection;
		uniform float _WindSpeed;
		uniform float _NoiseIntensity;
		uniform float _WindEffectValue;
		uniform float4 _DistortionAmount;
		uniform float3 _PositionOffset;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float2 _MapTiling;
		uniform float _MaxLeafMapMotion;
		uniform float _LeafTextureMotionBlend;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 temp_output_4_0 = saturate( _NoiseDirection );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 normalizeResult8 = normalize( ase_worldPos );
			float2 panner9 = ( _Time.y * ( temp_output_4_0 * _WindSpeed ).xy + normalizeResult8.xy);
			float grayscale23 = Luminance(float3( ( cos( panner9 ) * _NoiseIntensity ) ,  0.0 ));
			float WorldNoise33 = grayscale23;
			float lerpResult37 = lerp( _LeafBending , ( ( ase_vertex3Pos.z * WorldNoise33 ) + ( WorldNoise33 * ase_vertex3Pos.y ) ) , _WindEffectValue);
			v.vertex.xyz += ( ( lerpResult37 * _DistortionAmount ) + float4( _PositionOffset , 0.0 ) ).xyz;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord51 = i.uv_texcoord * _MapTiling;
			float3 temp_output_4_0 = saturate( _NoiseDirection );
			float3 ase_worldPos = i.worldPos;
			float3 normalizeResult8 = normalize( ase_worldPos );
			float2 panner9 = ( _Time.y * ( temp_output_4_0 * _WindSpeed ).xy + normalizeResult8.xy);
			float grayscale23 = Luminance(float3( ( cos( panner9 ) * _NoiseIntensity ) ,  0.0 ));
			float WorldNoise33 = grayscale23;
			float lerpResult53 = lerp( pow( cos( WorldNoise33 ) , 2.0 ) , _MaxLeafMapMotion , _LeafTextureMotionBlend);
			float cos55 = cos( lerpResult53 );
			float sin55 = sin( lerpResult53 );
			float2 rotator55 = mul( uv_TexCoord51 - float2( 0,0 ) , float2x2( cos55 , -sin55 , sin55 , cos55 )) + float2( 0,0 );
			float4 tex2DNode27 = tex2D( _MainTex, rotator55 );
			o.Albedo = ( _Color * tex2DNode27 ).rgb;
			o.Alpha = 1;
			clip( tex2DNode27.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18500
0;0;1536;803;3360.381;824.6688;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;30;-3455.757,290.0001;Inherit;False;2259.62;691.5879;;12;8;17;6;11;4;19;16;20;21;23;1;9;World Noise;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;2;-3829.248,456.9082;Inherit;False;Property;_NoiseDirection;NoiseDirection;1;0;Create;True;0;0;False;0;False;3.26,0,3.36;3.26,0,3.36;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;6;-2940.907,771.6785;Inherit;False;Property;_WindSpeed;WindSpeed;3;0;Create;True;0;0;False;0;False;1;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-2971.596,345.7917;Inherit;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SaturateNode;4;-3140.461,637.733;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;8;-2673.007,351.5784;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-2597.939,635.5195;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TimeNode;16;-2557.251,800.988;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;9;-2312.25,349.3356;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2013.669,563.7928;Inherit;False;Property;_NoiseIntensity;NoiseIntensity;2;0;Create;True;0;0;False;0;False;1.052941;1.5;0;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;17;-1934.937,345.4678;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1643.911,346.9456;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCGrayscale;23;-1412.136,340.0001;Inherit;True;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;56;-2923.951,-578.4558;Inherit;False;1270.804;549.2896;;9;46;48;52;54;51;53;55;57;58;UV Animation;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;33;-1073.678,340.8768;Inherit;False;WorldNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;41;-2174.828,1421.707;Inherit;False;1015.405;715.3999;;9;32;37;38;39;40;35;36;31;34;Vertex Animation;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;-2871.451,-518.657;Inherit;False;33;WorldNoise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-2109.304,1719.598;Inherit;False;33;WorldNoise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;32;-2119.51,1891.959;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;31;-2124.828,1473.333;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CosOpNode;48;-2649.081,-438.3718;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-2833.126,-138.5662;Inherit;False;Property;_LeafTextureMotionBlend;LeafTextureMotionBlend;7;0;Create;True;0;0;False;0;False;0.7381778;0.627;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-1736.488,1821.965;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;57;-2509.381,-369.1688;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-2873.951,-262.7411;Inherit;False;Property;_MaxLeafMapMotion;MaxLeafMapMotion;5;0;Create;True;0;0;False;0;False;1;0.356;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-1733.27,1625.209;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;58;-2507.381,-520.1688;Inherit;False;Property;_MapTiling;MapTiling;12;0;Create;True;0;0;False;0;False;0,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.LerpOp;53;-2294.284,-291.5357;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-1628.423,1471.707;Inherit;False;Property;_LeafBending;LeafBending;4;0;Create;True;0;0;False;0;False;0;0.302;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;51;-2273.342,-528.4558;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;39;-1682.423,2021.707;Inherit;False;Property;_WindEffectValue;WindEffectValue;6;0;Create;True;0;0;False;0;False;0;0.518;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-1526.423,1744.707;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;26;-1261.467,-606.7261;Inherit;False;614.9829;489.45;Color and Main Texture plus Alpha;3;29;28;27;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RotatorNode;55;-1929.347,-371.4272;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;42;-852.5434,646.533;Float;False;Property;_DistortionAmount;DistortionAmount;10;0;Create;True;0;0;False;0;False;0,0,0,0;0.5,0,0.2,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;37;-1341.423,1715.707;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;28;-1151.519,-556.7261;Inherit;False;Property;_Color;Color;9;0;Create;True;0;0;False;0;False;0.3901064,0.6603774,0.2710039,0;0.3999998,0.8039216,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;43;-508.1512,826.9869;Float;False;Property;_PositionOffset;PositionOffset;11;0;Create;True;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-496.3557,624.8127;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;27;-1211.467,-347.2761;Inherit;True;Property;_MainTex;MainTex;8;0;Create;True;0;0;False;0;False;-1;412da351a229fbb43a664ca5dfbaafc1;412da351a229fbb43a664ca5dfbaafc1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-236.4586,631.8812;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-808.8834,-435.5671;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;19;-2927.685,564.1089;Inherit;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;14.26179,117.1576;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;JAM/LeafAnim2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;2;0
WireConnection;8;0;1;0
WireConnection;11;0;4;0
WireConnection;11;1;6;0
WireConnection;9;0;8;0
WireConnection;9;2;11;0
WireConnection;9;1;16;2
WireConnection;17;0;9;0
WireConnection;21;0;17;0
WireConnection;21;1;20;0
WireConnection;23;0;21;0
WireConnection;33;0;23;0
WireConnection;48;0;46;0
WireConnection;36;0;34;0
WireConnection;36;1;32;2
WireConnection;57;0;48;0
WireConnection;35;0;31;3
WireConnection;35;1;34;0
WireConnection;53;0;57;0
WireConnection;53;1;52;0
WireConnection;53;2;54;0
WireConnection;51;0;58;0
WireConnection;40;0;35;0
WireConnection;40;1;36;0
WireConnection;55;0;51;0
WireConnection;55;2;53;0
WireConnection;37;0;38;0
WireConnection;37;1;40;0
WireConnection;37;2;39;0
WireConnection;44;0;37;0
WireConnection;44;1;42;0
WireConnection;27;1;55;0
WireConnection;45;0;44;0
WireConnection;45;1;43;0
WireConnection;29;0;28;0
WireConnection;29;1;27;0
WireConnection;19;0;4;0
WireConnection;0;0;29;0
WireConnection;0;10;27;4
WireConnection;0;11;45;0
ASEEND*/
//CHKSM=F51577805A765F9C013A240FDEDDD6CB143B9B88