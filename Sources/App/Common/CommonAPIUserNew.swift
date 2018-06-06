public struct APIUserNewRequest: APIRequestProtocol, Codable {
    public static var path: String = "user/new"
    
    public typealias ResponseType = APIUserNewResponse
    
    public var name: String
    public var email: String
    
    public init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

public struct APIUserNewResponse: APIResponseProtocol, Codable {
    public var id: Int
    
    public init(id: Int) {
        self.id = id
    }
}
