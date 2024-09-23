import Testing
@testable import AVFoundationBackport_iOS17
import AVFoundation

@Test
func example() async throws {
    let asset = AVAsset()
    let session = AVAssetExportSession(
        asset: asset,
        presetName: AVAssetExportSession.allExportPresets()[0]
    )!
    let outputURL = URL(filePath: "")
    let fileType: AVFileType = .mp4
    
    if #available(iOS 18, *) {
        let task = Task {
            for try await state in session.states(updateInterval: 0.5) {
                print(state)
            }
        }
        try await session.export(to: outputURL, as: fileType)
    } else {
        let task = Task {
            for try await state in session.backport.states(updateInterval: 0.5) {
                print(state)
            }
        }
        try await session.backport.export(to: outputURL, as: fileType)
    }
}

extension AVAssetExportSession: @unchecked @retroactive Sendable {}
