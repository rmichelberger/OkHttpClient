import Foundation

public class SimpleLogger: Logger {
    public init() {}
    
    public func log(request: URLRequest) {
#if DEBUG
        var result = "---------- Request ---------->\n"
        
        if let method = request.httpMethod {
            result += "\(method) "
        }
        if let url = request.url {
            result += url.absoluteString
        }

        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            result += "\nHeaders\n"
            for (name, value) in headers {
                result += "\(name): \(value)\n"
            }
        }
        
        if let body = request.httpBody {
            let string = String(data: body, encoding: .utf8) ?? "Can't render body; not UTF-8 encoded"
            result += "\nBody:\n\(string)\n"
        }
                
        print(result + "\n------------------------->\n")
#endif
    }
    
    public func log(response: HTTPURLResponse, data: Data?) {
#if DEBUG
        let urlString = response.url?.absoluteString
        let components = URLComponents(string: urlString ?? "")
        
        var responseLog = "<---------- Response ----------\n"
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
        for (name,value) in response.allHeaderFields {
            responseLog += "\(name): \(value)\n"
        }
        if let body = data {
            let bodyString = String(data: body, encoding: .utf8) ?? "Can't render body; not UTF-8 encoded"
            responseLog += "\n\(bodyString)\n"
        }
        responseLog += "\n<------------------------\n"
        print(responseLog)
#endif
    }
}
