import XCTest
@testable import OkHttpClient

final class OkHttpClientTests: XCTestCase {
    func testExample() async throws {
        let client = OkHttpClient(logger: SimpleLogger())
        let url = URL(string: "https://swapi.dev/api/planets/")!
        var request = URLRequest(url: url)
        request.setValue("text/html", forHTTPHeaderField: "Accept")
        let data: String = try await client.execute(request: request)
        print(data)
    }
}
