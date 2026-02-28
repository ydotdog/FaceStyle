import SwiftUI

/// 发型推荐卡片
struct HairstyleCard: View {
    let recommendation: HairstyleRecommendation

    var body: some View {
        HStack(spacing: 16) {
            // 排名标识
            rankBadge

            // 占位图片
            placeholderImage

            // 文字信息
            VStack(alignment: .leading, spacing: 6) {
                Text(recommendation.hairstyle.name)
                    .font(.subheadline.bold())
                    .lineLimit(1)

                // 匹配分
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundStyle(.orange)
                    Text(String(format: "%.0f", recommendation.matchScore))
                        .font(.caption.bold())
                        .foregroundStyle(Color.accentColor)
                    Text(String(localized: "card.matchScore", defaultValue: "match"))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                // 首条推荐理由
                if let firstReason = recommendation.reasons.first ?? recommendation.hairstyle.keyBenefits.first {
                    Text(firstReason)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }

                // 风格标签
                HStack(spacing: 4) {
                    Text(recommendation.hairstyle.lengthCategory.displayName)
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(.secondary.opacity(0.1))
                        .clipShape(Capsule())

                    ForEach(recommendation.hairstyle.styleCategories.prefix(2), id: \.self) { style in
                        Text(style.displayName)
                            .font(.caption2)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(.secondary.opacity(0.1))
                            .clipShape(Capsule())
                    }
                }
                .foregroundStyle(.secondary)
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Rank Badge

    private var rankBadge: some View {
        ZStack {
            Circle()
                .fill(rankColor.opacity(0.15))
                .frame(width: 36, height: 36)
            Text("#\(recommendation.rank)")
                .font(.caption.bold())
                .foregroundStyle(rankColor)
        }
    }

    private var rankColor: Color {
        switch recommendation.rank {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return Color.accentColor
        }
    }

    // MARK: - Placeholder Image

    private var placeholderImage: some View {
        HairstylePlaceholder(hairstyle: recommendation.hairstyle, size: .small)
    }
}
