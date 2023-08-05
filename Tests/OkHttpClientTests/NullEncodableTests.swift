import XCTest
@testable import OkHttpClient

final class NullEncodableTests: XCTestCase {
    
    func testEncodable()  throws {
        @NullEncodable var null: String? = nil
        var data = try JSONEncoder().encode(null)
        var jsonString = String(data: data, encoding: .utf8)
        XCTAssertEqual("null", jsonString)
        
        @NullEncodable var notNull: String? = "test"
        data = try JSONEncoder().encode(notNull)
        jsonString = String(data: data, encoding: .utf8)
        XCTAssertEqual("\"test\"", jsonString)
        
        struct Dummy: Encodable {
            let int: Int
            @NullEncodable var null: String?
        }
        let dummy = Dummy(int: 1)
        data = try JSONEncoder().encode(dummy)
        jsonString = String(data: data, encoding: .utf8)
        XCTAssertEqual("\"i\": 1, \"null\": null", jsonString)
    }
}
