//
//  HTTPClientTest.swift
//  belaTests
//
//  Created by Muhammet  on 29.03.2023.
//

import XCTest
@testable import bela

class HTTPClientTests: XCTestCase {
    
    func testSendRequestSuccess() async {
        let expectation = XCTestExpectation(description: "Request should succeed")
        
         let endpoint = MockEndpoint()
         let httpClient = MyHTTPClient()
        
        let result: Result<MyResponseModel, RequestError> = await httpClient.sendRequest(endpoint: endpoint, responseModel: MyResponseModel.self)
        
        switch result {
        case .success(let response):
            XCTAssertEqual(response.name, "varol")
            expectation.fulfill()
        case .failure(let error):
            XCTFail("Request failed with error: \(error.customMessage)")
        }
        wait(for: [expectation], timeout: 5.0)
    }
}

struct MyResponseModel: Decodable {
    let name: String
}

struct MyHTTPClient: HTTPClient {
    func sendRequest<T>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> where T : Decodable {
        // Here you can return a mock response or a real network request using the given endpoint
        let response = MyResponseModel(name: "varol")
        return .success(response as! T)
    }
}

struct MockEndpoint: Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "mockapi.com"
    }
    
    var path: String {
        return "/test"
    }
    
    var method: RequestMethod {
        return .get 
        
    }
    
    var header: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var params: [String : String]? {
        return nil
    }
}
