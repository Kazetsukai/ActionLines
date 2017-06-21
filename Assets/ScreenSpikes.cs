using System;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

[Serializable]
public class ScreenSpikes : MonoBehaviour {
    public Material mat;
    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Graphics.Blit(src, dest, mat);
    }

    Vector3 xy = new Vector3();

    public void Update()
    {
        mat.SetFloat("_CenterRadius", (Mathf.Sin(Time.realtimeSinceStartup * 20)+1) / 5);

        xy = Camera.main.ScreenToViewportPoint(Input.mousePosition);

        mat.SetVector("_CenterPos", xy);
    }
}