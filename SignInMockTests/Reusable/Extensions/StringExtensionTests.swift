//
//  StringExtensionTests.swift
//  SignInMockTests
//
//  Created by Tom Manuel on 29/08/24.
//

import XCTest
@testable import SignInMock

final class StringExtensionTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFormatPhoneNumber() {
        // Test case 1: Full 10-digit number
        XCTAssertEqual("1234567890".formatPhoneNumber(), "(123) 456-7890")
        
        // Test case 2: Partial number
        XCTAssertEqual("12345".formatPhoneNumber(), "(123) 45")
        
        // Test case 3: Number with non-digit characters
        XCTAssertEqual("1a2b3c4d5e6f7g8h9i0j".formatPhoneNumber(), "(123) 456-7890")
        
        // Test case 4: Empty string
        XCTAssertEqual("".formatPhoneNumber(), "")
        
        // Test case 5: Number longer than mask
        XCTAssertEqual("12345678901234".formatPhoneNumber(), "(123) 456-7890")
        
        // Test case 6: Custom mask
        XCTAssertEqual("1234567890".formatPhoneNumber(mask: "XX-XXX-XXXX"), "12-345-6789")
        
        // Test case 7: International number format
        XCTAssertEqual("1234567890".formatPhoneNumber(mask: "+X (XXX) XXX-XXXX"), "+1 (234) 567-890")
    }
    
    func testPhoneNumberValidation() {
        // Valid phone number
        XCTAssertTrue("1234567890".validPhonenumber, "A 10-digit number should be valid")
        
        // Invalid: Too short
        XCTAssertFalse("123456789".validPhonenumber, "A 9-digit number should be invalid")
        
        // Invalid: Contains letters
        XCTAssertFalse("123456789a".validPhonenumber, "A number with letters should be invalid")
        
        // Invalid: Empty string
        XCTAssertFalse("".validPhonenumber, "An empty string should be invalid")
    }
}
