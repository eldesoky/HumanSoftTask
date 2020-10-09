//
//  ApiRouter.swift
//  HumanSoftTask
//
//  Created by Abdelrahman Eldesoky on 10/9/20.
//  Copyright © 2020 Abdelrahman Eldesoky. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    //The endpoint name
    case getUsers
    case getAlbums(userId: Int)

    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    //MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        case .getAlbums:
            return .get
        }
    }
    
    //MARK: - Path
    private var path: String {
        switch self {
        case .getUsers:
            return "users"
        case .getAlbums:
           return "albums"
        }
    }
    
    //MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .getUsers:
            return [:]
        case .getAlbums(let userId):
             return [Constants.Parameters.userId : userId]
        }
    }
}
