//
//  RequestErrorTest.swift
//  sekerbankTests
//
//  Created by Muhammet  on 31.03.2023.
//

import Foundation
@testable import sekerbank
import XCTest

class RequestErrorTest: XCTestCase{
    
    func testRequestError() {
        // Check custom messages for each case
        XCTAssertEqual(RequestError.decode.customMessage, "Decode error")
        XCTAssertEqual(RequestError.invalidURL.customMessage, "Unknown error")
        XCTAssertEqual(RequestError.noResponse.customMessage, "Unknown error")
        XCTAssertEqual(RequestError.unauthorized.customMessage, "Session expired")
        XCTAssertEqual(RequestError.unexpectedStatusCode.customMessage, "Unknown error")
        XCTAssertEqual(RequestError.unknown.customMessage, "Unknown error")
        
        // Check if cases are distinct
        XCTAssertNotEqual(RequestError.decode, RequestError.invalidURL)
        XCTAssertNotEqual(RequestError.decode, RequestError.noResponse)
        XCTAssertNotEqual(RequestError.decode, RequestError.unauthorized)
        XCTAssertNotEqual(RequestError.decode, RequestError.unexpectedStatusCode)
        XCTAssertNotEqual(RequestError.decode, RequestError.unknown)
        XCTAssertNotEqual(RequestError.invalidURL, RequestError.noResponse)
        XCTAssertNotEqual(RequestError.invalidURL, RequestError.unauthorized)
        XCTAssertNotEqual(RequestError.invalidURL, RequestError.unexpectedStatusCode)
        XCTAssertNotEqual(RequestError.invalidURL, RequestError.unknown)
        XCTAssertNotEqual(RequestError.noResponse, RequestError.unauthorized)
        XCTAssertNotEqual(RequestError.noResponse, RequestError.unexpectedStatusCode)
        XCTAssertNotEqual(RequestError.noResponse, RequestError.unknown)
        XCTAssertNotEqual(RequestError.unauthorized, RequestError.unexpectedStatusCode)
        XCTAssertNotEqual(RequestError.unauthorized, RequestError.unknown)
        XCTAssertNotEqual(RequestError.unexpectedStatusCode, RequestError.unknown)
    }
}

