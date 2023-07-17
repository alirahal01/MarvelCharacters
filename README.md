# MarvelCharacters
SwiftUI MVVM Demo Project using Marvel API for fetching marvel characters. 
> ***Project is still under construction***

# Goal
MarvelCharacters aims to develop a straightforward iOS app that presents a comprehensive list of marvel characters, along with a detailed view for each character. 

# Features
1- Marvel Characters List Screen
2- Marvel Character Details Screen
3- Pagination
4- Network Monitering
5- Firebase Integration

# Architecture 
MVVM (Model-View-ViewModel) was chosen as the architecture for this app due to its benefits. It provides a clear separation of concerns between the Model, View, and ViewModel components, improving code maintenance and understanding. MVVM facilitates testability, allowing for independent unit testing of each component, particularly the ViewModel. The architecture leverages data binding mechanisms to automatically update the UI when the Model changes, reducing manual synchronization. By combining MVVM with Swift's generics, the app achieves scalability, maintainability, and code reusability, resulting in a flexible and efficient codebase.

# Network Layer
I designed my network layer following Protocol-Oriented Programming (POP) principles, utilizing protocols for the request builder, parser, and executor components. This approach provides advantages such as modularity, flexibility, testability, code organization, and code reusability. It allows for clear separation of concerns, easy swapping of implementations, simplified testing, and improved code readability.

# API used
The app utilizes the Marvel API for retrieving the top stories.

# Device Support
This app supports iPhone only and in portrait mode.

