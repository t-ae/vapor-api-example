import Vapor

extension APIPostNewRequest: APIRequestHandler {
    public static func handle(request: Request) throws -> Future<APIPostNewResponse> {
        return try request.content.decode(APIPostNewRequest.self)
            .flatMap { req in
                // check existence
                SVUser.findOrThrow(req.userID, on: request).transform(to: req)
            }
            .flatMap { req in
                SVPost(id: nil, userID: req.userID, comment: req.comment, imageURL: req.imageURL).save(on: request)
            }
            .transform(to: APIPostNewResponse())
    }
}

extension APIPostNewResponse: APIEncodableResponseProtocol {}
