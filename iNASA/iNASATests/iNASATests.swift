//
//  iNASATests.swift
//  iNASATests
//
//  Created by Maximo Hinojosa on 6/9/23.
//

import XCTest
@testable import iNASA


final class iNASATests: XCTestCase {
    var urlSession: URLSession!
    var mockService: MockService!
    let req = MockApiRequest(query: "eclipse")

    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockService = MockService()
    }
    
    override func tearDown() {
        urlSession = nil
        mockService = nil
        super.tearDown()
    }
    
    func testRequestFactory() throws {
        let r = GetSearchQuery(query: "mars")
        XCTAssertTrue(r.endpoint.url.scheme == "https")
        XCTAssertTrue(r.endpoint.url.path() == "/search")
        XCTAssertTrue(r.endpoint.url.query() == "q=mars&media_type=image")
        XCTAssertTrue(r.endpoint.url.host() == Bundle.main.infoDictionary?["SERVER_URL"] as? String ?? "")
    }
    
    func testGetImageSuccess() throws {
        let response = HTTPURLResponse(url: req.url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"]) ?? HTTPURLResponse()
        
        let mockData: Data = mockService.loadJsonData(filename: "MockData", extensionType: .json) ?? Data()
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        mockService.request(req) { items, error in
            if let error = error {
                XCTAssertThrowsError(error)
            }
            
            if let items = items {
                XCTAssertEqual(items.first?.data?.first?.nasaId, "PIA10551")
                expectation.fulfill()
            }
        }
    }
}
