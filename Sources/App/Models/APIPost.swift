import FluentSQLite

public struct DBPost: SQLiteModel, Timestampable, Migration {
    public static var name = "post"
    
    public static var createdAtKey: WritableKeyPath<DBPost, Date?> = \DBPost.created_at
    public static var updatedAtKey: WritableKeyPath<DBPost, Date?> = \DBPost.updated_at
    

    public var id: Int?
    
    public var user_id: Int
    
    public var comment: String
    public var image_url: String?
    
    public var created_at: Date?
    public var updated_at: Date?
    
    public init(id: Int?,
                user_id: Int,
                comment: String,
                image_url: String?,
                created_at: Date?,
                updated_at: Date?) {
        self.id = id
        self.user_id = user_id
        self.comment = comment
        self.image_url = image_url
        self.created_at = created_at
        self.updated_at = updated_at
    }
}


public struct SVPost: SVModelProtocol {
    public var id: Int?
    public var userID: Int
    
    public var comment: String
    public var imageURL: URL?
    
    public var createdAt: Date?
    public var updatedAt: Date?
    
    public init(id: Int?,
                userID: Int,
                comment: String,
                imageURL: URL?,
                createdAt: Date? = nil,
                updatedAt: Date? = nil) {
        self.id = id
        self.userID = userID
        self.comment = comment
        self.imageURL = imageURL
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    public init(from db: DBPost) throws {
        
        let imageURL: URL?
        if let url = db.image_url {
            guard let temp = URL(string: url) else {
                throw GenericError(message: "Malformed URL.")
            }
            imageURL = temp
        } else {
            imageURL = nil
        }
        
        self.init(id: db.id,
                  userID: db.user_id,
                  comment: db.comment,
                  imageURL: imageURL,
                  createdAt: db.created_at,
                  updatedAt: db.updated_at)
    }
    
    public func toDB() -> DBPost {
        return DBPost(id: id,
                      user_id: userID,
                      comment: comment,
                      image_url: imageURL?.absoluteString,
                      created_at: createdAt,
                      updated_at: updatedAt)
    }
}

extension SVPost {
    public static func search(userID: Int, on conn: DatabaseConnectable) throws -> Future<[SVPost]> {
        return try DBPost.query(on: conn).filter(\DBPost.user_id == userID).all().map {
            try $0.map(SVPost.init)
        }
    }
}

extension APIPost {
    init(from sv: SVPost) {
        self.init(comment: sv.comment, image_url: sv.imageURL)
    }
}
