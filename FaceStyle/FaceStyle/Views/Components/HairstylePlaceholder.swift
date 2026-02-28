import SwiftUI

/// 根据发型特征生成有区分度的占位图
/// 在实际参考图片到位之前，用图标+颜色组合让每个发型卡片视觉上可区分
struct HairstylePlaceholder: View {
    let hairstyle: Hairstyle
    let size: PlaceholderSize

    enum PlaceholderSize {
        case small   // 卡片列表中 60x72
        case medium  // 详情页头部
        case large   // 全屏预览

        var width: CGFloat {
            switch self {
            case .small: return 60
            case .medium: return 160
            case .large: return 280
            }
        }

        var height: CGFloat {
            switch self {
            case .small: return 72
            case .medium: return 200
            case .large: return 320
            }
        }

        var iconFont: Font {
            switch self {
            case .small: return .title3
            case .medium: return .system(size: 48)
            case .large: return .system(size: 64)
            }
        }

        var labelFont: Font {
            switch self {
            case .small: return .system(size: 7)
            case .medium: return .caption
            case .large: return .callout
            }
        }
    }

    var body: some View {
        RoundedRectangle(cornerRadius: size == .small ? 10 : 20)
            .fill(backgroundColor.gradient)
            .frame(width: size.width, height: size.height)
            .overlay {
                VStack(spacing: size == .small ? 2 : 8) {
                    Image(systemName: iconName)
                        .font(size.iconFont)
                        .foregroundStyle(.white.opacity(0.8))

                    if size != .small {
                        // 长度标签
                        Text(hairstyle.lengthCategory.displayName)
                            .font(size.labelFont)
                            .foregroundStyle(.white.opacity(0.6))
                    }
                }
            }
    }

    // MARK: - 根据风格选择图标

    private var iconName: String {
        let categories = hairstyle.styleCategories

        if categories.contains(.updo) {
            return "crown"
        } else if categories.contains(.braided) {
            return "link"
        } else if categories.contains(.curly) {
            return "wave.3.right"
        } else if categories.contains(.wavy) {
            return "water.waves"
        } else if categories.contains(.bangs) {
            return "eyebrow"
        } else if categories.contains(.layered) {
            return "square.3.layers.3d"
        } else if categories.contains(.textured) {
            return "paintbrush"
        } else {
            // 直发 or default
            return "line.3.horizontal.decrease"
        }
    }

    // MARK: - 根据长度和性别选择背景色

    private var backgroundColor: Color {
        let hue: Double
        switch hairstyle.lengthCategory {
        case .buzz:   hue = 0.58  // 蓝
        case .short:  hue = 0.45  // 青
        case .medium: hue = 0.82  // 紫
        case .long:   hue = 0.92  // 粉
        }

        let saturation: Double = hairstyle.gender == .male ? 0.35 : 0.45
        let brightness: Double = 0.65

        return Color(hue: hue, saturation: saturation, brightness: brightness)
    }
}
