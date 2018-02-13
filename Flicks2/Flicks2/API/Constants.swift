//
//  Constants.swift
//  Flicks2
//
//  Created by Wuming Xie on 2/12/18.
//  Copyright © 2018 WX. All rights reserved.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.themoviedb.org/3/movie"
    static let smallPosterBaseUrl = "https://image.tmdb.org/t/p/w92"
    static let largePosterBaseUrl = "https://image.tmdb.org/t/p/w500"
    static let key = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    struct ParameterKey {
        static let apiKey = "api_key"
        static let page = "page"
    }
}

struct ContentType {
    static let json = "application/json"
}

struct HTTPHeaderField {
    static let acceptType = "Accept"
    static let contentType = "Content-Type"
}
