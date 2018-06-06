import FluentSQLite

public protocol SVModelProtocol {
    associatedtype DBModel: SQLiteModel
    
    init(from db: DBModel) throws
    func toDB() -> DBModel
    
    var createdAt: Date? { get set }
    var updatedAt: Date? { get set }
}

extension SVModelProtocol {
    public static var defaultDatabase: DatabaseIdentifier<SQLiteDatabase>? {
        get { return DBModel.defaultDatabase }
        set { DBModel.defaultDatabase = newValue }
    }
    
    public static func find(_ id: Int, on conn: DatabaseConnectable) -> Future<Self?> {
        return try! DBModel.find(id, on: conn).map { try $0.map(Self.init) }
    }
    
    public static func findOrThrow(_ id: Int, on conn: DatabaseConnectable) -> Future<Self> {
        return try! DBModel.find(id, on: conn).map {
            guard let db = $0 else {
                throw GenericError(message: "No \(DBModel.entity) found for id: \(id)")
            }
            return try Self(from: db)
        }
    }
    
    public static func findAll(on conn: DatabaseConnectable) -> Future<[Self]> {
        return DBModel.query(on: conn).all().map(to: [Self].self) {
            try $0.map { db in
                try Self(from: db)
            }
        }
    }
    
    public func save(on conn: DatabaseConnectable) -> Future<Self> {
        return toDB().save(on: conn).map(Self.init)
    }
    
    public func delete(on conn: DatabaseConnectable) -> Future<Void> {
        return toDB().delete(on: conn)
    }
}
