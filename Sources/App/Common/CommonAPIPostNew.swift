import Foundation

public struct APIPostNewRequest: APIRequestProtocol {
    public static var path: String = "post/new"
    public typealias ResponseType = APIPostNewResponse
    
    public var userID: Int
    public var comment: String
    public var imageURL: URL
    
    public init(userID: Int, comment: String, imageURL: URL) {
        self.userID = userID
        self.comment = comment
        self.imageURL = imageURL
    }
}

public struct APIPostNewResponse: APIResponseProtocol {
    public init() {}
}
