Shader "Custom/Diffuse"
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

            //Input Structs
            struct vertexInput{
                float4 vertex : POSITION;
            };
            struct vertexOutput{
                float4 pos : SV_POSITION;
            };

            //Vertex Function
            vertexOutput vert(vertexInput v) {
                vertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            //Frag Function
            float4 frag(vertexOutput i) : COLOR {
                return _Color;
            }

            ENDCG
        }
    }

    //Comment Out Fallback when developing
    //Fallback "Diffuse"
}
