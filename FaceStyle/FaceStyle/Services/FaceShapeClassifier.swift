import Foundation

/// 脸型分类器
/// 基于 FaceMetrics 的规则分类，输出主分类 + 置信度 + 混合脸型
struct FaceShapeClassifier {

    /// 执行分类
    func classify(metrics: FaceMetrics) -> FaceShapeResult {
        var scores: [FaceShape: Float] = [:]

        for shape in FaceShape.allCases {
            scores[shape] = calculateScore(for: shape, metrics: metrics)
        }

        // 按得分排序
        let sorted = scores.sorted { $0.value > $1.value }
        guard let first = sorted.first else {
            return FaceShapeResult(
                primaryShape: .oval, confidence: 0,
                secondaryShape: nil, characteristics: [], allScores: [:]
            )
        }
        let primaryShape = first.key
        let primaryScore = first.value

        // 总分归一化为置信度
        let totalScore = sorted.reduce(0) { $0 + $1.value }
        let confidence = totalScore > 0 ? primaryScore / totalScore : 0

        // 次要脸型：第二名得分 > 主分类得分的 60% 时才算"混合"
        let secondaryShape: FaceShape?
        if sorted.count > 1 && sorted[1].value > primaryScore * 0.6 {
            secondaryShape = sorted[1].key
        } else {
            secondaryShape = nil
        }

        let characteristics = metrics.characteristics

        return FaceShapeResult(
            primaryShape: primaryShape,
            confidence: confidence,
            secondaryShape: secondaryShape,
            characteristics: characteristics,
            allScores: scores
        )
    }

    // MARK: - 各脸型的评分逻辑

    private func calculateScore(for shape: FaceShape, metrics: FaceMetrics) -> Float {
        switch shape {
        case .round:   return scoreRound(metrics)
        case .square:  return scoreSquare(metrics)
        case .oblong:  return scoreOblong(metrics)
        case .heart:   return scoreHeart(metrics)
        case .diamond: return scoreDiamond(metrics)
        case .pear:    return scorePear(metrics)
        case .oval:    return scoreOval(metrics)
        }
    }

    /// 圆脸：脸长宽比 ≈ 1.0，下颌圆润
    private func scoreRound(_ m: FaceMetrics) -> Float {
        var score: Float = 0

        // 长宽比接近1.0（越接近越高分）
        let lwDeviation = abs(m.lengthToWidthRatio - 1.05)
        score += max(0, 1.0 - lwDeviation * 5) * 40  // 0-40分

        // 下颌圆润（jawAngle > 130°）
        if m.jawAngle > 130 {
            score += min((m.jawAngle - 130) / 20, 1.0) * 30  // 0-30分
        }

        // 下巴不尖
        score += (1.0 - m.chinSharpness) * 20  // 0-20分

        // 额头和下颌宽度接近
        let fjDeviation = abs(m.foreheadToJawRatio - 1.0)
        score += max(0, 1.0 - fjDeviation * 3) * 10  // 0-10分

        return score
    }

    /// 方脸：脸长宽比 ≈ 1.0，下颌方正
    private func scoreSquare(_ m: FaceMetrics) -> Float {
        var score: Float = 0

        // 长宽比接近1.0-1.2
        let lwDeviation = abs(m.lengthToWidthRatio - 1.1)
        score += max(0, 1.0 - lwDeviation * 4) * 30

        // 下颌方正（jawAngle < 125°）
        if m.jawAngle < 125 {
            score += min((125 - m.jawAngle) / 25, 1.0) * 35
        }

        // 额头、颧骨、下颌宽度接近
        let uniformity = 1.0 - (abs(m.foreheadToJawRatio - 1.0) + abs(m.cheekboneToJawRatio - 1.0)) / 2
        score += max(0, uniformity) * 25

        // 下巴不尖
        score += (1.0 - m.chinSharpness) * 10

        return score
    }

    /// 长脸：脸长宽比 > 1.4
    private func scoreOblong(_ m: FaceMetrics) -> Float {
        var score: Float = 0

        // 长宽比 > 1.4（越高越高分）
        if m.lengthToWidthRatio > 1.3 {
            score += min((m.lengthToWidthRatio - 1.3) / 0.3, 1.0) * 50
        }

        // 额头、颧骨、下颌宽度比较均匀
        let uniformity = 1.0 - (abs(m.foreheadToJawRatio - 1.0) + abs(m.cheekboneToJawRatio - 1.0)) / 2
        score += max(0, uniformity) * 30

        // 中庭或下庭偏长
        let verticalStretch = max(m.middleThirdRatio, m.lowerThirdRatio)
        if verticalStretch > 0.35 {
            score += min((verticalStretch - 0.35) / 0.1, 1.0) * 20
        }

        return score
    }

    /// 心形脸：额头宽 > 下颌宽，下巴尖
    private func scoreHeart(_ m: FaceMetrics) -> Float {
        var score: Float = 0

        // 额头比下颌宽
        if m.foreheadToJawRatio > 1.1 {
            score += min((m.foreheadToJawRatio - 1.1) / 0.3, 1.0) * 35
        }

        // 下巴尖
        score += m.chinSharpness * 35

        // 长宽比中等（1.1-1.4）
        let lwCenter = abs(m.lengthToWidthRatio - 1.25)
        score += max(0, 1.0 - lwCenter * 3) * 20

        // 颧骨较宽
        if m.cheekboneToForeheadRatio > 0.95 {
            score += 10
        }

        return score
    }

    /// 菱形脸：颧骨宽 > 额头宽 && 颧骨宽 > 下颌宽
    private func scoreDiamond(_ m: FaceMetrics) -> Float {
        var score: Float = 0

        // 颧骨比额头宽
        if m.cheekboneToForeheadRatio > 1.05 {
            score += min((m.cheekboneToForeheadRatio - 1.05) / 0.2, 1.0) * 35
        }

        // 颧骨比下颌宽
        if m.cheekboneToJawRatio > 1.1 {
            score += min((m.cheekboneToJawRatio - 1.1) / 0.3, 1.0) * 35
        }

        // 额头较窄（相对颧骨）
        if m.foreheadToJawRatio < 1.1 && m.cheekboneToJawRatio > 1.1 {
            score += 20
        }

        // 下巴偏尖
        score += m.chinSharpness * 10

        return score
    }

    /// 梨形脸：下颌宽 > 额头宽
    private func scorePear(_ m: FaceMetrics) -> Float {
        var score: Float = 0

        // 下颌比额头宽
        if m.foreheadToJawRatio < 0.9 {
            score += min((0.9 - m.foreheadToJawRatio) / 0.2, 1.0) * 45
        }

        // 下颌比颧骨宽
        if m.cheekboneToJawRatio < 0.95 {
            score += min((0.95 - m.cheekboneToJawRatio) / 0.15, 1.0) * 30
        }

        // 长宽比中等
        let lwCenter = abs(m.lengthToWidthRatio - 1.2)
        score += max(0, 1.0 - lwCenter * 3) * 15

        // 下颌圆润到中等
        if m.jawAngle > 110 {
            score += 10
        }

        return score
    }

    /// 椭圆脸（鹅蛋脸）：比例均衡，作为"默认/理想"
    private func scoreOval(_ m: FaceMetrics) -> Float {
        var score: Float = 0

        // 长宽比 ≈ 1.3 (理想值)
        let lwDeviation = abs(m.lengthToWidthRatio - 1.3)
        score += max(0, 1.0 - lwDeviation * 4) * 25

        // 额头略窄于颧骨
        let fhDeviation = abs(m.cheekboneToForeheadRatio - 1.05)
        score += max(0, 1.0 - fhDeviation * 5) * 15

        // 下颌略窄于颧骨
        let jwDeviation = abs(m.cheekboneToJawRatio - 1.15)
        score += max(0, 1.0 - jwDeviation * 4) * 15

        // 三庭均匀（各≈0.333）
        let thirdDeviation = abs(m.upperThirdRatio - 0.333)
            + abs(m.middleThirdRatio - 0.333)
            + abs(m.lowerThirdRatio - 0.333)
        score += max(0, 1.0 - thirdDeviation * 3) * 25

        // 下巴中等尖锐度
        let chinDeviation = abs(m.chinSharpness - 0.5)
        score += max(0, 1.0 - chinDeviation * 2) * 10

        // 下颌角中等
        let jawDeviation = abs(m.jawAngle - 130)
        score += max(0, 1.0 - jawDeviation / 20) * 10

        return score
    }
}
