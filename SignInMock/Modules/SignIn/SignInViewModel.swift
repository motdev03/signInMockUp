//
//  SignInViewModel.swift
//  SignInMock
//
//  Created by Tom Manuel on 29/08/24.
//

import Foundation
import Combine

// MARK: - ViewModel Protocol

protocol SignInViewModelProtocol: ObservableObject {
    /// Tracks the state of the view using `State` enum
    var state: SignInViewModel.State { get set }
    /// A published property to store the phone number input in the view.
    var phoneNumber: String { get set }
    /// A published property to store the otp input in the view.
    var otp: String { get set }
    /// A published bool to show/hide an alert in the view.
    var showSuccessAlert: Bool { get set }
    /// Returns a bool indicating if the view inputs are valid and has no error.
    var inputsValid: Bool { get }

    /// This function can be invoked from the view when the view appears.
    func onAppear()
    /// Handles the submit button action, either moving to OTP entry or initiating sign-in.
    func submitButtonAction()
}

// MARK: - Concrete ViewModel

/// This SignInViewModel class implements the SignInViewModelProtocol and manages the sign-in process using a phone number and OTP (One-Time Password)
class SignInViewModel: SignInViewModelProtocol {
    // MARK: ----------Properties----------
    
    // MARK: SignInViewModelProtocol
    
    /// Tracks the state of the view using `State` enum
    @Published  var state: State = .phone
    /// A published property to store the phone number input in the view.
    @Published var phoneNumber = ""
    /// A published property to store the otp input in the view.
    @Published var otp = ""
    /// A published bool to show/hide an alert in the view.
    @Published var showSuccessAlert: Bool = false
    /// Returns a bool indicating if the view inputs are valid and has no error.
    var inputsValid: Bool {
        switch state {
        case .phone:
            return phoneNumber.validPhonenumber
        case .otp:
            return otp.count == 5 && phoneNumber.validPhonenumber
        }
    }
    
    // MARK: Private properties
    /// Stores the subscriber for the phoneNumber published property.
    private var phoneNumberCancellable: Cancellable?
    /// Private Service Handler property injected to handle sign in api.
    private var serviceHandler: SignInServiceHandling
    
    // MARK: ----------Methods----------
    
    /// Initializer
    /// - Parameter signInServiceHandler: service handler injected to handle signin api. Could inject mock handlers while testing.
    init(signInServiceHandler: SignInServiceHandling) {
        self.serviceHandler = signInServiceHandler
    }
    
    // MARK: SignInViewModelProtocol
    /// This function can be invoked from the view when the view appears.
    func onAppear() {
        // Add the subscribers.
        self.setPhoneNumberSubscriber()
    }
    
    /// Handles the submit button action, either moving to OTP entry or initiating sign-in.
    func submitButtonAction() {
        // Here you would typically send the phone number to your backend
        // and request an OTP to be sent to the user
        switch state {
        case .phone:
            resetViewState(isPhoneNumberChanged: false)
        case .otp:
            Task {
                await signIn()
            }
        }
    }
    
    // MARK: Private Helpers
    /// Sets up a subscriber to observe phone number changes.
    private func setPhoneNumberSubscriber() {
        self.phoneNumberCancellable = $phoneNumber.sink { [weak self] _ in
            self?.resetViewState(isPhoneNumberChanged: true)
        }
    }
    
    /// Updates the `state` based on phone number validity.
    private func resetViewState(isPhoneNumberChanged: Bool) {
        guard !isPhoneNumberChanged else {
            self.state = .phone
            return
        }
        self.state = phoneNumber.validPhonenumber ? .otp: .phone
    }
    
    /// Asynchronously attempts to sign in using the service handler.
    private func signIn() async {
        guard inputsValid, state == .otp else {
            return
        }
        do {
            try await serviceHandler.signIn(otp: otp, phone: phoneNumber)
            await showSuccessAlert(true) // show an alert.
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Updates the success alert state on the main actor.
    @MainActor
    private func showSuccessAlert(_ show: Bool) {
        self.showSuccessAlert = show
    }
}

extension SignInViewModel {
    enum State {
        case phone, otp
        
        var buttonTitle: String {
            switch self {
            case .phone: return "Send OTP"
            case .otp: return "Sign In"
            }
        }
    }
}

