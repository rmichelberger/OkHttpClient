import Foundation

public protocol Logger {
    func log(request: URLRequest)
    func log(response: HTTPURLResponse, data: Data?)    
}
