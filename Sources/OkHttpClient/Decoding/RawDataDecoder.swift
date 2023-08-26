import Foundation

public final class RawDataDecoder: DataDecoder {
    public init() {}
    
    public func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        if let data = data as? T {
            return data
        } else { throw URLError(.cannotDecodeRawData) }
    }
}
