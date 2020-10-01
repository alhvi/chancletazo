// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "JAM/PlantWind"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_MainTex("MainTex", 2D) = "white" {}
		_BendStrength("Bend Strength", Float) = 0
		_BendDirection("Bend Direction", Vector) = (0,0,0,0)
		_Color("Color", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Back
		Blend One Zero , SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float _BendStrength;
		uniform float2 _BendDirection;
		uniform float4 _Color;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 appendResult57 = (float3((ase_worldPos).x , 0.0 , (ase_worldPos).z));
			float4 transform51 = mul(unity_WorldToObject,float4( appendResult57 , 0.0 ));
			float4 ase_vertex4Pos = v.vertex;
			float temp_output_41_0 = ( ( ase_vertex4Pos.y * ( _BendStrength / 100.0 ) ) + 1.0 );
			float temp_output_42_0 = ( temp_output_41_0 * temp_output_41_0 );
			float2 break49 = ( ( ( temp_output_42_0 * temp_output_42_0 ) - temp_output_42_0 ) * _BendDirection );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 appendResult48 = (float3(break49.x , ase_vertex3Pos.y , break49.y));
			v.vertex.xyz += ( transform51 + float4( appendResult48 , 0.0 ) ).xyz;
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
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18500
1664;93;1687;865;3518.442;959.1621;1.695278;True;False
Node;AmplifyShaderEditor.RangedFloatNode;39;-2666.117,-362.7477;Inherit;False;Property;_BendStrength;Bend Strength;2;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;34;-2778.696,-697.6062;Inherit;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;40;-2431.116,-436.7477;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;38;-2551.117,-647.7477;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-2215.605,-528.554;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;45;-1951.91,-561.8308;Inherit;False;889.7332;270;Bending Function;4;44;42;41;43;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-1901.91,-427.6058;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-1674.177,-426.8308;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-1443.077,-511.8308;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;44;-1228.177,-450.8308;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;46;-1147.248,-234.3242;Inherit;False;Property;_BendDirection;Bend Direction;3;0;Create;True;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WorldPosInputsNode;32;-894.7609,-679.6671;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-863.848,-447.5241;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;54;-610.8577,-728.8062;Inherit;False;FLOAT;0;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;55;-595.5577,-627.7062;Inherit;False;FLOAT;2;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;58;-696.2442,-318.3742;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;49;-709.4484,-447.5241;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;57;-395.2577,-690.3061;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;35;445.7034,-1480.254;Inherit;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;False;-1;None;412da351a229fbb43a664ca5dfbaafc1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;53;524.6511,-1846.704;Inherit;False;Property;_Color;Color;4;0;Create;True;0;0;False;0;False;0,0,0,0;0.4,0.8039216,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldToObjectTransfNode;51;-127.2527,-670.1554;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;48;-410.6452,-479.9006;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;984.2861,-1547.78;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;1;-449.9654,-911.5678;Inherit;False;Global;WindDirectionNode;WindDirectionNode;0;0;Create;True;0;0;False;0;False;0.13,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;50;151.6479,-499.2712;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1329.54,-1379.233;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;JAM/PlantWind;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;40;0;39;0
WireConnection;38;0;34;0
WireConnection;37;0;38;1
WireConnection;37;1;40;0
WireConnection;41;0;37;0
WireConnection;42;0;41;0
WireConnection;42;1;41;0
WireConnection;43;0;42;0
WireConnection;43;1;42;0
WireConnection;44;0;43;0
WireConnection;44;1;42;0
WireConnection;47;0;44;0
WireConnection;47;1;46;0
WireConnection;54;0;32;0
WireConnection;55;0;32;0
WireConnection;49;0;47;0
WireConnection;57;0;54;0
WireConnection;57;2;55;0
WireConnection;51;0;57;0
WireConnection;48;0;49;0
WireConnection;48;1;58;2
WireConnection;48;2;49;1
WireConnection;52;0;53;0
WireConnection;52;1;35;0
WireConnection;50;0;51;0
WireConnection;50;1;48;0
WireConnection;0;0;52;0
WireConnection;0;10;35;4
WireConnection;0;11;50;0
ASEEND*/
//CHKSM=03CB5D551563417054CFFCADF4A104209B2FDE64