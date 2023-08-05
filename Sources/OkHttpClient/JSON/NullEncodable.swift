@propertyWrapper
public struct NullEncodable<Value: Encodable>: Encodable {
    public var wrappedValue: Value?
    
    public init(wrappedValue: Value? = nil) {
        self.wrappedValue = wrappedValue
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch wrappedValue {
        case .some(let value): try value.encode(to: encoder)
        case .none: try container.encodeNil()
        }
    }
}
