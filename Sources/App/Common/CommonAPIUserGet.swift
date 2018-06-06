public struct APIUserGetRequest: APIRequestProtocol, Codable {
    public static var path: String = "user/get"
    
    public typealias ResponseType = APIUserGetResponse
    
    public var id: Int
    
    public init(id: Int) {
        self.id = id
    }
}

public struct APIUserGetResponse: APIResponseProtocol, Codable {
    public var name: String
    public var email: String
    
    public var posts: [APIPost]
    
    public init(name: String, email: String, posts: [APIPost]) {
        self.name = name
        self.email = email
        self.posts = posts
    }
}
