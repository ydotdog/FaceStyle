import SwiftUI
import Charts

/// 面部分析报告页
struct AnalysisResultView: View {
    let resultData: ScanResultData

    @State private var showRecommendations = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // MARK: - 脸型分类结果
                faceShapeHeader

                // MARK: - 特征标签
                characteristicsTags

                // MARK: - 三庭比例图表
                threeThirdsChart

                // MARK: - 宽度比例对比
                widthComparisonChart

                // MARK: - 脸长宽比
                lengthWidthRatioSection

                // MARK: - 查看推荐按钮
                viewRecommendationsButton
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .navigationTitle(String(localized: "analysis.title", defaultValue: "Face Analysis"))
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(isPresented: $showRecommendations) {
            RecommendationListView(
                recommendations: resultData.recommendations,
                faceShapeResult: resultData.shapeResult
            )
        }
    }

    // MARK: - Face Shape Header

    private var faceShapeHeader: some View {
        VStack(spacing: 12) {
            Image(systemName: resultData.shapeResult.primaryShape.icon)
                .font(.system(size: 56))
                .foregroundStyle(Color.accentColor)

            Text(resultData.shapeResult.fullDescription)
                .font(.title.bold())

            Text("\(String(localized: "analysis.confidence", defaultValue: "Confidence:")) \(resultData.shapeResult.confidencePercent)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(resultData.shapeResult.primaryShape.summary)
                .font(.callout)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding(.vertical, 20)
    }

    // MARK: - Characteristics Tags

    private var characteristicsTags: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "analysis.features", defaultValue: "Features"))
                .font(.headline)

            FlowLayout(spacing: 8) {
                ForEach(resultData.shapeResult.characteristics, id: \.self) { char in
                    Text(char)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.accentColor.opacity(0.12))
                        .foregroundStyle(Color.accentColor)
                        .clipShape(Capsule())
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Three Thirds Chart

    private var threeThirdsChart: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "analysis.threeThirds", defaultValue: "Face Thirds"))
                .font(.headline)

            Chart {
                BarMark(
                    x: .value("Ratio", resultData.metrics.upperThirdRatio),
                    y: .value("Section", String(localized: "analysis.upperThird", defaultValue: "Upper"))
                )
                .foregroundStyle(.blue)

                BarMark(
                    x: .value("Ratio", resultData.metrics.middleThirdRatio),
                    y: .value("Section", String(localized: "analysis.middleThird", defaultValue: "Middle"))
                )
                .foregroundStyle(.green)

                BarMark(
                    x: .value("Ratio", resultData.metrics.lowerThirdRatio),
                    y: .value("Section", String(localized: "analysis.lowerThird", defaultValue: "Lower"))
                )
                .foregroundStyle(.orange)

                // 理想值参考线 1/3
                RuleMark(x: .value("Ideal", 0.333))
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5, 3]))
                    .foregroundStyle(.secondary)
                    .annotation(position: .top, alignment: .trailing) {
                        Text("1/3")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
            }
            .chartXScale(domain: 0...0.5)
            .chartXAxis {
                AxisMarks(values: [0, 0.1, 0.2, 0.3, 0.4, 0.5]) { value in
                    AxisValueLabel {
                        if let v = value.as(Double.self) {
                            Text("\(Int(v * 100))%")
                        }
                    }
                }
            }
            .frame(height: 160)
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Width Comparison Chart

    private var widthComparisonChart: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "analysis.widthComparison", defaultValue: "Width Comparison"))
                .font(.headline)

            let widthData: [(String, Float)] = [
                (String(localized: "analysis.forehead", defaultValue: "Forehead"),
                 resultData.metrics.foreheadWidth),
                (String(localized: "analysis.cheekbone", defaultValue: "Cheekbone"),
                 resultData.metrics.cheekboneWidth),
                (String(localized: "analysis.jaw", defaultValue: "Jaw"),
                 resultData.metrics.jawWidth)
            ]

            Chart {
                ForEach(widthData, id: \.0) { item in
                    BarMark(
                        x: .value("Width", item.1 * 100),  // cm
                        y: .value("Part", item.0)
                    )
                    .foregroundStyle(Color.accentColor)
                    .annotation(position: .trailing) {
                        Text(String(format: "%.1fcm", item.1 * 100))
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .frame(height: 140)
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Length-Width Ratio

    private var lengthWidthRatioSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(String(localized: "analysis.lengthWidthRatio", defaultValue: "Face Length-Width Ratio"))
                .font(.headline)

            HStack(spacing: 24) {
                // 数值展示
                VStack(spacing: 4) {
                    Text(String(format: "%.2f", resultData.metrics.lengthToWidthRatio))
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.accentColor)
                    Text(String(localized: "analysis.yourRatio", defaultValue: "Your Ratio"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                VStack(spacing: 4) {
                    Text("1.30")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(.secondary.opacity(0.5))
                    Text(String(localized: "analysis.idealRatio", defaultValue: "Ideal"))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                // 简图
                ratioVisual
            }
        }
        .padding(16)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var ratioVisual: some View {
        let ratio = resultData.metrics.lengthToWidthRatio
        let normalizedWidth: CGFloat = 50
        let normalizedHeight: CGFloat = CGFloat(ratio) * normalizedWidth

        return Ellipse()
            .stroke(Color.accentColor, lineWidth: 2)
            .frame(width: normalizedWidth, height: min(normalizedHeight, 80))
    }

    // MARK: - View Recommendations Button

    private var viewRecommendationsButton: some View {
        Button {
            showRecommendations = true
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "sparkles")
                    .font(.title3)
                Text(String(localized: "analysis.viewRecommendations",
                           defaultValue: "View Hairstyle Recommendations"))
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.accentColor)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding(.vertical, 8)
    }
}

// MARK: - Flow Layout (for tags)

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: proposal, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
                proposal: .unspecified
            )
        }
    }

    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> (positions: [CGPoint], size: CGSize) {
        let maxWidth = proposal.width ?? 300
        var positions: [CGPoint] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var maxHeight: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth && x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            positions.append(CGPoint(x: x, y: y))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
            maxHeight = max(maxHeight, y + rowHeight)
        }

        return (positions, CGSize(width: maxWidth, height: maxHeight))
    }
}
