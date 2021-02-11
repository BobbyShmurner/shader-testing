Shader "Custom/Lambert Ambient"
{
    Properties {
        _Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)
    }

    SubShader {
        Pass {
            CGPROGRAM
            //Pragmas
            #pragma vertex vert
            #pragma fragment frag

            //User Vars
            uniform float4 _Color;

            //Unity Pre-Deffined
            uniform float4 _LightColor0;

            //Input Structs
            struct vertexInput{
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct vertexOutput{
                float4 pos : SV_POSITION;
                float4 col : COLOR;
            };

            //Vertex Function
            vertexOutput vert(vertexInput v) {
                vertexOutput o;

                float3 normalDir = normalize( mul(float4( v.normal, 0.0 ), unity_WorldToObject).xyz );
                float3 lightDir;
                float3 atten = 1.0;

                lightDir = normalize( _WorldSpaceLightPos0.xyz );

                float3 diffuseReflection = atten * _LightColor0.xyz * max( 0.0, dot(normalDir, lightDir) );
                float3 lightFinal = diffuseReflection * UNITY_LIGHTMODEL_AMBIENT.xyz;
                lightFinal *= _Color.rgb;

                o.col = float4(lightFinal, 1.0);
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            //Frag Function
            float4 frag(vertexOutput i) : COLOR {
                return i.col;
            }

            ENDCG
        }
    }

    //Comment Out Fallback when developing
    //Fallback "Diffuse"
}
