import SwiftUI

struct HomeView: View {
    @State private var showCamera = false
    @State private var showDebugMesh = false
    @State private var selectedGender: Gender = .female

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // MARK: - Hero Section
                heroSection

                // MARK: - Gender Selection
                genderPicker

                // MARK: - Start Button
                startButton

                // MARK: - How it Works
                howItWorksSection

                // MARK: - Disclaimer
                disclaimerSection
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        .navigationTitle("FaceStyle")
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(isPresented: $showCamera) {
            CameraView(selectedGender: selectedGender)
        }
        .sheet(isPresented: $showDebugMesh) {
            DebugMeshView()
        }
        .toolbar {
            #if DEBUG
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showDebugMesh = true
                } label: {
                    Image(systemName: "cube.transparent")
                }
            }
            #endif
        }
    }

    // MARK: - Hero

    private var heroSection: some View {
        VStack(spacing: 16) {
            Image(systemName: "face.smiling")
                .font(.system(size: 64))
                .foregroundStyle(Color.accentColor)
                .padding(.top, 20)

            Text("home.title", tableName: nil, bundle: nil,
                 comment: "Main title")
                .font(.title.bold())

            Text("home.subtitle", tableName: nil, bundle: nil,
                 comment: "Subtitle")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
    }

    // MARK: - Gender Picker

    private var genderPicker: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("home.selectGender", tableName: nil, bundle: nil,
                 comment: "Select gender label")
                .font(.headline)

            Picker("Gender", selection: $selectedGender) {
                Text(Gender.female.displayName).tag(Gender.female)
                Text(Gender.male.displayName).tag(Gender.male)
            }
            .pickerStyle(.segmented)
        }
    }

    // MARK: - Start Button

    private var startButton: some View {
        Button {
            showCamera = true
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "camera.fill")
                    .font(.title3)
                Text("home.startAnalysis", tableName: nil, bundle: nil,
                     comment: "Start analysis button")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.accentColor)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .disabled(!FaceTrackingService.isSupported)
        .overlay {
            if !FaceTrackingService.isSupported {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                    .overlay {
                        Text("home.notSupported", tableName: nil, bundle: nil,
                             comment: "Device not supported message")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
            }
        }
    }

    // MARK: - How It Works

    private var howItWorksSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("home.howItWorks", tableName: nil, bundle: nil,
                 comment: "How it works section title")
                .font(.headline)

            ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                HStack(alignment: .top, spacing: 16) {
                    Text("\(index + 1)")
                        .font(.caption.bold())
                        .foregroundStyle(.white)
                        .frame(width: 28, height: 28)
                        .background(Color.accentColor)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text(step.title)
                            .font(.subheadline.bold())
                        Text(step.description)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding(20)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var steps: [(title: LocalizedStringResource, description: LocalizedStringResource)] {
        [
            (title: "home.step1.title", description: "home.step1.desc"),
            (title: "home.step2.title", description: "home.step2.desc"),
            (title: "home.step3.title", description: "home.step3.desc"),
        ]
    }

    // MARK: - Disclaimer

    private var disclaimerSection: some View {
        Text("home.disclaimer", tableName: nil, bundle: nil,
             comment: "Disclaimer text")
            .font(.caption2)
            .foregroundStyle(.tertiary)
            .multilineTextAlignment(.center)
            .padding(.bottom, 16)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
