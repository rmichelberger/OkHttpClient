# OkHttpClient

[![SwiftPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frmichelberger%2FOkHttpClient%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/rmichelberger/OkHttpClient) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frmichelberger%2FOkHttpClient%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/rmichelberger/OkHttpClient)

A leightweigth HTTP client for Swift projects.

## Installing OkHttpClient
OkHttpClient supports [Swift Package Manager](https://www.swift.org/package-manager/).

### Swift Package Manager

To install OkHttpClient using [Swift Package Manager](https://github.com/apple/swift-package-manager) you can follow the [tutorial published by Apple](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) using the URL for the OkHttpClient repo with the current version:

1. In Xcode, select “File” → “Add Packages...”
1. Enter https://github.com/rmichelberger/OkHttpClient

or you can add the following dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/rmichelberger/OkHttpClient/", from: "1.0.0")
```

## Usage

```swift
func getItems() async throws -> [Item] {
    let client = OkHttpClient()
    let url = URL(...)
    let request = URLRequest(url: url)
    return try await client.execute(request)
}
```

### Logger

You can specify the request and response logger.

```swift
let logger = SimpleLogger()
let client = OkHttpClient(logger: logger)
```

### Data decoder

You can specify the data decoder.
It's used to decode the response data.

The default is `JSONDecoder`.

```swift
let decoder = Decoder()
let client = OkHttpClient(decoder: decoder)
```

## RetroSwift

OkHttpClient is best used together with [RetroSwift](https://github.com/rmichelberger/RetroSwift).

## TODO

- [ ] Improve unit test coverage.
- [ ] Improve documentation.

## Contributing

We always appreciate contributions from the community.
Please make sure to cover your changes with unit tests.

#
Inspired by [OkHttp](https://github.com/square/okhttp).
