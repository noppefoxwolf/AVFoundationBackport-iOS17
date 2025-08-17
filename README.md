# AVFoundationBackport-iOS17

A library that provides backward compatibility for the new AVAssetExportSession APIs introduced in iOS 18/macOS 15 to iOS 17/macOS 14.

## Overview

iOS 18/macOS 15 introduced new `states` and `export` methods to AVAssetExportSession. This library provides backward compatibility to use these new APIs on iOS 17/macOS 14.

## Requirements

- iOS 17.0+
- macOS 14.0+

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/noppefoxwolf/AVFoundationBackport-iOS17.git", from: "1.0.0")
]
```

## Usage

### Export Processing

```swift
import AVFoundation
import AVFoundationBackport_iOS17

let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)!

// Execute export asynchronously
try await exportSession.export(to: outputURL, as: .mp4)
```

### Export State Monitoring

```swift
import AVFoundation
import AVFoundationBackport_iOS17

let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)!

// Monitor export state
for await state in exportSession.states(updateInterval: 0.1) {
    switch state {
    case .pending:
        print("Export pending")
    case .waiting:
        print("Export waiting")
    case .exporting(let progress):
        print("Exporting: \(progress.fractionCompleted * 100)%")
    }
}
```

## API

### AVAssetExportSession Extensions

#### states(updateInterval:)

```swift
func states(updateInterval interval: TimeInterval = .infinity) -> AsyncStream<AVAssetExportSession.CompatibleState>
```

Returns an AsyncStream that monitors state changes of the export session.

**Parameters:**
- `interval`: Update interval in seconds. Default is `.infinity`

#### export(to:as:)

```swift
func export(to outputURL: URL, as outputFileType: AVFileType) async throws
```

Executes export to the specified URL and file type.

**Parameters:**
- `outputURL`: Output destination URL
- `outputFileType`: Output file type

### CompatibleState

```swift
enum CompatibleState: Sendable {
    case pending
    case waiting
    case exporting(progress: Progress)
}
```

An enumeration representing the state of the export session.

- `pending`: Export is pending
- `waiting`: Export is waiting
- `exporting(progress:)`: Export is in progress (with progress information)

## License

MIT License

## Contributing

Pull requests and issue reports are welcome.