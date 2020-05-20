using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ReplacementShaderEffect1 : MonoBehaviour
{
    public Shader ReplacementShader;
    public Texture2D texture1;
    public Texture2D texture2;

    private void OnEnable()
    {
        if (ReplacementShader != null)
        {
            GetComponent<Camera>().SetReplacementShader(ReplacementShader, "RenderType");
        }
    }

    public void OnValidate()
    {
        Shader.SetGlobalTexture("_SecondTex", texture2);
        Shader.SetGlobalTexture("_MainTex1", texture1);
    }

    public void OnDisable()
    {
        GetComponent<Camera>().ResetReplacementShader();
    }
}