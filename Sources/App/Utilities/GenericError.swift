public struct GenericError: Error {
    public var message: String
    
    public init(message: String) {
        self.message = message
    }
}
