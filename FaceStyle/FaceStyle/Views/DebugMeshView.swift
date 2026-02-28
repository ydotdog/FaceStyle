import SwiftUI
import ARKit
import SceneKit

/// 调试页面：实时显示 ARKit Face Mesh 并标注顶点编号
/// 用于确认关键测量点对应的正确顶点索引
struct DebugMeshView: View {
    @StateObject private var trackingService = FaceTrackingService()
    @State private var selectedVertexIndex: Int?
    @State private var vertexPositions: [Int: SIMD3<Float>] = [:]
    @State private var showAllVertices = false
    @State private var highlightKeyPoints = true
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                // AR 场景视图
                DebugARViewContainer(
                    trackingService: trackingService,
                    showAllVertices: showAllVertices,
                    highlightKeyPoints: highlightKeyPoints,
                    onVertexTapped: { index in
                        selectedVertexIndex = index
                    },
                    onVerticesUpdated: { positions in
                        vertexPositions = positions
                    }
                )
                .ignoresSafeArea()

                VStack {
                    Spacer()

                    // 选中的顶点信息
                    if let idx = selectedVertexIndex, let pos = vertexPositions[idx] {
                        vertexInfoPanel(index: idx, position: pos)
                    }

                    // 控制面板
                    controlPanel
                }
            }
            .navigationTitle("Vertex Debug")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") { dismiss() }
                }
            }
            .onAppear { trackingService.startSession() }
            .onDisappear { trackingService.stopSession() }
        }
    }

    // MARK: - Vertex Info Panel

    private func vertexInfoPanel(index: Int, position: SIMD3<Float>) -> some View {
        VStack(spacing: 8) {
            Text("Vertex #\(index)")
                .font(.headline)
            Text(String(format: "x: %.4f  y: %.4f  z: %.4f", position.x, position.y, position.z))
                .font(.system(.caption, design: .monospaced))

            // 显示该顶点对应的关键点名称（如有）
            if let name = keyPointName(for: index) {
                Text("Key Point: \(name)")
                    .font(.caption.bold())
                    .foregroundStyle(.green)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal)
    }

    // MARK: - Control Panel

    private var controlPanel: some View {
        VStack(spacing: 12) {
            Toggle("Show All Vertices", isOn: $showAllVertices)
            Toggle("Highlight Key Points", isOn: $highlightKeyPoints)

            // 关键顶点列表
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(keyPoints, id: \.index) { kp in
                        Button {
                            selectedVertexIndex = kp.index
                        } label: {
                            VStack(spacing: 2) {
                                Text("#\(kp.index)")
                                    .font(.caption2.bold())
                                Text(kp.name)
                                    .font(.caption2)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(selectedVertexIndex == kp.index
                                        ? Color.accentColor.opacity(0.2)
                                        : Color.secondary.opacity(0.1))
                            .clipShape(Capsule())
                        }
                        .foregroundStyle(selectedVertexIndex == kp.index ? Color.accentColor : .primary)
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding()
    }

    // MARK: - Key Points Data

    private struct KeyPoint {
        let index: Int
        let name: String
    }

    private var keyPoints: [KeyPoint] {
        [
            KeyPoint(index: FaceMeshVertexIndex.chin, name: "Chin"),
            KeyPoint(index: FaceMeshVertexIndex.foreheadTop, name: "Forehead"),
            KeyPoint(index: FaceMeshVertexIndex.cheekboneLeft, name: "Cheekbone L"),
            KeyPoint(index: FaceMeshVertexIndex.cheekboneRight, name: "Cheekbone R"),
            KeyPoint(index: FaceMeshVertexIndex.jawAngleLeft, name: "Jaw L"),
            KeyPoint(index: FaceMeshVertexIndex.jawAngleRight, name: "Jaw R"),
            KeyPoint(index: FaceMeshVertexIndex.templeLeft, name: "Temple L"),
            KeyPoint(index: FaceMeshVertexIndex.templeRight, name: "Temple R"),
            KeyPoint(index: FaceMeshVertexIndex.noseTip, name: "Nose Tip"),
            KeyPoint(index: FaceMeshVertexIndex.outerEyeLeft, name: "Eye L"),
            KeyPoint(index: FaceMeshVertexIndex.outerEyeRight, name: "Eye R"),
            KeyPoint(index: FaceMeshVertexIndex.browCenter, name: "Brow Center"),
            KeyPoint(index: FaceMeshVertexIndex.noseBase, name: "Nose Base"),
        ]
    }

    private func keyPointName(for index: Int) -> String? {
        keyPoints.first(where: { $0.index == index })?.name
    }
}

// MARK: - Debug AR View Container

struct DebugARViewContainer: UIViewRepresentable {
    let trackingService: FaceTrackingService
    let showAllVertices: Bool
    let highlightKeyPoints: Bool
    let onVertexTapped: (Int) -> Void
    let onVerticesUpdated: ([Int: SIMD3<Float>]) -> Void

    func makeUIView(context: Context) -> ARSCNView {
        let scnView = ARSCNView()
        scnView.automaticallyUpdatesLighting = true
        scnView.delegate = context.coordinator
        scnView.session.delegate = context.coordinator
        return scnView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
        context.coordinator.showAllVertices = showAllVertices
        context.coordinator.highlightKeyPoints = highlightKeyPoints
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onVertexTapped: onVertexTapped, onVerticesUpdated: onVerticesUpdated)
    }

    class Coordinator: NSObject, ARSCNViewDelegate, ARSessionDelegate {
        var showAllVertices = false
        var highlightKeyPoints = true
        let onVertexTapped: (Int) -> Void
        let onVerticesUpdated: ([Int: SIMD3<Float>]) -> Void
        private var vertexNodes: [SCNNode] = []

        init(onVertexTapped: @escaping (Int) -> Void,
             onVerticesUpdated: @escaping ([Int: SIMD3<Float>]) -> Void) {
            self.onVertexTapped = onVertexTapped
            self.onVerticesUpdated = onVerticesUpdated
        }

        func renderer(_ renderer: any SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            guard let faceAnchor = anchor as? ARFaceAnchor else { return }
            let geometry = faceAnchor.geometry
            let vertices = geometry.vertices

            // 清除旧节点
            for n in vertexNodes { n.removeFromParentNode() }
            vertexNodes.removeAll()

            let keyIndices = Set([
                FaceMeshVertexIndex.chin,
                FaceMeshVertexIndex.foreheadTop,
                FaceMeshVertexIndex.cheekboneLeft,
                FaceMeshVertexIndex.cheekboneRight,
                FaceMeshVertexIndex.jawAngleLeft,
                FaceMeshVertexIndex.jawAngleRight,
                FaceMeshVertexIndex.templeLeft,
                FaceMeshVertexIndex.templeRight,
                FaceMeshVertexIndex.noseTip,
                FaceMeshVertexIndex.outerEyeLeft,
                FaceMeshVertexIndex.outerEyeRight,
                FaceMeshVertexIndex.browCenter,
                FaceMeshVertexIndex.noseBase,
            ])

            var positions: [Int: SIMD3<Float>] = [:]

            for i in 0..<vertices.count {
                let isKey = keyIndices.contains(i)
                positions[i] = vertices[i]

                guard showAllVertices || (highlightKeyPoints && isKey) else { continue }

                let sphere = SCNSphere(radius: isKey ? 0.002 : 0.0005)
                sphere.firstMaterial?.diffuse.contents = isKey ? UIColor.green : UIColor.yellow.withAlphaComponent(0.4)

                let vertexNode = SCNNode(geometry: sphere)
                vertexNode.position = SCNVector3(vertices[i].x, vertices[i].y, vertices[i].z)
                vertexNode.name = "vertex_\(i)"
                node.addChildNode(vertexNode)
                vertexNodes.append(vertexNode)
            }

            DispatchQueue.main.async {
                self.onVerticesUpdated(positions)
            }
        }
    }
}
