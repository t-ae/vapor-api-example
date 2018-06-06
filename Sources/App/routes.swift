import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.register(APIUserNewRequest.self)
    router.register(APIUserGetRequest.self)
    router.register(APIPostNewRequest.self)
}


extension Router {
    @discardableResult
    public func register<T: APIRequestHandler>(_ requestType: T.Type) -> Route<Responder> {
        return post(T.path, use: T.handle)
    }
}
