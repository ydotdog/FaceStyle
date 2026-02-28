import Foundation

/// 脸型分类结果
struct FaceShapeResult: Equatable {
    /// 主脸型
    let primaryShape: FaceShape
    /// 主脸型的置信度 (0.0 - 1.0)
    let confidence: Float
    /// 次要倾向脸型（如"偏心形的椭圆脸"）
    let secondaryShape: FaceShape?
    /// 特征描述列表
    let characteristics: [String]
    /// 各脸型的得分（用于调试和可视化）
    let allScores: [FaceShape: Float]

    /// 格式化的置信度百分比字符串
    var confidencePercent: String {
        "\(Int(confidence * 100))%"
    }

    /// 完整的脸型描述
    var fullDescription: String {
        if let secondary = secondaryShape {
            return "\(primaryShape.displayName) (\(secondary.displayName))"
        }
        return primaryShape.displayName
    }

    // Equatable conformance (allScores dict needs manual impl)
    static func == (lhs: FaceShapeResult, rhs: FaceShapeResult) -> Bool {
        lhs.primaryShape == rhs.primaryShape &&
        lhs.confidence == rhs.confidence &&
        lhs.secondaryShape == rhs.secondaryShape &&
        lhs.characteristics == rhs.characteristics
    }
}
