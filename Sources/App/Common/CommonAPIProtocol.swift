import Foundation

public protocol APIRequestProtocol: Codable {
    static var path: String { get }
    
    associatedtype ResponseType : APIResponseProtocol
    
    func postType() -> String
    func postBody() -> Data
}

extension APIRequestProtocol {
    public func postType() -> String {
        return "application/json"
    }
    
    public func postBody() -> Data {
        return try! JSONEncoder().encode(self)
    }
}

public protocol APIResponseProtocol: Codable {
    
}
