//
//  URLShortenerAppTests.swift
//  URLShortenerAppTests
//
//  Created by PiPyL on 1/20/20.
//  Copyright © 2020 PiPyL. All rights reserved.
//

import XCTest
@testable import URLShortenerApp

class URLShortenerAppTests: XCTestCase {

    var viewController: ViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateInitialViewController() as! ViewController
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testURLStringIsValidate() {
        var urlString = viewController.isValidate(urlString: "")
        XCTAssert(urlString == false)
        
        urlString = viewController.isValidate(urlString: "Dont is url")
        XCTAssert(urlString == false)
        
        urlString = viewController.isValidate(urlString: "facebook")
        XCTAssert(urlString == false)
        
        urlString = viewController.isValidate(urlString: "facebook.com")
        XCTAssert(urlString == true)
    }
    
    func testGetURLShorterner() {
        
        NetworkController.getURLShortener(urlString: "facebook.com") { (error, urlShorterner) in
            if let url = urlShorterner {
                XCTAssert(url != "")
            } else {
                XCTAssert(error != nil)
            }
        }
    }

}
