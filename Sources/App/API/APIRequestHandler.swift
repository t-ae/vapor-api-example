import Foundation
import Vapor

public protocol APIRequestHandler: APIRequestProtocol where ResponseType: APIEncodableResponseProtocol {
    static func handle(request: Request) throws -> Future<ResponseType>
}

public protocol APIEncodableResponseProtocol: APIResponseProtocol, ResponseEncodable {
}

extension APIEncodableResponseProtocol {
    public func encode(for request: Request) throws -> Future<Response> {
        let response = request.makeResponse()
        try response.content.encode(self, as: .json)
        return Future.map(on: request) { response }
    }
}
