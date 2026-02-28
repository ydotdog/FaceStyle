import Foundation

/// 面部测量数据 — 所有长度单位为米（来自 ARKit 3D 坐标）
struct FaceMetrics: Codable, Equatable {
    // MARK: - 原始测量值（米）

    /// 额头顶点到下巴底点的3D距离
    let faceLength: Float
    /// 左右颧骨最宽点的3D距离
    let faceWidth: Float
    /// 左右太阳穴的3D距离
    let foreheadWidth: Float
    /// 左右下颌角的3D距离
    let jawWidth: Float
    /// 左右颧骨宽度（与faceWidth相同，保留语义区分）
    let cheekboneWidth: Float

    // MARK: - 三庭测量值（米）

    /// 发际线 → 眉心
    let upperThird: Float
    /// 眉心 → 鼻底
    let middleThird: Float
    /// 鼻底 → 下巴
    let lowerThird: Float

    // MARK: - 下颌特征

    /// 下颌角角度（度数），钝角=圆润，接近直角=方正
    let jawAngle: Float
    /// 下巴尖锐度 0（圆润）- 1（尖锐）
    let chinSharpness: Float

    // MARK: - 计算属性：比例指标

    /// 脸长宽比
    var lengthToWidthRatio: Float {
        guard faceWidth > 0 else { return 0 }
        return faceLength / faceWidth
    }

    /// 额头-下颌宽度比
    var foreheadToJawRatio: Float {
        guard jawWidth > 0 else { return 0 }
        return foreheadWidth / jawWidth
    }

    /// 颧骨-下颌宽度比
    var cheekboneToJawRatio: Float {
        guard jawWidth > 0 else { return 0 }
        return cheekboneWidth / jawWidth
    }

    /// 颧骨-额头宽度比
    var cheekboneToForeheadRatio: Float {
        guard foreheadWidth > 0 else { return 0 }
        return cheekboneWidth / foreheadWidth
    }

    // MARK: - 三庭比例

    private var totalThirds: Float {
        upperThird + middleThird + lowerThird
    }

    /// 上庭占比（理想值约0.333）
    var upperThirdRatio: Float {
        guard totalThirds > 0 else { return 0 }
        return upperThird / totalThirds
    }

    /// 中庭占比（理想值约0.333）
    var middleThirdRatio: Float {
        guard totalThirds > 0 else { return 0 }
        return middleThird / totalThirds
    }

    /// 下庭占比（理想值约0.333）
    var lowerThirdRatio: Float {
        guard totalThirds > 0 else { return 0 }
        return lowerThird / totalThirds
    }

    // MARK: - 特征描述

    /// 根据测量数据生成人类可读的面部特征描述列表
    var characteristics: [String] {
        var result: [String] = []

        // 三庭分析
        if upperThirdRatio > 0.37 {
            result.append(String(localized: "metrics.characteristic.highForehead",
                                defaultValue: "Higher forehead"))
        } else if upperThirdRatio < 0.29 {
            result.append(String(localized: "metrics.characteristic.lowForehead",
                                defaultValue: "Lower forehead"))
        }

        if lowerThirdRatio > 0.37 {
            result.append(String(localized: "metrics.characteristic.longLowerFace",
                                defaultValue: "Longer lower face"))
        } else if lowerThirdRatio < 0.29 {
            result.append(String(localized: "metrics.characteristic.shortLowerFace",
                                defaultValue: "Shorter lower face"))
        }

        // 脸型宽度分析
        if foreheadToJawRatio > 1.15 {
            result.append(String(localized: "metrics.characteristic.widerForehead",
                                defaultValue: "Forehead wider than jaw"))
        } else if foreheadToJawRatio < 0.85 {
            result.append(String(localized: "metrics.characteristic.widerJaw",
                                defaultValue: "Jaw wider than forehead"))
        }

        // 下颌分析
        if jawAngle > 140 {
            result.append(String(localized: "metrics.characteristic.roundedJaw",
                                defaultValue: "Rounded jawline"))
        } else if jawAngle < 120 {
            result.append(String(localized: "metrics.characteristic.angularJaw",
                                defaultValue: "Angular jawline"))
        }

        // 下巴分析
        if chinSharpness > 0.7 {
            result.append(String(localized: "metrics.characteristic.pointedChin",
                                defaultValue: "Pointed chin"))
        } else if chinSharpness < 0.3 {
            result.append(String(localized: "metrics.characteristic.roundedChin",
                                defaultValue: "Rounded chin"))
        }

        // 长宽比
        if lengthToWidthRatio > 1.4 {
            result.append(String(localized: "metrics.characteristic.longerFace",
                                defaultValue: "Longer face shape"))
        } else if lengthToWidthRatio < 1.1 {
            result.append(String(localized: "metrics.characteristic.rounderFace",
                                defaultValue: "Rounder face shape"))
        }

        return result
    }
}
