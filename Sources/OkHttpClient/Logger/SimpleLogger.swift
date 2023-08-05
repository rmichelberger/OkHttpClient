import Foundation

public class SimpleLogger: Logger {
    public init() {}
    
    public func log(request: URLRequest) {
#if DEBUG
        var result = "---------- Request ---------->"
        
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
        
        print(result + "\n------------------------->\n")
#endif
    }
    
    public func log(response: HTTPURLResponse, data: Data?) {
#if DEBUG
        let urlString = response.url?.absoluteString
        let components = URLComponents(string: urlString ?? "")
        
        var responseLog = "\n<---------- Response ----------\n"
        if let urlString {
            responseLog += "\(urlString)\n\n"
        }
        
        responseLog += "HTTP \(response.statusCode)"
        if let path = components?.path {
            responseLog += " \(path)"
        }
        if let query = components?.query {
            responseLog += "?\(query)"
        }
        responseLog += "\n"
        if let host = components?.host{
            responseLog += "Host: \(host)\n"
        }
        for (key,value) in response.allHeaderFields {
            responseLog += "\(key): \(value)\n"
        }
        if let body = data {
            let bodyString = String(data: body, encoding: .utf8) ?? "Can't render body; not utf8 encoded";
            responseLog += "\n\(bodyString)\n"
        }
        responseLog += "<------------------------\n";
        print(responseLog)
#endif
    }
}
