# CommentsAPIExample
Example of using the API to post comments
## Third-party libraries <br>
Library are managed using Cocoapods. To include the necessary modules in your project, follow the instructions below:
- Add the module as a dependency to your project using **CocoaPods** or **Swift Package Manager**
- Import the module into your project.
1. **Alamofire**: Is an open-source networking library that simplifies the process of sending HTTP requests and handling responses. In the app, it is used to send requests and receive responses from the server to the client.
   - [Alamofire GitHub](https://github.com/Alamofire/Alamofire.git)
   - Add it to your Podfile:
     ```bash
      pod 'Alamofire'
     ```
2. **SnapKit**: Basically adds syntactic sugar over the native auto layout code, which makes understanding and writing auto layout code easier. In the app, it is used to make the code more intuitive and easier to maintain. 
   - [SnapKit GitHub](https://github.com/SnapKit/SnapKit.git)
   - Add it to your Podfile:
     ```bash
      pod 'Snapkit'
## Structure and Architecture
- Component Diagram <br>
<p align="center">
   <img src="https://github.com/user-attachments/assets/85369c03-cfad-4f14-8384-98c9b65fc41f" alt="url drawio" />
</p>

> The relationship between different components in a system
### Explanation of the Architecture:
1. **View**
   - **Definition**: The UI layer where data is displayed to users interactions are captured.
   - **Interaction**: Sends user inputs to the `ViewModel` and displays the data processed by the `ViewModel`
2. **ViewModel**
   - **Definition**: Serves as a bridge between the `View` and the `UseCase`. It prepares data for display and processes user actions.
   - **Interaction**: Receives data from the `UseCase`, forwards it to the `View`, and sends user actions to the `UseCase`.
3. **UseCase**
   - **Definition**: Contains the application's business logic. It processes request from the `ViewModel` and interacts with the `Repository` to fetch or manipulate data.  
   - **Interaction**: Communicates with the `Repository` to retrieve or update data, and return processed data to the `ViewModel`.
4. **Repository**
   - **Definition**: Manages data from various sources and provides a unified API for data access and updates.
   - **Interaction**: Retrievies data from `Local` or `Remote` sources and provides it to the `UseCase`. It also handles data updates in `Local` or `Remote` storage.
5. **Local (DataSource)**
   - **Definition**: Represents local storage solutions, sush as Core Data or SQLite databases
   - **Interaction**: Stores and retrieves data locally to support offline access and optimize performance.
6. **Remote (Network)**
   - **Definition**: Represents remote data source, such as APIs or web services.
   - **Interaction**: Manages network request and response, providing data from external servers to the `Repository`
7. **Models**:
   - **Definition**: Data objects that represent the structure of data used across the applicaiton.
   - **Interaction**: Utilized by the `Repository` to represent data retrieved from of sent to `Local` and `Remote` sources.
    
## Design Pattern
### MVVM (Model-View-ViewModel)
  - **Model**: Represents the data and business logic.
  - **View**: Displays the data and handles user interface elements.
  - **ViewModel**: Manages the data for the view and provides a way to bind the data to the view. It also handles user interactions and updates the model accordingly.
### Signleton
  - Ensures a class has only one instance throughout the app.
  - Provides a single access point for functionality and is initialized only on first use.
### Dependency Injection
  - Involves passing dependencies (services or object) to a class rather than creating them within the class. This promotes better testability and modularity.
## Database
### CoreData
An object-oriented framework for managing and persisting data within the app. In the app, it is used to display the camera list when there is no network connection.
- **Entities**: Represents the structure of the data stored in the database. For example, a `Camera` entity with attributes such as `id`, `name`, and `status`.
- **Managed Object Context**: The environment in which Core Data objects are managed. The context is responsible for tracking changes to objects and saving these changes to the persistent store.
- **Persistent Store Coordinator**: Coordinates access to the persistent store, managing the SQLite database file that backs the Core Data storage.
### UseDefautl
Is a convenient ưay to store small amounts of data in iOS, macOS, watchOS, and tvOS. You can use it to store simple data types such as strings, numbers, and booleans, as well as more complex data types such as arrays and dictionaries.
  - **Key-Value Storage**: Data is stored as key-value pairs, making it easy to save and retrieve information without needing to manage complex data structures.

## Environment Setup
### Prerequisites
- **Xcode**: Version 14.0+
- **Swift**: Version 5.0+
- **CocoaPods**: Version 1.9.0+
- **Simulator**: recommend Version 17.2

### Tools
- **Xcode**: Primary IDE for IOS development.
- **Swiftline**: Ensures coding standards and linting.
- **Fastlane**: Automates builds and deployments.

## Configuration
### API Endpoints
- **Development**: `https://jsonplaceholder.typicode.com/posts/1/comments`

### Environment Variables
Set environment-specific variables in the `Info.plist` or use a configuration management tool.

## Installation and Setup
### Step 1: Clone the Repository <br>
Clone the project from the repository:
```bash
git clone https://github.com/dotam5020/CommentsAPIExample.git
cd CommentsAPIExample
```
### Step 2: Install Dependencies <br>
Install project dependencies using CocoaPods:
```bash
pod install
```
### Step 3: Open the Project <br>
Open the project using the `.xcworkspace` file:
```bash
open CommentsAPIExample.xcworkspace
```
### Step 4: Build and Run <br>
Select the target device or simulator and run the project:
- Use `Cmd + R` to build and run the app.

## Respectful Usage of Xcode and Swift
- **Adhere to Best Practices**: Ensure code quality and modularity.
- **Fllow Established Coventions**: Maintain consistency across the codebase.
- **Frequent Commits**: Use meaningful commit messages and follow the branching strategy.

## Additional Resources:
- [Swift Documentation](https://developer.apple.com/documentation/swift/)
- [Xcode User Guide](https://developer.apple.com/documentation/xcode)
- [Firebase Setup Guide](https://firebase.google.com/docs/ios/setup)
