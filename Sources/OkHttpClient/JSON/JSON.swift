import Foundation

public enum JSON: Codable, Equatable {
    
    case null
    case bool(Bool)
    case double(Double)
    case int(Int)
    case string(String)
    indirect case array([JSON])
    indirect case dictionary([String: JSON])
    
    public init(from decoder: Decoder) throws {
        if let container = try? decoder.singleValueContainer() {
            self = JSON(from: container)
        } else if let container = try? decoder.container(keyedBy: JSONCodingKeys.self) {
            self = JSON(from: container)
        } else if let container = try? decoder.unkeyedContainer() {
            self = JSON(from: container)
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: ""))
        }
    }
    
    private init(from container: SingleValueDecodingContainer) {
        if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode(Int.self) {
            self  = .int(value)
        } else if let value = try? container.decode(Double.self) {
            self  = .double(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode([JSON].self) {
            self = .array(value)
        } else if let value = try? container.decode([String: JSON].self) {
            self = .dictionary(value)
        } else {
            self = .null
        }
    }
    
    private init(from container: KeyedDecodingContainer<JSONCodingKeys>) {
        var dict: [String: JSON] = [:]
        for key in container.allKeys {
            if let value = try? container.decode(Bool.self, forKey: key) {
                dict[key.stringValue] = .bool(value)
            } else if let value = try? container.decode(Int.self, forKey: key) {
                dict[key.stringValue] = .int(value)
            } else if let value = try? container.decode(Double.self, forKey: key) {
                dict[key.stringValue] = .double(value)
            } else if let value = try? container.decode(String.self, forKey: key) {
                dict[key.stringValue] = .string(value)
            } else if let value = try? container.nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key) {
                dict[key.stringValue] = JSON(from: value)
            } else if let value = try? container.nestedUnkeyedContainer(forKey: key) {
                dict[key.stringValue] = JSON(from: value)
            } else if let _ = try? container.decodeNil(forKey: key) {
                dict[key.stringValue] = JSON.null
            }
        }
        self = .dictionary(dict)
    }
    
    private init(from container: UnkeyedDecodingContainer) {
        var container = container
        let count = container.count ?? 0
        if count == 0 {
            self = .null
        } else if count == 1 {
            if let value = try? container.decode(Bool.self) {
                self = .bool(value)
            } else if let value = try? container.decode(Int.self) {
                self = .int(value)
            } else if let value = try? container.decode(Double.self) {
                self = .double(value)
            } else if let value = try? container.decode(String.self) {
                self = .string(value)
            } else if let value = try? container.nestedContainer(keyedBy: JSONCodingKeys.self) {
                self = JSON(from: value)
            } else if let value = try? container.nestedUnkeyedContainer() {
                self = JSON(from: value)
            } else if let _ = try? container.decodeNil() {
                self = .null
            }
        } else {
            var arr: [JSON] = []
            while !container.isAtEnd {
                if let value = try? container.decode(Bool.self) {
                    arr.append(.bool(value))
                } else if let value = try? container.decode(Int.self) {
                    arr.append(.int(value))
                } else if let value = try? container.decode(Double.self) {
                    arr.append(.double(value))
                } else if let value = try? container.decode(String.self) {
                    arr.append(.string(value))
                } else if let value = try? container.nestedContainer(keyedBy: JSONCodingKeys.self) {
                    arr.append(JSON(from: value))
                } else if let value = try? container.nestedUnkeyedContainer() {
                    arr.append(JSON(from: value))
                } else if let _ = try? container.decodeNil() {
                    arr.append(.null)
                }
            }
            self = .array(arr)
        }
        self = .null
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case .array(let array):
            try array.forEach {
                var container = encoder.unkeyedContainer()
                try container.encode($0)
            }
        case .bool(let bool):
            var container = encoder.singleValueContainer()
            try container.encode(bool)
        case .dictionary(let dictionary):
            try dictionary.forEach {
                var container = encoder.container(keyedBy: JSONCodingKeys.self)
                try container.encode($1, forKey: JSONCodingKeys(stringValue: $0))
            }
        case .double(let double):
            var container = encoder.singleValueContainer()
            try container.encode(double)
        case .int(let int):
            var container = encoder.singleValueContainer()
            try container.encode(int)
        case .string(let string):
            var container = encoder.singleValueContainer()
            try container.encode(string)
        case .null:
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
    }
}

struct JSONCodingKeys: CodingKey {
    var stringValue: String
    init(stringValue: String) {
        self.stringValue = stringValue
    }
    var intValue: Int?
    init(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}
