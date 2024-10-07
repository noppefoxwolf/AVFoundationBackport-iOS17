import AVFoundation

extension AVAssetExportSession {
    public enum CompatibleState: Sendable {

        case pending

        case waiting

        case exporting(progress: Progress)
        
        @available(iOS 18, macOS 15, *)
        init(_ state: AVAssetExportSession.State) {
            switch state {
            case .pending:
                self = .pending
            case .waiting:
                self = .waiting
            case .exporting(let progress):
                self = .exporting(progress: progress)
            @unknown default:
                fatalError()
            }
        }
    }
}
