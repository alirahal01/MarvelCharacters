//
//  DefaultNetworkFactory.swift
//  MarvelCharacters
//
//  Created by ali rahal on 14/07/2023.
//

import Foundation

class DefaultNetworkServiceFactory: NetworkServiceFactory {
    static func makeNetworkService() -> DefaultNetworkClient {
        let timeStamp = Int(Date().timeIntervalSince1970)
        let hash = "\(timeStamp)\(MarvelServiceConstants.privateApiKey)\(MarvelServiceConstants.publicApiKey)".md5()

        let queryItems = [
            URLQueryItem(name: "limit", value: String(MarvelServiceConstants.limit)),
            URLQueryItem(name: "offset", value: "15"),
            URLQueryItem(name: "apikey", value: MarvelServiceConstants.publicApiKey),
            URLQueryItem(name: "ts", value: String(timeStamp)),
            URLQueryItem(name: "hash", value: hash),
            
            
        ]
        let fallBackURL = URL(string: URLConstants.baseUrl)!
        let url = URL(string: URLConstants.baseUrl) ?? fallBackURL
        let requestBuilder = RequestBuilder(baseURL: url, path: Path(components: ["v1","public","characters"]), httpMethod: .get,queryItems: queryItems)
        let requestExecutor = URLSessionNetworkRequestExecutor()
        let requestParser = MyResponseParser()
        return DefaultNetworkClient(requestBuilder: requestBuilder, requestExecutor: requestExecutor, requestParser: requestParser)
    }
}
