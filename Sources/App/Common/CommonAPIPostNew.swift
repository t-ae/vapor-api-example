import Foundation

public struct APIPostNewRequest: APIRequestProtocol {
    public static var path: String = "post/new"
    public typealias ResponseType = APIPostNewResponse
    
    public var user_id: Int
    public var comment: String
    public var image_url: URL?
    
    public init(user_id: Int, comment: String, image_url: URL?) {
        self.user_id = user_id
        self.comment = comment
        self.image_url = image_url
    }
}

public struct APIPostNewResponse: APIResponseProtocol {
    public init() {}
}
