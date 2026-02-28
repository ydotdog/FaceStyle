import AVFoundation
import SwiftUI

/// 相机权限管理
@MainActor
final class CameraPermissionManager: ObservableObject {
    @Published var authorizationStatus: AVAuthorizationStatus

    init() {
        self.authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
    }

    var isAuthorized: Bool {
        authorizationStatus == .authorized
    }

    var isDenied: Bool {
        authorizationStatus == .denied || authorizationStatus == .restricted
    }

    var isNotDetermined: Bool {
        authorizationStatus == .notDetermined
    }

    func requestPermission() async {
        let granted = await AVCaptureDevice.requestAccess(for: .video)
        authorizationStatus = granted ? .authorized : .denied
    }

    func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}
