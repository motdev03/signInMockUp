import SwiftUI

// MARK: - Main View

struct SignInView<ViewModel: SignInViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    @State var formattedPhoneNumber: String = ""
    @FocusState var otpFocusState: Bool
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Spacer()
                Image("SignInHeader")
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Enter mobile number")
                            .font(.headline)
                        
                        Text("Please enter your mobile number to receive an OTP")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        textfieldStack
                        continueButton
                    }
                }
            }
            .padding()
            .padding(.bottom, 20)
            .background(Color.white)
            .padding()
        }
        .onAppear {
            viewModel.onAppear()
        }
        .alert("Sign In Successful", isPresented: $viewModel.showSuccessAlert) {
            Button("OK") {
                // Sign in navigation
            }
        } message: {
            Text("You have successfully signed in.")
        }
    }
    
    /// Creates the stack of textfields to input phone and otp depending on the state of the view.
    @ViewBuilder
    var textfieldStack: some View {
        TextField("Phone Number", text: $formattedPhoneNumber)
            .keyboardType(.numberPad)
            .textFieldStyle(BottomBorderTextFieldStyle())
            .padding(.top, 20)
            .onChange(of: formattedPhoneNumber) { _, newValue in
                viewModel.phoneNumber = newValue.unformattedPhoneNumber
                formattedPhoneNumber = newValue.formatPhoneNumber()
            }
        switch viewModel.state {
        case .otp:
            TextField("Enter OTP", text: $viewModel.otp)
                .keyboardType(.numberPad)
                .focused($otpFocusState)
                .textFieldStyle(BottomBorderTextFieldStyle())
                .padding(.top, 20)
                .transition(.opacity)
        default: EmptyView()
        }
    }
    
    /// Returns the bottom button to be shown. This
    var continueButton: some View {
        Button(action: {
            otpFocusState = false
            viewModel.submitButtonAction()
        }) {
            Text(viewModel.state.buttonTitle)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .cornerRadius(10)
        }
        .disabled(!viewModel.inputsValid)
        .opacity(viewModel.inputsValid ? 1: 0.6)
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
}

// MARK: - Preview

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel(
            signInServiceHandler: SignInServiceHandler()
        ))
    }
}
