// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JAM/LeafWind"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_MainTex("MainTex", 2D) = "white" {}
		_Color("Color", Color) = (0,0,0,0)
		_WindSpeed("WindSpeed", Range( 0 , 10)) = 1
		_WindDirection("WindDirection", Vector) = (0,0,0,0)
		_WolrdFrequency("WolrdFrequency", Range( 0 , 1)) = 0
		_DistortionAmount("DistortionAmount", Vector) = (0,0,0,0)
		_BendAmount("BendAmount", Range( 0 , 1)) = 0
		_PositionOffset("PositionOffset", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Back
		Blend One Zero , SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float2 _WindDirection;
		uniform float _WolrdFrequency;
		uniform float _WindSpeed;
		uniform float _BendAmount;
		uniform float4 _DistortionAmount;
		uniform float3 _PositionOffset;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_108_0 = ( ( ( ase_worldPos.x + ase_worldPos.z ) * _WolrdFrequency ) + ( _Time.y * _WindSpeed ) );
			float temp_output_110_0 = cos( temp_output_108_0 );
			float3 temp_output_112_0 = ( ase_vertex3Pos * ( temp_output_110_0 + ( temp_output_110_0 - sin( temp_output_108_0 ) ) ) );
			float3 temp_output_129_0 = ( float3( _WindDirection ,  0.0 ) * ( ( temp_output_112_0 * _BendAmount ) - temp_output_112_0 ) );
			float4 appendResult116 = (float4(temp_output_129_0.xy , temp_output_129_0.xy));
			float4 break119 = mul( appendResult116, unity_ObjectToWorld );
			float4 appendResult123 = (float4(break119.x , break119.y , break119.z , 0.0));
			float4 temp_output_97_0 = ( ( appendResult123 * _DistortionAmount ) + float4( _PositionOffset , 0.0 ) );
			v.vertex.xyz += temp_output_97_0.xyz;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode35 = tex2D( _MainTex, uv_MainTex );
			o.Albedo = ( _Color * tex2DNode35 ).rgb;
			o.Alpha = 1;
			clip( tex2DNode35.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Unlit/Transparent Cutout"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18500
0;0;1536;803;-849.7543;963.9266;1.697447;True;False
Node;AmplifyShaderEditor.CommentaryNode;144;-1580.208,-1117.101;Inherit;False;4132.78;1167.99;;28;97;99;96;123;98;119;118;117;116;129;128;113;112;111;109;136;143;135;110;108;124;105;107;104;125;106;103;114;Wind Vertex Displacement;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;103;-1310.046,-825.5103;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TimeNode;107;-1052.149,-456.2086;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;104;-1035.15,-750.1089;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;125;-1155.836,-271.5733;Inherit;False;Property;_WindSpeed;WindSpeed;3;0;Create;True;0;0;False;0;False;1;8.16;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-1214.149,-589.2088;Inherit;False;Property;_WolrdFrequency;WolrdFrequency;5;0;Create;True;0;0;False;0;False;0;0.351;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-791.4385,-428.2906;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-765.9686,-606.5291;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;108;-586.15,-593.2088;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;135;-399.808,-458.3543;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;110;-362.788,-588.318;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;143;-187.5891,-400.5048;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;109;-131.3096,-791.5524;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;136;-12.21743,-562.9632;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;189.7843,-569.0857;Inherit;False;Property;_BendAmount;BendAmount;7;0;Create;True;0;0;False;0;False;0;0.93;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;112;181.6416,-753.0594;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;512.2874,-738.8367;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;114;706.652,-596.8706;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;128;754.4535,-801.363;Inherit;False;Property;_WindDirection;WindDirection;4;0;Create;True;0;0;False;0;False;0,0;1,-2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;1037.437,-641.0219;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ObjectToWorldMatrixNode;117;1281.964,-398.0849;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.DynamicAppendNode;116;1332.511,-564.9581;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;118;1537.801,-525.0182;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;119;1724.771,-523.5568;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;123;2015.497,-520.9687;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;101;2744.114,-1977.248;Inherit;False;614.9829;489.45;Color and Main Texture plus Alpha;3;52;53;35;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;98;1871.022,-273.3878;Float;False;Property;_DistortionAmount;DistortionAmount;6;0;Create;True;0;0;False;0;False;0,0,0,0;0.1,0,0.1,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;96;2207.511,-160.1107;Float;False;Property;_PositionOffset;PositionOffset;8;0;Create;True;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;53;2854.062,-1927.248;Inherit;False;Property;_Color;Color;2;0;Create;True;0;0;False;0;False;0,0,0,0;0.3999995,0.8039216,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;2223.258,-449.2196;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;35;2794.114,-1717.798;Inherit;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;False;-1;None;e9158e7e3e4c4914498adb4143ed87a4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;3196.697,-1806.089;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCGrayscale;146;2671.081,-419.6736;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;147;2911.081,-418.6736;Inherit;False;Noisedistortion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;97;2400.172,-473.7638;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3825.323,-1128.866;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;JAM/LeafWind;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;Unlit/Transparent Cutout;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;104;0;103;1
WireConnection;104;1;103;3
WireConnection;124;0;107;2
WireConnection;124;1;125;0
WireConnection;105;0;104;0
WireConnection;105;1;106;0
WireConnection;108;0;105;0
WireConnection;108;1;124;0
WireConnection;135;0;108;0
WireConnection;110;0;108;0
WireConnection;143;0;110;0
WireConnection;143;1;135;0
WireConnection;136;0;110;0
WireConnection;136;1;143;0
WireConnection;112;0;109;0
WireConnection;112;1;136;0
WireConnection;113;0;112;0
WireConnection;113;1;111;0
WireConnection;114;0;113;0
WireConnection;114;1;112;0
WireConnection;129;0;128;0
WireConnection;129;1;114;0
WireConnection;116;0;129;0
WireConnection;116;2;129;0
WireConnection;118;0;116;0
WireConnection;118;1;117;0
WireConnection;119;0;118;0
WireConnection;123;0;119;0
WireConnection;123;1;119;1
WireConnection;123;2;119;2
WireConnection;99;0;123;0
WireConnection;99;1;98;0
WireConnection;52;0;53;0
WireConnection;52;1;35;0
WireConnection;146;0;97;0
WireConnection;147;0;146;0
WireConnection;97;0;99;0
WireConnection;97;1;96;0
WireConnection;0;0;52;0
WireConnection;0;10;35;4
WireConnection;0;11;97;0
ASEEND*/
//CHKSM=F718532372767A000DAF4C81788BBCDB0E167CF3