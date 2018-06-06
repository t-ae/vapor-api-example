import Foundation

public struct APIPost: Codable {
    public var comment: String
    public var image_url: URL?
    
    public init(comment: String, image_url: URL?) {
        self.comment = comment
        self.image_url = image_url
    }
}
