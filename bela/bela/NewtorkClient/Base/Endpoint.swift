//
//  Endpoint.swift
//  bela
//
//  Created by Muhammet  on 1.03.2023.
//
protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var params: [String: String]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api-football-v1.p.rapidapi.com"
    }
}
