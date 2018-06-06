import FluentSQLite

public struct DBUser: SQLiteModel, Timestampable, Migration {
    public static var name = "user"
    public static var createdAtKey: WritableKeyPath<DBUser, Date?> = \DBUser.created_at
    public static var updatedAtKey: WritableKeyPath<DBUser, Date?> = \DBUser.updated_at
    
    public var id: Int?
    
    public var user_name: String
    public var email: String
    
    public var created_at: Date?
    public var updated_at: Date?
    
    public init(id: Int?,
                user_name: String,
                email: String,
                created_at: Date?,
                updated_at: Date?) {
        self.id = id
        self.user_name = user_name
        self.email = email
        self.created_at = created_at
        self.updated_at = updated_at
    }
}

public struct SVUser: SVModelProtocol {
    public var id: Int?
    
    public var userName: String
    public var email: String
    
    public var createdAt: Date?
    public var updatedAt: Date?
    
    public init(id: Int?,
                userName: String,
                email: String,
                createdAt: Date? = nil,
                updatedAt: Date? = nil) {
        self.id = id
        self.userName = userName
        self.email = email
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    public init(from db: DBUser) throws {
        self.init(id: db.id,
                  userName: db.user_name,
                  email: db.email,
                  createdAt: db.created_at,
                  updatedAt: db.updated_at)
    }
    
    public func toDB() -> DBUser {
        return DBUser(id: id, user_name: userName, email: email, created_at: createdAt, updated_at: updatedAt)
    }
}
