//
//  SignInAPIHandler.swift
//  SignInMock
//
//  Created by Tom Manuel on 29/08/24.
//

import Foundation

/// Protocol defining the interface for handling sign-in operations
protocol SignInServiceHandling {
    /// Attempts to sign in a user with the provided OTP and phone number
    /// - Parameters:
    ///   - otp: The one-time password entered by the user
    ///   - phone: The phone number of the user
    /// - Returns: A User object representing the signed-in user
    /// - Throws: An error if the sign-in process fails
    @discardableResult func signIn(otp: String, phone: String) async throws -> User
}

/// Concrete implementation of the SignInServiceHandling protocol
struct SignInServiceHandler: SignInServiceHandling {
    /// Implements the sign-in functionality
    /// - Parameters:
    ///   - otp: The one-time password entered by the user
    ///   - phone: The phone number of the user
    /// - Returns: A new User instance (currently just a placeholder)
    /// - Note: This implementation is a stub and should be replaced with actual sign-in logic
    @discardableResult func signIn(otp: String, phone: String) async throws -> User {
        return .init()
    }
}
