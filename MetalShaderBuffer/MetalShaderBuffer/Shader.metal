//
//  Shader.metal
//  MetalBasicBuffer
//
//  Created by admin on 2020/8/25.
//  Copyright © 2020 admin. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;



#include <simd/simd.h>

typedef enum VertexInputIndex{
    VertexInputIndexVertices = 0,
    VertexInputIndexViewportSize = 1,
}VertexInputIndex;


typedef struct {
    vector_float2 position;
    vector_float4 color;
}Vertex;



typedef struct{
    float4 clipSpacePosition [[position]];
    
    float4 color;
} RasterizerData;

vertex RasterizerData vertexShader(uint vertexID [[vertex_id]],constant Vertex *vertices [[buffer(VertexInputIndexVertices)]],constant vector_uint2 *viewportSizePointer [[buffer(VertexInputIndexViewportSize)]]){
    /*
     处理顶点数据:
     1) 执行坐标系转换,将生成的顶点剪辑空间写入到返回值中.
     2) 将顶点颜色值传递给返回值
     */
    
    //定义out
    RasterizerData out;
    
    //初始化输出剪辑空间位置
    out.clipSpacePosition = vector_float4(0.0, 0.0, 0.0, 1.0);
    
    // 索引到我们的数组位置以获得当前顶点
    // 我们的位置是在像素维度中指定的.
    float2 pixelSpacePosition = vertices[vertexID].position.xy;
    
    //将vierportSizePointer 从verctor_uint2 转换为vector_float2 类型
    vector_float2 viewportSize = vector_float2(*viewportSizePointer);
    
    //每个顶点着色器的输出位置在剪辑空间中(也称为归一化设备坐标空间,NDC),剪辑空间中的(-1,-1)表示视口的左下角,而(1,1)表示视口的右上角.
    //计算和写入 XY值到我们的剪辑空间的位置.为了从像素空间中的位置转换到剪辑空间的位置,我们将像素坐标除以视口的大小的一半.
    out.clipSpacePosition.xy = pixelSpacePosition / (viewportSize / 2.0);
    
    //把我们输入的颜色直接赋值给输出颜色. 这个值将于构成三角形的顶点的其他颜色值插值,从而为我们片段着色器中的每个片段生成颜色值.
    out.color = vertices[vertexID].color;
    
    //完成! 将结构体传递到管道中下一个阶段:
    return out;
}

fragment float4 fragmentShader(RasterizerData in [[stage_in]])
{
    //返回输入的片元颜色
    return in.color;
}
