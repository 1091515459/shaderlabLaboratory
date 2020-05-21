using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ReplacementShaderEffect : MonoBehaviour {
    public Shader ReplacementShader;
    public Texture2D texture1;
    public Texture2D texture2;
    public Color color;

    private void OnEnable () {
        if (ReplacementShader != null) {
            GetComponent<Camera> ().SetReplacementShader (ReplacementShader, "");
        }
    }

    public void OnValidate () {
        Shader.SetGlobalColor("_OverDrawColor",color);
    }

    public void OnDisable () {
        GetComponent<Camera> ().ResetReplacementShader ();
    }
}