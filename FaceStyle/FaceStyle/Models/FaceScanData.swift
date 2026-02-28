import Foundation
import simd

/// 从 ARKit Face Mesh 提取的关键顶点3D坐标
struct FaceLandmarks: Codable, Equatable {
    /// 下巴最低点
    let chin: SIMD3<Float>
    /// 额头最高可见点
    let foreheadTop: SIMD3<Float>
    /// 左颧骨最宽点
    let cheekboneLeft: SIMD3<Float>
    /// 右颧骨最宽点
    let cheekboneRight: SIMD3<Float>
    /// 左下颌角
    let jawAngleLeft: SIMD3<Float>
    /// 右下颌角
    let jawAngleRight: SIMD3<Float>
    /// 左太阳穴
    let templeLeft: SIMD3<Float>
    /// 右太阳穴
    let templeRight: SIMD3<Float>
    /// 鼻尖
    let noseTip: SIMD3<Float>
    /// 左外眼角
    let outerEyeLeft: SIMD3<Float>
    /// 右外眼角
    let outerEyeRight: SIMD3<Float>
    /// 眉心（两眉之间）
    let browCenter: SIMD3<Float>
    /// 鼻底（鼻翼下方）
    let noseBase: SIMD3<Float>

    // 下颌轮廓点序列（从左下颌角→下巴→右下颌角）
    let jawContour: [SIMD3<Float>]
}

/// 一次面部扫描的完整数据
struct FaceScanData: Codable {
    /// 扫描时间
    let timestamp: Date
    /// 关键面部地标的3D坐标
    let landmarks: FaceLandmarks
    /// 完整的面部网格顶点（1220个）
    let allVertices: [SIMD3<Float>]
    /// 扫描时人脸到摄像头距离（米）
    let faceDistance: Float
    /// 光照估计值（lumen）
    let ambientLightIntensity: Float?

    init(landmarks: FaceLandmarks,
         allVertices: [SIMD3<Float>],
         faceDistance: Float,
         ambientLightIntensity: Float? = nil) {
        self.timestamp = Date()
        self.landmarks = landmarks
        self.allVertices = allVertices
        self.faceDistance = faceDistance
        self.ambientLightIntensity = ambientLightIntensity
    }
}
