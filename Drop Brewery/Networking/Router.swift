import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case beers([String: String])
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .beers:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .beers:
            return "/beers"
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.Networking.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case let .beers(parameters):
            urlRequest = try URLEncodedFormParameterEncoder().encode(parameters, into: urlRequest)
        }
        
        return urlRequest
    }
}
