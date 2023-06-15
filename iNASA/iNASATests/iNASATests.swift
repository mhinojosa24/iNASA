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
    
    let mockString =
    """
    {
        "collection": {
            "version": "1.0",
            "href": "http://images-api.nasa.gov/search?q=eclipse&media_type=image",
            "items": [
                {
                    "href": "https://images-assets.nasa.gov/image/PIA10551/collection.json",
                    "data": [
                        {
                            "center": "JPL",
                            "title": "Enceladus in Eclipse",
                            "nasa_id": "PIA10551",
                            "date_created": "2009-01-07T13:50:41Z",
                            "keywords": [
                                "Enceladus",
                                "Cassini-Huygens"
                            ],
                            "media_type": "image",
                            "description_508": "Enceladus in Eclipse",
                            "secondary_creator": "NASA/JPL/Space Science Institute",
                            "description": "Enceladus in Eclipse"
                        }
                    ],
                    "links": [
                        {
                            "href": "https://images-assets.nasa.gov/image/PIA10551/PIA10551~thumb.jpg",
                            "rel": "preview",
                            "render": "image"
                        }
                    ]
                }
            ]
        }
    }
    """
    

    func testRequestFactory() throws {
        let r = GetSearchQuery(query: "mars")
        XCTAssertTrue(r.endpoint.url.scheme == "https")
        XCTAssertTrue(r.endpoint.url.path() == "/search")
        XCTAssertTrue(r.endpoint.url.query() == "q=mars&media_type=image")
        XCTAssertTrue(r.endpoint.url.host() == Bundle.main.infoDictionary?["SERVER_URL"] as? String ?? "")
    }
    

    
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
    
    func testGetImageSuccess() throws {
        let response = HTTPURLResponse(url: req.url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
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

class MockService: Service, Mockable {
    func request<T: Decodable>(_ resource: ApiRequest<T>, completionHandler: @escaping ApiHandler<T>)  {
        return loadJson(filename: "MockData",
                        extensionType: .json,
                        type: T.self) { result in
            switch result {
            case .success(let items):
                completionHandler(items, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}



