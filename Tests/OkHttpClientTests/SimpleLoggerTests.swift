import XCTest
@testable import OkHttpClient

final class SimpleLoggerTests: XCTestCase {
    func testRequestLogging()  throws {
        let request = URLRequest(url: URL(string: "https://example.com")!)
        let logger = SimpleLogger()
        logger.log(request: request)
    }
}
