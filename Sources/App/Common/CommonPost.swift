import Foundation

public struct Post: Codable {
    public var comment: String
    public var imageURL: URL
    
    public init(comment: String, imageURL: URL) {
        self.comment = comment
        self.imageURL = imageURL
    }
}
