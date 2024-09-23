import AVFoundation

extension AVAssetExportSession {
    @_disfavoredOverload
    public func states(updateInterval interval: TimeInterval = .infinity) -> AsyncStream<AVAssetExportSession.CompatibleState> {
        backport.states(updateInterval: interval)
    }

    @_disfavoredOverload
    public func export(to outputURL: URL, as outputFileType: AVFileType) async throws {
        try await backport.export(to: outputURL, as: outputFileType)
    }
}
