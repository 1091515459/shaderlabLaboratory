Shader "Unity Shaders Book/Chapter 10/Reflection"
{
    Properties{
    _Color("Color Tint",Color) = (1,1,1,1)
    _ReflectColor("Reflection Color",Color) = (1,1,1,1)
    _ReflectAmount("Reflect Amount",Range(0,1)) = 1
    _Cubemap("Reflection Cubemap",Cube) = "_Skybox"{}
    }
    SubShader{
        Tags{}
    }
}
