# signInMockUp
A mockup sign in screen using SwiftUI, Combine and Swift Concurrency.

Tech Stack
1. IDE - XCode.
2. Language - Swift 5.10
3. SwiftUI for UI creation.
4. Architecture - MVVM, clean code and Protocol Oriented Programming.
5. Combine for reactive MVVM setup.
6. Swift concurrency for async tasks.
7. Unit testing using XCTest.

Further Improvements.
1. As the app grows add more layers for use cases, entity etc to fully embrace clean code architecture.
2. Better keyboard handling to make the buttons fully visible.
3. Proper input field for inputting otp.

What is included.
1. On inputting a valid phone number, an otp field is displayed. Phone number input has proper formatting and has a basic validation to check if the number of digits is 10.
2. The otp field expects 5 digits. Once inputted the sign in button is enabled.
3. On clicking sign in a mock service layer is invoked to receive a user object.
4. The screen maintains two states - one for phone input and the second for otp input.

Screens

![Screenshot](https://github.com/user-attachments/assets/06b83a8f-f323-4c1d-99e8-a49795a56cc2)


https://github.com/user-attachments/assets/3768d247-e732-4eb1-b23c-8819031e589d

