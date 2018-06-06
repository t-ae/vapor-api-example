import Vapor

extension APIPostNewRequest: APIRequestHandler {
    public static func handle(request: Request) throws -> Future<APIPostNewResponse> {
        return try request.content.decode(APIPostNewRequest.self)
            .flatMap { req in
                // check existence
                SVUser.findOrThrow(req.user_id, on: request).transform(to: req)
            }
            .flatMap { req in
                SVPost(id: nil, userID: req.user_id, comment: req.comment, imageURL: req.image_url).save(on: request)
            }
            .transform(to: APIPostNewResponse())
    }
}

extension APIPostNewResponse: APIEncodableResponseProtocol {}
