import SwiftUI

/// 发型推荐列表页
struct RecommendationListView: View {
    let recommendations: [HairstyleRecommendation]
    let faceShapeResult: FaceShapeResult

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 顶部概要
                headerSection

                // 推荐卡片列表
                ForEach(recommendations) { rec in
                    NavigationLink {
                        RecommendationDetailView(recommendation: rec, faceShapeResult: faceShapeResult)
                    } label: {
                        HairstyleCard(recommendation: rec)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .navigationTitle(String(localized: "recommendations.title", defaultValue: "Recommended Hairstyles"))
        .navigationBarTitleDisplayMode(.large)
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: faceShapeResult.primaryShape.icon)
                    .foregroundStyle(Color.accentColor)
                Text(faceShapeResult.fullDescription)
                    .font(.headline)
            }

            Text(String(localized: "recommendations.subtitle",
                       defaultValue: "Top \(recommendations.count) hairstyles tailored for your face shape"))
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.bottom, 8)
    }
}

#Preview {
    NavigationStack {
        RecommendationListView(
            recommendations: [],
            faceShapeResult: FaceShapeResult(
                primaryShape: .oval,
                confidence: 0.85,
                secondaryShape: nil,
                characteristics: [],
                allScores: [:]
            )
        )
    }
}
