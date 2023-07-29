import Foundation

public protocol RequestLogger {
    func log(request: URLRequest)
}
