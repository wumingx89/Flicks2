//
//  MovieDBClient.swift
//  Flicks2
//
//  Created by Wuming Xie on 2/12/18.
//  Copyright © 2018 WX. All rights reserved.
//

import Foundation
import Alamofire

enum MovieEndpoint: URLConvertible {
    case nowPlaying(page: Int)
    case popular(page: Int)
    
    private var path: String {
        switch self {
        case .nowPlaying:
            return "/now_playing"
        case .popular:
            return "/popular"
        }
    }
    
    var parameters: Parameters {
        var params: Parameters = [Constants.ParameterKey.apiKey: Constants.key]
        switch self {
        case .nowPlaying(let page), .popular(let page):
            if page > 1 {
                params[Constants.ParameterKey.page] = page
            }
        }
        return params
    }
    
    func asURL() throws -> URL {
        return try Constants.baseURL.asURL().appendingPathComponent(path)
//        // Set http method
//        urlRequest.httpMethod = HTTPMethod.get.rawValue
//
//        // Set common headers
//        urlRequest.setValue(ContentType.json, forHTTPHeaderField: HTTPHeaderField.acceptType)
//        urlRequest.setValue(ContentType.json, forHTTPHeaderField: HTTPHeaderField.contentType)
//
//        return urlRequest.url!
    }
}

class MovieDBClient {
    private let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    private let baseURL = "https://api.themoviedb.org/3/movie"
    static let shared: MovieDBClient = MovieDBClient()
    
    func getMovies(endPoint: MovieEndpoint = .nowPlaying(page: 1), completion: @escaping (MoviesList?, Error?) -> ()) {
        Alamofire.request(endPoint, method: .get, parameters: endPoint.parameters)
            .responseJSONDecodable { (response: DataResponse<MoviesList>) in
                switch response.result {
                case .success(let moviesList):
                    completion(moviesList, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}
