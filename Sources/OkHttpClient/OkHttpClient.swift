import Foundation

final public class OkHttpClient {
    private let decoder: DataDecoder
    private let logger: Logger?
    
    public init(decoder: DataDecoder = JSONDecoder(), logger: Logger? = nil) {
        self.decoder = decoder
        self.logger = logger
    }
    
    public func execute<T: Decodable>(request: URLRequest) async throws -> T {
        if let logger {
            logger.log(request: request)
        }
        let result = try await URLSession.shared.data(for: request)
        let data = result.0
        if let logger, let response = result.1 as? HTTPURLResponse {
            logger.log(response: response, data: data)
        }
            return try decoder.decode(T.self, from: data)
    }
}

@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
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

extension JSONDecoder: DataDecoder {}

#if canImport(RetroSwift)
import RetroSwift
extension OkHttpClient: HTTPClient {}
#endif
