import Foundation

final public class OkHttpClient {
    public init() {print("OkHttpClient")}
    
    public func execute<T: Decodable>(request: URLRequest) async throws -> T {
        let data = try await URLSession.shared.data(for: request).0
        return try JSONDecoder().decode(T.self, from: data)
    }
}

@available(iOS, deprecated: 15.0, message: "Use the built-in API instead")
public extension URLSession {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = dataTask(with: url) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        }
    }
}

#if canImport(RetroSwift)
import RetroSwift
extension OkHttpClient: HTTPClient {}
#endif
