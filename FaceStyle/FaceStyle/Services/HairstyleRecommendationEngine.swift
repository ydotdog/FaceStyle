import Foundation

/// 发型推荐引擎
/// 输入脸型分类结果和面部比例数据，输出 Top 5 发型推荐
struct HairstyleRecommendationEngine {

    /// 生成 Top N 发型推荐
    func recommend(
        faceResult: FaceShapeResult,
        metrics: FaceMetrics,
        gender: Gender,
        topN: Int = 5
    ) -> [HairstyleRecommendation] {
        // 获取该性别的所有发型
        let candidates = HairstyleDatabase.hairstyles(for: gender)

        // 为每个发型打分
        var scored: [(hairstyle: Hairstyle, score: Float, reasons: [String])] = []

        for hairstyle in candidates {
            let (score, reasons) = calculateScore(
                hairstyle: hairstyle,
                faceResult: faceResult,
                metrics: metrics
            )
            scored.append((hairstyle, score, reasons))
        }

        // 按分数降序排列
        scored.sort { $0.score > $1.score }

        // 取前 N 个
        let topResults = scored.prefix(topN)

        return topResults.enumerated().map { index, item in
            HairstyleRecommendation(
                hairstyle: item.hairstyle,
                matchScore: item.score,
                reasons: item.reasons,
                rank: index + 1
            )
        }
    }

    // MARK: - 评分逻辑

    private func calculateScore(
        hairstyle: Hairstyle,
        faceResult: FaceShapeResult,
        metrics: FaceMetrics
    ) -> (score: Float, reasons: [String]) {
        var score: Float = 0
        var reasons: [String] = []

        // MARK: 第一层 — 脸型匹配基础分 (0-50分)
        let shapeScore = calculateShapeMatchScore(hairstyle: hairstyle, faceResult: faceResult)
        score += shapeScore.score
        reasons.append(contentsOf: shapeScore.reasons)

        // MARK: 第二层 — 比例特征精细加分 (0-50分)
        let proportionScore = calculateProportionScore(hairstyle: hairstyle, metrics: metrics)
        score += proportionScore.score
        reasons.append(contentsOf: proportionScore.reasons)

        return (score: min(score, 100), reasons: reasons)
    }

    // MARK: - 脸型匹配分

    private func calculateShapeMatchScore(
        hairstyle: Hairstyle,
        faceResult: FaceShapeResult
    ) -> (score: Float, reasons: [String]) {
        var score: Float = 0
        var reasons: [String] = []

        // 主脸型匹配
        if hairstyle.suitableFaceShapes.contains(faceResult.primaryShape) {
            score += 40
            reasons.append(contentsOf: hairstyle.keyBenefits.prefix(2))
        }

        // 次要脸型也匹配，额外加分
        if let secondary = faceResult.secondaryShape,
           hairstyle.suitableFaceShapes.contains(secondary) {
            score += 10
        }

        return (score, reasons)
    }

    // MARK: - 比例特征精细打分

    private func calculateProportionScore(
        hairstyle: Hairstyle,
        metrics: FaceMetrics
    ) -> (score: Float, reasons: [String]) {
        var score: Float = 0
        var reasons: [String] = []

        // 额头偏高 → 有刘海的发型加分
        if metrics.upperThirdRatio > 0.37 {
            if hairstyle.styleCategories.contains(.bangs) {
                score += 15
                reasons.append(String(localized: "recommend.reason.bangsForHighForehead",
                                     defaultValue: "Bangs help balance a higher forehead"))
            }
        }

        // 额头偏低 → 没有刘海的发型加分，有刘海扣分
        if metrics.upperThirdRatio < 0.29 {
            if !hairstyle.styleCategories.contains(.bangs) {
                score += 8
            } else {
                score -= 5
            }
        }

        // 下颌偏宽 → 层次感发型加分（修饰下颌线条）
        if metrics.foreheadToJawRatio < 0.9 {
            if hairstyle.styleCategories.contains(.layered) {
                score += 12
                reasons.append(String(localized: "recommend.reason.layeredForWideJaw",
                                     defaultValue: "Layers soften a wider jawline"))
            }
            // 中长发也适合修饰下颌
            if hairstyle.lengthCategory == .medium || hairstyle.lengthCategory == .long {
                score += 5
            }
        }

        // 脸偏长（长宽比>1.35）→ 增加横向视觉宽度的发型加分
        if metrics.lengthToWidthRatio > 1.35 {
            // 卷发/波浪增加横向体积
            if hairstyle.styleCategories.contains(.curly) || hairstyle.styleCategories.contains(.wavy) {
                score += 12
                reasons.append(String(localized: "recommend.reason.volumeForLongFace",
                                     defaultValue: "Adds width to balance a longer face"))
            }
            // 短发/中短发减少纵向长度
            if hairstyle.lengthCategory == .short || hairstyle.lengthCategory == .medium {
                score += 5
            }
            // 刘海遮挡额头缩短视觉长度
            if hairstyle.styleCategories.contains(.bangs) {
                score += 8
                reasons.append(String(localized: "recommend.reason.bangsForLongFace",
                                     defaultValue: "Bangs shorten the visual length of the face"))
            }
        }

        // 脸偏圆（长宽比<1.15）→ 增加纵向长度感的发型加分
        if metrics.lengthToWidthRatio < 1.15 {
            // 直发增加纵向线条感
            if hairstyle.styleCategories.contains(.straight) {
                score += 8
            }
            // 长发拉长视觉效果
            if hairstyle.lengthCategory == .long {
                score += 8
                reasons.append(String(localized: "recommend.reason.longForRoundFace",
                                     defaultValue: "Longer length creates a slimming effect"))
            }
            // 头顶蓬松的发型加分（层次/纹理）
            if hairstyle.styleCategories.contains(.layered) || hairstyle.styleCategories.contains(.textured) {
                score += 5
            }
        }

        // 方脸（下颌角 < 120°）→ 柔化线条的发型加分
        if metrics.jawAngle < 120 {
            if hairstyle.styleCategories.contains(.wavy) || hairstyle.styleCategories.contains(.curly) {
                score += 10
                reasons.append(String(localized: "recommend.reason.softForSquareJaw",
                                     defaultValue: "Waves soften angular jaw features"))
            }
            if hairstyle.styleCategories.contains(.layered) {
                score += 8
            }
        }

        // 颧骨较突出（菱形脸特征）→ 在颧骨处增加体积的发型加分
        if metrics.cheekboneToForeheadRatio > 1.1 && metrics.cheekboneToJawRatio > 1.1 {
            if hairstyle.lengthCategory == .medium || hairstyle.lengthCategory == .long {
                score += 8
                reasons.append(String(localized: "recommend.reason.coverCheekbones",
                                     defaultValue: "Helps frame and soften prominent cheekbones"))
            }
        }

        // 下庭偏长 → 中长发和层次发型加分（视觉重心上移）
        if metrics.lowerThirdRatio > 0.37 {
            if hairstyle.styleCategories.contains(.layered) {
                score += 8
            }
            if hairstyle.lengthCategory == .medium {
                score += 5
            }
        }

        return (score, reasons)
    }
}
