//
//  ApiRouter.swift
//  ImdbApp
//
//  Created by Tom on 03/02/2022.
//

import Foundation
import Alamofire

enum ApiRouter {
    case getFullCast(movieId: String)
}

extension ApiRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try ApiConfig.baseUrl.asURL()
                
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(ApiConfig.ContentType.json.rawValue,
                            forHTTPHeaderField: ApiConfig.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(ApiConfig.ContentType.json.rawValue,
                            forHTTPHeaderField: ApiConfig.HttpHeaderField.contentType.rawValue)
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: nil)
    }
    
    private var method: HTTPMethod {
            switch self {
            case .getFullCast:
                return .get
            }
        }
        
        private var path: String {
            switch self {
            case .getFullCast(let movieId):
                return "\(movieId)"
            }
        }
    
    
    
    
}
