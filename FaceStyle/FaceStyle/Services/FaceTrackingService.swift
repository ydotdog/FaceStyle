import Foundation
import ARKit
import Combine

/// 面部追踪状态
enum TrackingState: Equatable {
    case notStarted
    case initializing
    case tracking
    case faceNotFound
    case deviceNotSupported
    case cameraAccessDenied

    var statusMessage: String {
        switch self {
        case .notStarted:
            return String(localized: "tracking.notStarted", defaultValue: "Ready to scan")
        case .initializing:
            return String(localized: "tracking.initializing", defaultValue: "Initializing camera...")
        case .tracking:
            return String(localized: "tracking.tracking", defaultValue: "Face detected")
        case .faceNotFound:
            return String(localized: "tracking.faceNotFound", defaultValue: "No face detected")
        case .deviceNotSupported:
            return String(localized: "tracking.notSupported", defaultValue: "TrueDepth camera not available")
        case .cameraAccessDenied:
            return String(localized: "tracking.denied", defaultValue: "Camera access denied")
        }
    }
}

/// 拍摄引导状态
struct CaptureGuidance: Equatable {
    var isPoseGood: Bool = false       // 正面朝向
    var isDistanceGood: Bool = false   // 距离合适
    var isLightingGood: Bool = false   // 光照充足
    var yaw: Float = 0                 // 偏航角（度）
    var pitch: Float = 0               // 俯仰角（度）
    var roll: Float = 0                // 翻滚角（度）
    var distance: Float = 0            // 距离（米）
    var lightIntensity: Float = 0      // 光照强度

    /// 所有条件都满足
    var isReadyToCapture: Bool {
        isPoseGood && isDistanceGood && isLightingGood
    }

    var guidanceMessages: [String] {
        var messages: [String] = []
        if !isPoseGood {
            messages.append(String(localized: "guidance.lookStraight", defaultValue: "Please look straight at the camera"))
        }
        if !isDistanceGood {
            if distance < 0.25 {
                messages.append(String(localized: "guidance.tooClose", defaultValue: "Move further from the camera"))
            } else {
                messages.append(String(localized: "guidance.tooFar", defaultValue: "Move closer to the camera"))
            }
        }
        if !isLightingGood {
            messages.append(String(localized: "guidance.moreLighting", defaultValue: "Need better lighting"))
        }
        return messages
    }
}

// MARK: - ARKit Face Mesh 关键顶点索引
// 这些索引需要实际调试确认，以下为基于 ARKit 1220 顶点网格的近似索引
enum FaceMeshVertexIndex {
    // 基于 ARKit Face Mesh OBJ 实测数据分析确定的顶点索引
    // 坐标系：X右正/左负, Y上正/下负, Z面部朝外为负
    static let chin = 1047                  // 下巴最低点 (y=-0.083, 正中央)
    static let foreheadTop = 20             // 额头最高可见点 (y=0.089, 正中央)
    static let cheekboneLeft = 467          // 左颧骨最宽点 (x=-0.078, y=0.022)
    static let cheekboneRight = 888         // 右颧骨最宽点 (x=0.077, y=0.022)
    static let jawAngleLeft = 930           // 左下颌角 (x=-0.073, y=-0.023)
    static let jawAngleRight = 1001         // 右下颌角 (x=0.073, y=-0.023)
    static let templeLeft = 130             // 左太阳穴 (x=-0.077, y=0.045)
    static let templeRight = 579            // 右太阳穴 (x=0.077, y=0.045)
    static let noseTip = 9                  // 鼻尖 (z=-0.061, Apple文档参考点)
    static let outerEyeLeft = 1102          // 左外眼角/外眦 (x=-0.044, y=0.024)
    static let outerEyeRight = 1070         // 右外眼角/外眦 (x=0.044, y=0.024)
    static let browCenter = 16              // 眉心 (x≈0, y=0.034, 最前突)
    static let noseBase = 37                // 鼻底/鼻下点 (x≈0, y=-0.015)

    // 下颌轮廓点序列（左下颌角 → 下巴 → 右下颌角）
    // 基于 OBJ 分析的实际轮廓路径
    static let jawContourIndices: [Int] = [
        930, 905, 462, 921, 919, 917, 915, 914,
        1047,
        913, 912, 910, 908, 906, 1005, 1215, 1001
    ]
}

/// ARKit 面部追踪服务
@MainActor
final class FaceTrackingService: NSObject, ObservableObject {
    // MARK: - Published Properties

    @Published var trackingState: TrackingState = .notStarted
    @Published var guidance: CaptureGuidance = CaptureGuidance()
    @Published var lastScanData: FaceScanData?

    // MARK: - Private Properties

    /// ARSession 可以由外部 ARSCNView 提供，也可以内部创建
    private(set) var arSession: ARSession?
    private var currentFaceAnchor: ARFaceAnchor?
    private var ownsSession = false

    // MARK: - Device Support

    static var isSupported: Bool {
        ARFaceTrackingConfiguration.isSupported
    }

    // MARK: - Session Management

    /// 使用外部 ARSession（来自 ARSCNView）
    func startSession(with session: ARSession) {
        guard FaceTrackingService.isSupported else {
            trackingState = .deviceNotSupported
            return
        }

        session.delegate = self
        self.arSession = session
        self.ownsSession = false

        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = true
        config.maximumNumberOfTrackedFaces = 1

        trackingState = .initializing
        session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }

    /// 创建独立 ARSession（无预览时使用）
    func startSession() {
        guard FaceTrackingService.isSupported else {
            trackingState = .deviceNotSupported
            return
        }

        let session = ARSession()
        session.delegate = self
        self.arSession = session
        self.ownsSession = true

        let config = ARFaceTrackingConfiguration()
        config.isLightEstimationEnabled = true
        config.maximumNumberOfTrackedFaces = 1

        trackingState = .initializing
        session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }

    func pauseSession() {
        arSession?.pause()
    }

    func stopSession() {
        arSession?.pause()
        if ownsSession {
            arSession = nil
        } else {
            arSession?.delegate = nil
        }
        trackingState = .notStarted
        currentFaceAnchor = nil
    }

    // MARK: - Data Capture

    /// 捕获当前帧的面部数据
    func captureFaceData() -> FaceScanData? {
        guard let anchor = currentFaceAnchor else { return nil }
        guard guidance.isReadyToCapture else { return nil }

        let geometry = anchor.geometry
        let vertices = extractAllVertices(from: geometry)
        let landmarks = extractLandmarks(from: vertices)

        let scanData = FaceScanData(
            landmarks: landmarks,
            allVertices: vertices,
            faceDistance: guidance.distance,
            ambientLightIntensity: guidance.lightIntensity
        )

        lastScanData = scanData
        return scanData
    }

    // MARK: - Vertex Extraction

    private func extractAllVertices(from geometry: ARFaceGeometry) -> [SIMD3<Float>] {
        let vertexBuffer = geometry.vertices
        let vertexCount = geometry.vertices.count
        var vertices: [SIMD3<Float>] = []
        vertices.reserveCapacity(vertexCount)

        for i in 0..<vertexCount {
            vertices.append(vertexBuffer[i])
        }
        return vertices
    }

    private func extractLandmarks(from vertices: [SIMD3<Float>]) -> FaceLandmarks {
        func safeVertex(_ index: Int) -> SIMD3<Float> {
            guard index >= 0 && index < vertices.count else {
                return SIMD3<Float>(0, 0, 0)
            }
            return vertices[index]
        }

        let jawContour = FaceMeshVertexIndex.jawContourIndices.map { safeVertex($0) }

        return FaceLandmarks(
            chin: safeVertex(FaceMeshVertexIndex.chin),
            foreheadTop: safeVertex(FaceMeshVertexIndex.foreheadTop),
            cheekboneLeft: safeVertex(FaceMeshVertexIndex.cheekboneLeft),
            cheekboneRight: safeVertex(FaceMeshVertexIndex.cheekboneRight),
            jawAngleLeft: safeVertex(FaceMeshVertexIndex.jawAngleLeft),
            jawAngleRight: safeVertex(FaceMeshVertexIndex.jawAngleRight),
            templeLeft: safeVertex(FaceMeshVertexIndex.templeLeft),
            templeRight: safeVertex(FaceMeshVertexIndex.templeRight),
            noseTip: safeVertex(FaceMeshVertexIndex.noseTip),
            outerEyeLeft: safeVertex(FaceMeshVertexIndex.outerEyeLeft),
            outerEyeRight: safeVertex(FaceMeshVertexIndex.outerEyeRight),
            browCenter: safeVertex(FaceMeshVertexIndex.browCenter),
            noseBase: safeVertex(FaceMeshVertexIndex.noseBase),
            jawContour: jawContour
        )
    }

    // MARK: - Guidance Analysis

    private func updateGuidance(from anchor: ARFaceAnchor, frame: ARFrame?) {
        let transform = anchor.transform

        // 提取欧拉角（弧度→度数）
        let yaw = atan2(transform.columns.0.z, transform.columns.2.z) * 180 / .pi
        let pitch = asin(-transform.columns.1.z) * 180 / .pi
        let roll = atan2(transform.columns.1.x, transform.columns.1.y) * 180 / .pi

        // 计算人脸距离（取 transform 的平移分量）
        let position = SIMD3<Float>(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
        let distance = simd_length(position)

        // 光照估计
        let lightIntensity = frame?.lightEstimate?.ambientIntensity ?? 0

        guidance.yaw = yaw
        guidance.pitch = pitch
        guidance.roll = roll
        guidance.distance = distance
        guidance.lightIntensity = Float(lightIntensity)

        // 姿态检查：yaw/pitch/roll 均 < 10°
        guidance.isPoseGood = abs(yaw) < 10 && abs(pitch) < 10 && abs(roll) < 10

        // 距离检查：25-50cm
        guidance.isDistanceGood = distance >= 0.25 && distance <= 0.50

        // 光照检查：>300 lumen 算合格
        guidance.isLightingGood = lightIntensity > 300
    }
}

// MARK: - ARSessionDelegate

extension FaceTrackingService: ARSessionDelegate {
    nonisolated func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        Task { @MainActor in
            for anchor in anchors {
                if let faceAnchor = anchor as? ARFaceAnchor {
                    currentFaceAnchor = faceAnchor
                    trackingState = .tracking
                    updateGuidance(from: faceAnchor, frame: session.currentFrame)
                }
            }
        }
    }

    nonisolated func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        Task { @MainActor in
            for anchor in anchors {
                if anchor is ARFaceAnchor {
                    trackingState = .tracking
                }
            }
        }
    }

    nonisolated func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        Task { @MainActor in
            for anchor in anchors {
                if anchor is ARFaceAnchor {
                    trackingState = .faceNotFound
                    currentFaceAnchor = nil
                }
            }
        }
    }

    nonisolated func session(_ session: ARSession, didFailWithError error: Error) {
        Task { @MainActor in
            if let arError = error as? ARError {
                switch arError.code {
                case .cameraUnauthorized:
                    trackingState = .cameraAccessDenied
                default:
                    trackingState = .faceNotFound
                }
            }
        }
    }
}
