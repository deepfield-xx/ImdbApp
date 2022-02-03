//
//  ApiConfig.swift
//  ImdbApp
//
//  Created by Tom on 03/02/2022.
//

import Foundation

struct ApiConfig {
    static let baseUrl = "https://imdb-api.com/en/API/FullCast/k_iev7ettp/"
    
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
        
    enum ContentType: String {
        case json = "application/json"
    }
}
