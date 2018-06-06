import Vapor

extension APIUserGetRequest: APIRequestHandler {
    public static func handle(request: Request) throws -> Future<APIUserGetResponse> {
        return try request.content.decode(APIUserGetRequest.self)
            .flatMap { req in
                SVUser.findOrThrow(req.id, on: request)
            }
            .flatMap { user in
                try SVPost.search(userID: user.id!, on: request).map { posts in
                    APIUserGetResponse(name: user.userName, email: user.email, posts: posts.map(APIPost.init))
                }
            }
    }
}

extension APIUserGetResponse: APIEncodableResponseProtocol {}
