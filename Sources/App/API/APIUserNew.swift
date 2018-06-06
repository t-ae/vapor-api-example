import Vapor

extension APIUserNewRequest: APIRequestHandler {
    public static func handle(request: Request) throws -> Future<APIUserNewResponse> {
        return try request.content.decode(APIUserNewRequest.self)
            .flatMap { req in
                SVUser(id: nil, userName: req.name, email: req.email).save(on: request)
            }
            .map { user in
                APIUserNewResponse(id: user.id!)
            }
    }
}

extension APIUserNewResponse: APIEncodableResponseProtocol {}
