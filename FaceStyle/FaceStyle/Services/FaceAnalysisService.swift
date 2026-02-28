import Foundation
import simd

/// 面部比例计算引擎
/// 从 FaceScanData 的 3D 坐标计算所有面部比例指标
struct FaceAnalysisService {

    /// 从扫描数据计算完整的面部测量指标
    func analyze(scanData: FaceScanData) -> FaceMetrics {
        let lm = scanData.landmarks

        // MARK: - 核心距离计算

        let faceLength = distance3D(lm.foreheadTop, lm.chin)
        let faceWidth = distance3D(lm.cheekboneLeft, lm.cheekboneRight)
        let foreheadWidth = distance3D(lm.templeLeft, lm.templeRight)
        let jawWidth = distance3D(lm.jawAngleLeft, lm.jawAngleRight)
        let cheekboneWidth = faceWidth  // 同义

        // MARK: - 三庭计算

        let upperThird = distance3D(lm.foreheadTop, lm.browCenter)
        let middleThird = distance3D(lm.browCenter, lm.noseBase)
        let lowerThird = distance3D(lm.noseBase, lm.chin)

        // MARK: - 下颌分析

        let jawAngle = calculateJawAngle(
            jawLeft: lm.jawAngleLeft,
            chin: lm.chin,
            jawRight: lm.jawAngleRight
        )

        let chinSharpness = calculateChinSharpness(jawContour: lm.jawContour)

        return FaceMetrics(
            faceLength: faceLength,
            faceWidth: faceWidth,
            foreheadWidth: foreheadWidth,
            jawWidth: jawWidth,
            cheekboneWidth: cheekboneWidth,
            upperThird: upperThird,
            middleThird: middleThird,
            lowerThird: lowerThird,
            jawAngle: jawAngle,
            chinSharpness: chinSharpness
        )
    }

    // MARK: - 3D距离计算

    /// 两点间的3D欧氏距离
    private func distance3D(_ a: SIMD3<Float>, _ b: SIMD3<Float>) -> Float {
        simd_distance(a, b)
    }

    // MARK: - 下颌角度计算

    /// 计算下颌角角度（度数）
    /// 以下巴为顶点，左右下颌角为两端，计算夹角
    private func calculateJawAngle(jawLeft: SIMD3<Float>, chin: SIMD3<Float>, jawRight: SIMD3<Float>) -> Float {
        let vecL = jawLeft - chin
        let vecR = jawRight - chin

        let lengthL = simd_length(vecL)
        let lengthR = simd_length(vecR)

        guard lengthL > 0 && lengthR > 0 else { return 130 } // 默认中间值

        let cosAngle = simd_dot(vecL, vecR) / (lengthL * lengthR)
        let clampedCos = min(max(cosAngle, -1.0), 1.0)
        let angleRadians = acos(clampedCos)
        return angleRadians * 180 / .pi
    }

    // MARK: - 下巴尖锐度计算

    /// 计算下巴尖锐度 (0=圆润, 1=尖锐)
    /// 基于下颌轮廓在下巴区域的曲率
    private func calculateChinSharpness(jawContour: [SIMD3<Float>]) -> Float {
        guard jawContour.count >= 3 else { return 0.5 }

        // 取下巴附近的3个点计算曲率
        let midIndex = jawContour.count / 2
        let leftIdx = max(midIndex - 1, 0)
        let rightIdx = min(midIndex + 1, jawContour.count - 1)

        let left = jawContour[leftIdx]
        let center = jawContour[midIndex]
        let right = jawContour[rightIdx]

        // 计算三点夹角
        let vecL = left - center
        let vecR = right - center

        let lengthL = simd_length(vecL)
        let lengthR = simd_length(vecR)

        guard lengthL > 0 && lengthR > 0 else { return 0.5 }

        let cosAngle = simd_dot(vecL, vecR) / (lengthL * lengthR)
        let clampedCos = min(max(cosAngle, -1.0), 1.0)
        let angleDegrees = acos(clampedCos) * 180 / .pi

        // 角度越小→下巴越尖
        // 60°以下为很尖 → sharpness ≈ 1.0
        // 140°以上为很圆润 → sharpness ≈ 0.0
        let sharpness = 1.0 - max(0, min(1, (angleDegrees - 60) / 80))
        return sharpness
    }
}
