import Foundation

public class SimpleRequestLogger: RequestLogger {
    public init() {}
    
    public func log(request: URLRequest) {
#if DEBUG
        var result = "--BEGIN--\n"
        
        if let method = request.httpMethod {
            result += "\(method)\n"
        }
        
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            result += "Headers\n"
            for (header, value) in headers {
                result += "\(header): \(value)\n"
            }
        }
        
        if let body = request.httpBody, !body.isEmpty, let string = String(data: body, encoding: .utf8), !string.isEmpty {
            result += "Body:\n\(string)\n"
        }
        
        if let url = request.url {
            result += url.absoluteString
        }
        
        print(result + "\n--END--\n")
#endif
    }
}
