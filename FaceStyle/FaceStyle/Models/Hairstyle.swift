import Foundation

/// 发型数据模型
struct Hairstyle: Identifiable, Codable, Equatable {
    let id: String
    /// 发型名称
    let name: String
    /// 简要描述
    let description: String
    /// 适合的脸型列表
    let suitableFaceShapes: [FaceShape]
    /// 对特定脸型的好处/优势
    let keyBenefits: [String]
    /// 长度分类
    let lengthCategory: HairLength
    /// 风格分类
    let styleCategories: [HairStyleCategory]
    /// 参考图片资源名
    let referenceImageName: String
    /// 适合性别
    let gender: Gender
    /// 打理难度 1-5
    let maintenanceLevel: Int
    /// 适合场景标签
    let occasions: [String]

    static func == (lhs: Hairstyle, rhs: Hairstyle) -> Bool {
        lhs.id == rhs.id
    }
}

/// 发型推荐结果
struct HairstyleRecommendation: Identifiable, Equatable {
    var id: String { hairstyle.id }
    /// 推荐的发型
    let hairstyle: Hairstyle
    /// 匹配分数 (0-100)
    let matchScore: Float
    /// 推荐理由列表
    let reasons: [String]
    /// 排名
    let rank: Int

    static func == (lhs: HairstyleRecommendation, rhs: HairstyleRecommendation) -> Bool {
        lhs.id == rhs.id && lhs.rank == rhs.rank
    }
}
