//
//  SignInViewModelTests.swift
//  SignInMockTests
//
//  Created by Tom Manuel on 29/08/24.
//

import XCTest
@testable import SignInMock

final class SignInViewModelTests: XCTestCase {
    
    var viewModel: SignInViewModel!
    var mockServiceHandler: MockSignInServiceHandler!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockServiceHandler = MockSignInServiceHandler()
        viewModel = SignInViewModel(signInServiceHandler: mockServiceHandler)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockServiceHandler = nil
        super.tearDown()
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
    
    
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testInitialState() {
        XCTAssertEqual(viewModel.state, .phone)
        XCTAssertEqual(viewModel.phoneNumber, "")
        XCTAssertEqual(viewModel.otp, "")
        XCTAssertFalse(viewModel.showSuccessAlert)
    }
    
    func testInputsValidForPhoneState() {
        viewModel.phoneNumber = "1234567890"
        XCTAssertTrue(viewModel.inputsValid)
        
        viewModel.phoneNumber = "123"
        XCTAssertFalse(viewModel.inputsValid)
    }
    
    func testInputsValidForOTPState() {
        viewModel.state = .otp
        viewModel.phoneNumber = "1234567890"
        viewModel.otp = "12345"
        XCTAssertTrue(viewModel.inputsValid)
        
        viewModel.otp = "1234"
        XCTAssertFalse(viewModel.inputsValid)
    }
    
    func testSubmitButtonActionForPhoneState() {
        viewModel.phoneNumber = "1234567890"
        viewModel.submitButtonAction()
        XCTAssertEqual(viewModel.state, .otp)
    }
    
    func testSubmitButtonActionForOTPState() {
        viewModel.state = .otp
        viewModel.phoneNumber = "1234567890"
        viewModel.otp = "12345"
        
        let expectation = XCTestExpectation(description: "Sign in completed")
        viewModel.submitButtonAction()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.viewModel.showSuccessAlert)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testPhoneNumberSubscriber() {
        viewModel.state = .otp
        viewModel.phoneNumber = "9876543210"
        
        let expectation = XCTestExpectation(description: "State updated")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.state, .phone)
            expectation.fulfill()
        }
    }
}

// Mock SignInServiceHandling for testing
class MockSignInServiceHandler: SignInServiceHandling {
    @discardableResult func signIn(otp: String, phone: String) async throws -> User {
        return .init()
    }
}
