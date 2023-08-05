import XCTest
@testable import OkHttpClient

final class JSONTests: XCTestCase {
    
    func testJSONTypes() throws {
        var json = try JSONDecoder().decode(JSON.self, from: data(from: "null"))
        XCTAssertEqual(json, .null)
        
        let int = -1
        json = try JSONDecoder().decode(JSON.self, from: data(from: int))
        XCTAssertEqual(json, .int(int))
        
        let double = -1.5
        json = try JSONDecoder().decode(JSON.self, from: data(from: double))
        XCTAssertEqual(json, .double(double))
        
        let bool = true
        json = try JSONDecoder().decode(JSON.self, from: data(from: bool))
        XCTAssertEqual(json, .bool(bool))
        
        let string = "\"string\""
        json = try JSONDecoder().decode(JSON.self, from: data(from: string))
        XCTAssertEqual(json, .string("string"))
        
        let array = "[-1,\"test\", true, null, {\"key\":\"value\"}]"
        json = try JSONDecoder().decode(JSON.self, from: data(from: array))
        XCTAssertEqual(json, .array([.int(-1), .string("test"), .bool(true), .null, .dictionary(["key" : .string("value")])]))
        
        let dictionary = "{\"a\":-1, \"b\":\"test\", \"c\": true, \"d\": null, \"e\": [1,2]}"
        json = try JSONDecoder().decode(JSON.self, from: data(from: dictionary))
        XCTAssertEqual(json, .dictionary(["a" : .int(-1), "b": .string("test"), "c": .bool(true), "d": .null, "e": .array([.int(1), .int(2)])]))
    }
    
    private func data(from value: CustomStringConvertible) throws -> Data {
        try XCTUnwrap(value.description.data(using:.utf8))
    }
    
    func testJSON()  throws {
        let nestedDict = try JSONDecoder().decode(JSON.self, from: data(from: "{\"key\":{\"key\":1}}"))
        XCTAssertEqual(nestedDict, .dictionary(["key" : .dictionary(["key" : .int(1)])]))
        
        let nestedArray = try JSONDecoder().decode(JSON.self, from: data(from: "[[1,2],3]"))
        XCTAssertEqual(nestedArray, .array([.array([.int(1), .int(2)]), .int(3)]) )
        
        struct Dummy: Encodable {
            let b = false
            let i = 1
            let d = -1.4
            let s = "s"
            let di: [String: Int] = ["a": -1,"b": 0,]
            let a = ["1","2"]
            @NullEncodable var n: String? = nil
        }
        let dummy = Dummy()
        let data = try JSONEncoder().encode(dummy)
        let json = try JSONDecoder().decode(JSON.self, from: data)
        XCTAssertEqual(json, .dictionary(["b" : .bool(false), "i": .int(1), "s": .string("s"), "d": .double(-1.4), "di": .dictionary(["a": .int(-1), "b": .int(0)]), "a": .array([.string("1"), .string("2")]), "n": .null]))
        let jsonData = try JSONEncoder().encode(json)
        XCTAssertEqual(data.count, jsonData.count)
    }
}
