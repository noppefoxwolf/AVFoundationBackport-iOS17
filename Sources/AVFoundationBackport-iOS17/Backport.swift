import AVFoundation

public final class Backport: @unchecked Sendable {
    let base: AVAssetExportSession
    
    init(base: AVAssetExportSession) {
        self.base = base
    }
}

extension AVAssetExportSession {
    public var backport: Backport { Backport(base: self) }
}

extension Backport {
    public func states(updateInterval interval: TimeInterval = .infinity) -> AsyncStream<AVAssetExportSession.CompatibleState> {
        let (stream, continuation) = AsyncStream<AVAssetExportSession.CompatibleState>.makeStream()
        let task = Task {
            while true {
                try await Task.sleep(for: .seconds(interval))
                continuation.yield(state)
                try Task.checkCancellation()
            }
        }
        continuation.onTermination = { _ in
            task.cancel()
        }
        return stream
    }
    
    var state: AVAssetExportSession.CompatibleState {
        switch base.status {
        case .waiting:
            return .waiting
        case .exporting:
            let progress = Progress(totalUnitCount: 100)
            progress.completedUnitCount = Int64(base.progress * 100)
            return .exporting(progress: progress)
        default:
            return .pending
        }
    }
}

extension Backport {
    public func export(to outputURL: URL, as outputFileType: AVFileType) async throws {
        base.outputURL = outputURL
        base.outputFileType = outputFileType
        await base.export()
        if let error = base.error {
            throw error
        }
    }
}
