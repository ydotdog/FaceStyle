import SwiftUI
import ARKit
import SceneKit

/// 相机页面：ARKit 面部追踪 + 拍摄引导
struct CameraView: View {
    let selectedGender: Gender

    @StateObject private var trackingService = FaceTrackingService()
    @StateObject private var permissionManager = CameraPermissionManager()
    @State private var isCapturing = false
    @State private var navigateToResult = false
    @State private var scanResult: ScanResultData?
    @State private var showCaptureError = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Group {
                if permissionManager.isAuthorized {
                    cameraContent
                } else if permissionManager.isDenied {
                    permissionDeniedView
                } else {
                    permissionRequestView
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        trackingService.stopSession()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(permissionManager.isAuthorized ? .white : .primary)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onDisappear {
                trackingService.pauseSession()
            }
            .navigationDestination(isPresented: $navigateToResult) {
                if let result = scanResult {
                    AnalysisResultView(resultData: result)
                }
            }
            .alert(
                String(localized: "camera.captureError", defaultValue: "Capture Failed"),
                isPresented: $showCaptureError
            ) {
                Button("OK") {}
            } message: {
                Text(String(localized: "camera.captureErrorDesc",
                           defaultValue: "Could not capture face data. Please ensure your face is properly positioned and try again."))
            }
            .task {
                if permissionManager.isNotDetermined {
                    await permissionManager.requestPermission()
                }
            }
        }
    }

    // MARK: - Camera Content

    private var cameraContent: some View {
        ZStack {
            ARViewContainer(trackingService: trackingService)
                .ignoresSafeArea()
            VStack {
                topStatusBar
                Spacer()
                bottomControls
            }
        }
    }

    // MARK: - Permission Views

    private var permissionRequestView: some View {
        VStack(spacing: 20) {
            Image(systemName: "camera")
                .font(.system(size: 56))
                .foregroundStyle(.secondary)
            Text(String(localized: "camera.permissionNeeded",
                       defaultValue: "Camera access needed for face scanning"))
                .font(.headline)
                .multilineTextAlignment(.center)
            ProgressView()
        }
        .padding()
    }

    private var permissionDeniedView: some View {
        VStack(spacing: 20) {
            Image(systemName: "camera.fill")
                .font(.system(size: 56))
                .foregroundStyle(.red.opacity(0.6))
            Text(String(localized: "camera.permissionDenied",
                       defaultValue: "Camera access was denied"))
                .font(.headline)
            Text(String(localized: "camera.permissionDeniedDesc",
                       defaultValue: "Please enable camera access in Settings to use face scanning."))
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Button {
                permissionManager.openSettings()
            } label: {
                Text(String(localized: "camera.openSettings", defaultValue: "Open Settings"))
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
        }
        .padding()
    }

    // MARK: - Top Status Bar

    private var topStatusBar: some View {
        HStack {
            // 追踪状态指示灯
            HStack(spacing: 8) {
                Circle()
                    .fill(statusColor)
                    .frame(width: 10, height: 10)
                Text(trackingService.trackingState.statusMessage)
                    .font(.caption)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
        }
        .padding(.top, 8)
    }

    private var statusColor: Color {
        switch trackingService.trackingState {
        case .tracking:
            return trackingService.guidance.isReadyToCapture ? .green : .yellow
        case .faceNotFound:
            return .red
        default:
            return .gray
        }
    }

    // MARK: - Bottom Controls

    private var bottomControls: some View {
        VStack(spacing: 16) {
            // 引导消息
            if !trackingService.guidance.guidanceMessages.isEmpty {
                VStack(spacing: 6) {
                    ForEach(trackingService.guidance.guidanceMessages, id: \.self) { msg in
                        Text(msg)
                            .font(.callout.bold())
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            // 引导指标
            guidanceIndicators

            // 拍摄按钮
            captureButton
                .padding(.bottom, 24)
        }
        .padding(.horizontal, 24)
    }

    // MARK: - Guidance Indicators

    private var guidanceIndicators: some View {
        HStack(spacing: 20) {
            GuidanceIndicator(
                icon: "face.smiling",
                label: String(localized: "camera.pose", defaultValue: "Pose"),
                isGood: trackingService.guidance.isPoseGood
            )
            GuidanceIndicator(
                icon: "ruler",
                label: String(localized: "camera.distance", defaultValue: "Distance"),
                isGood: trackingService.guidance.isDistanceGood
            )
            GuidanceIndicator(
                icon: "sun.max",
                label: String(localized: "camera.lighting", defaultValue: "Lighting"),
                isGood: trackingService.guidance.isLightingGood
            )
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - Capture Button

    private var captureButton: some View {
        Button {
            performCapture()
        } label: {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: 72, height: 72)
                Circle()
                    .stroke(.white, lineWidth: 4)
                    .frame(width: 82, height: 82)

                if isCapturing {
                    ProgressView()
                        .tint(Color.accentColor)
                }
            }
        }
        .disabled(!trackingService.guidance.isReadyToCapture || isCapturing)
        .opacity(trackingService.guidance.isReadyToCapture ? 1 : 0.5)
    }

    // MARK: - Capture

    private func performCapture() {
        isCapturing = true

        // 短暂延迟确保最佳帧
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            guard let scanData = trackingService.captureFaceData() else {
                isCapturing = false
                showCaptureError = true
                return
            }

            // 分析
            let analysisService = FaceAnalysisService()
            let metrics = analysisService.analyze(scanData: scanData)

            let classifier = FaceShapeClassifier()
            let shapeResult = classifier.classify(metrics: metrics)

            let engine = HairstyleRecommendationEngine()
            let recommendations = engine.recommend(
                faceResult: shapeResult,
                metrics: metrics,
                gender: selectedGender
            )

            scanResult = ScanResultData(
                metrics: metrics,
                shapeResult: shapeResult,
                recommendations: recommendations,
                gender: selectedGender
            )

            trackingService.stopSession()
            isCapturing = false
            navigateToResult = true
        }
    }
}

/// 扫描结果封装
struct ScanResultData {
    let metrics: FaceMetrics
    let shapeResult: FaceShapeResult
    let recommendations: [HairstyleRecommendation]
    let gender: Gender
}

/// 引导指标小组件
private struct GuidanceIndicator: View {
    let icon: String
    let label: String
    let isGood: Bool

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(isGood ? .green : .orange)
            Text(label)
                .font(.caption2)
                .foregroundStyle(.white)
        }
    }
}

/// ARKit 视图容器 — 显示前置摄像头画面
struct ARViewContainer: UIViewRepresentable {
    let trackingService: FaceTrackingService

    func makeUIView(context: Context) -> ARSCNView {
        let scnView = ARSCNView()
        scnView.automaticallyUpdatesLighting = true
        scnView.rendersContinuously = true
        scnView.scene = SCNScene()
        // 使用 ARSCNView 自带的 session，传给 trackingService
        trackingService.startSession(with: scnView.session)
        return scnView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {}
}

#Preview {
    CameraView(selectedGender: .female)
}
