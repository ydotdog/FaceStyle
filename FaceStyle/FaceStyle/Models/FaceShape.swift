import Foundation

/// 七种脸型分类
enum FaceShape: String, CaseIterable, Codable, Identifiable {
    case oval     // 椭圆脸（鹅蛋脸）
    case round    // 圆脸
    case square   // 方脸
    case heart    // 心形脸
    case oblong   // 长脸
    case diamond  // 菱形脸
    case pear     // 梨形脸

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .oval:    return String(localized: "faceShape.oval", defaultValue: "Oval")
        case .round:   return String(localized: "faceShape.round", defaultValue: "Round")
        case .square:  return String(localized: "faceShape.square", defaultValue: "Square")
        case .heart:   return String(localized: "faceShape.heart", defaultValue: "Heart")
        case .oblong:  return String(localized: "faceShape.oblong", defaultValue: "Oblong")
        case .diamond: return String(localized: "faceShape.diamond", defaultValue: "Diamond")
        case .pear:    return String(localized: "faceShape.pear", defaultValue: "Pear")
        }
    }

    var icon: String {
        switch self {
        case .oval:    return "oval.portrait"
        case .round:   return "circle"
        case .square:  return "square"
        case .heart:   return "heart"
        case .oblong:  return "rectangle.portrait"
        case .diamond: return "diamond"
        case .pear:    return "drop"
        }
    }

    /// 脸型简短描述
    var summary: String {
        switch self {
        case .oval:
            return String(localized: "faceShape.oval.summary",
                         defaultValue: "Balanced proportions with a slightly narrower forehead and jaw")
        case .round:
            return String(localized: "faceShape.round.summary",
                         defaultValue: "Similar width and length with soft, rounded jawline")
        case .square:
            return String(localized: "faceShape.square.summary",
                         defaultValue: "Strong jawline with similar width at forehead, cheekbones, and jaw")
        case .heart:
            return String(localized: "faceShape.heart.summary",
                         defaultValue: "Wider forehead tapering to a narrower, pointed chin")
        case .oblong:
            return String(localized: "faceShape.oblong.summary",
                         defaultValue: "Noticeably longer than wide with similar widths throughout")
        case .diamond:
            return String(localized: "faceShape.diamond.summary",
                         defaultValue: "Narrow forehead and jaw with wider cheekbones")
        case .pear:
            return String(localized: "faceShape.pear.summary",
                         defaultValue: "Wider jaw area tapering to a narrower forehead")
        }
    }
}

/// 发型长度
enum HairLength: String, CaseIterable, Codable {
    case buzz       // 寸头/极短
    case short      // 短发
    case medium     // 中长发
    case long       // 长发

    var displayName: String {
        switch self {
        case .buzz:   return String(localized: "hairLength.buzz", defaultValue: "Buzz")
        case .short:  return String(localized: "hairLength.short", defaultValue: "Short")
        case .medium: return String(localized: "hairLength.medium", defaultValue: "Medium")
        case .long:   return String(localized: "hairLength.long", defaultValue: "Long")
        }
    }
}

/// 发型风格
enum HairStyleCategory: String, CaseIterable, Codable {
    case straight   // 直发
    case curly      // 卷发
    case wavy       // 波浪
    case braided    // 编发
    case updo       // 盘发
    case layered    // 层次
    case bangs      // 刘海
    case textured   // 纹理

    var displayName: String {
        switch self {
        case .straight: return String(localized: "hairStyle.straight", defaultValue: "Straight")
        case .curly:    return String(localized: "hairStyle.curly", defaultValue: "Curly")
        case .wavy:     return String(localized: "hairStyle.wavy", defaultValue: "Wavy")
        case .braided:  return String(localized: "hairStyle.braided", defaultValue: "Braided")
        case .updo:     return String(localized: "hairStyle.updo", defaultValue: "Updo")
        case .layered:  return String(localized: "hairStyle.layered", defaultValue: "Layered")
        case .bangs:    return String(localized: "hairStyle.bangs", defaultValue: "Bangs")
        case .textured: return String(localized: "hairStyle.textured", defaultValue: "Textured")
        }
    }
}

/// 性别
enum Gender: String, CaseIterable, Codable {
    case male
    case female
    case unisex

    var displayName: String {
        switch self {
        case .male:   return String(localized: "gender.male", defaultValue: "Male")
        case .female: return String(localized: "gender.female", defaultValue: "Female")
        case .unisex: return String(localized: "gender.unisex", defaultValue: "Unisex")
        }
    }
}
