import SwiftUI

/// 发型详情页
struct RecommendationDetailView: View {
    let recommendation: HairstyleRecommendation
    let faceShapeResult: FaceShapeResult

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // MARK: - 发型大图
                heroImage

                // MARK: - 基本信息
                basicInfo

                // MARK: - 匹配分析
                matchAnalysis

                // MARK: - 为什么适合你
                whySuitable

                // MARK: - 发型信息
                hairstyleInfo
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .navigationTitle(recommendation.hairstyle.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Hero Image

    private var heroImage: some View {
        VStack(spacing: 8) {
            HairstylePlaceholder(hairstyle: recommendation.hairstyle, size: .large)

            Text(String(localized: "detail.placeholderImage",
                       defaultValue: "Reference photo coming soon"))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Basic Info

    private var basicInfo: some View {
        VStack(spacing: 12) {
            // 排名和匹配分
            HStack {
                Label {
                    Text("#\(recommendation.rank)")
                        .font(.headline)
                } icon: {
                    Image(systemName: "trophy.fill")
                        .foregroundStyle(rankColor)
                }

                Spacer()

                matchScoreBadge
            }

            Text(recommendation.hairstyle.description)
                .font(.body)
                .foregroundStyle(.secondary)
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

    private var matchScoreBadge: some View {
        HStack(spacing: 4) {
            Image(systemName: "star.fill")
                .font(.caption)
            Text(String(format: "%.0f", recommendation.matchScore))
                .font(.headline)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.accentColor.opacity(0.12))
        .foregroundStyle(Color.accentColor)
        .clipShape(Capsule())
    }

    // MARK: - Match Analysis

    private var matchAnalysis: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "detail.matchAnalysis", defaultValue: "Match Analysis"))
                .font(.headline)

            // 适合的脸型标签
            VStack(alignment: .leading, spacing: 8) {
                Text(String(localized: "detail.suitableFor", defaultValue: "Suitable for:"))
                    .font(.caption)
                    .foregroundStyle(.secondary)

                FlowLayout(spacing: 6) {
                    ForEach(recommendation.hairstyle.suitableFaceShapes) { shape in
                        FaceShapeTag(
                            shape: shape,
                            isHighlighted: shape == faceShapeResult.primaryShape
                        )
                    }
                }
            }
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Why Suitable

    private var whySuitable: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "detail.whySuitable", defaultValue: "Why It Suits You"))
                .font(.headline)

            ForEach(recommendation.reasons, id: \.self) { reason in
                HStack(alignment: .top, spacing: 12) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                        .font(.callout)
                    Text(reason)
                        .font(.callout)
                }
            }

            if recommendation.reasons.isEmpty {
                ForEach(recommendation.hairstyle.keyBenefits, id: \.self) { benefit in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                            .font(.callout)
                        Text(benefit)
                            .font(.callout)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Hairstyle Info

    private var hairstyleInfo: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(String(localized: "detail.info", defaultValue: "Hairstyle Info"))
                .font(.headline)

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                infoCell(
                    icon: "scissors",
                    title: String(localized: "detail.length", defaultValue: "Length"),
                    value: recommendation.hairstyle.lengthCategory.displayName
                )
                infoCell(
                    icon: "wind",
                    title: String(localized: "detail.style", defaultValue: "Style"),
                    value: recommendation.hairstyle.styleCategories
                        .map(\.displayName)
                        .joined(separator: ", ")
                )
                infoCell(
                    icon: "clock",
                    title: String(localized: "detail.maintenance", defaultValue: "Maintenance"),
                    value: maintenanceText
                )
                infoCell(
                    icon: "briefcase",
                    title: String(localized: "detail.occasions", defaultValue: "Occasions"),
                    value: recommendation.hairstyle.occasions.joined(separator: ", ")
                )
            }
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var maintenanceText: String {
        let level = recommendation.hairstyle.maintenanceLevel
        let stars = String(repeating: "★", count: level) + String(repeating: "☆", count: 5 - level)
        return stars
    }

    private func infoCell(icon: String, title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.caption)
                    .foregroundStyle(Color.accentColor)
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Text(value)
                .font(.callout)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Face Shape Tag

private struct FaceShapeTag: View {
    let shape: FaceShape
    let isHighlighted: Bool

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: shape.icon)
                .font(.caption2)
            Text(shape.displayName)
                .font(.caption)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(isHighlighted ? Color.accentColor.opacity(0.15) : Color.secondary.opacity(0.1))
        .foregroundStyle(isHighlighted ? Color.accentColor : .secondary)
        .clipShape(Capsule())
    }
}
