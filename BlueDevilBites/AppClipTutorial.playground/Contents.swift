/*:
 # App Clips Tutorial for ECE 564 MOBILE APP DEVELOPMENT
 */
/*:
## Part 1: Prerequisites to get an App Clip

### A. Apple Developer Account with "individual" enroll status
 
You need an Apple Developer Account to successfully build an App Clip, which means you need either purchase an account from the [Apple Developer](https://developer.apple.com/) or perhaps obtain one from the Duke University. Notice that the account you obtained must have the "individual" enrolled status, enroll status like "developer" permission won't work (like the one we obtained from Duke University in the first time);
 
 To verify that you have the correct account to continue this tutorial, log in to the Apple Developer [Apple Developer](https://developer.apple.com/), enter the "Account" tab on the top, and scroll down to the Membership details section
 
 ![Developer Account](developer_account.png)
 
 ### B. Apple Connect Account with "Admin, Account Holder" role
 
 Using the account you purchased from the [Apple Developer](https://developer.apple.com/), log in to the [Apple Connect](https://appstoreconnect.apple.com/), and go to the [User and Access](https://appstoreconnect.apple.com/access/users) tab, clicked the "All" tab on the left, you should have "ROLE" include "Admin, Account Holder".
 
 ![Apple Connect Account](appleconnect_admin.png)
 
 
 ### C. App Clip Code Generator
 
 To create the App Clip Code for your app, you must create it using the App Clip Code Generator downloaded from the [Apple Developer Downloads](https://developer.apple.com/download/all/). You should see a page for you to input the software name and download. Type the "App Clip Code Generator" and you will see the software in the search list.
 
 ![App Clip Code Generator](appClipSearch.png)
 
 Notice that if you are not logged in a developer account with "Account Holder" role, you won't be able to see it. i.e. A free account won't work.
 
 ### D. iPhone device with latest iOS system installed & XCode with latest version
 
 The functionality of App Clips works only on version later than iOS 14.0. To make sure your phone uses the same code, update both your iPhone, and XCode to the latest version so you can test the App Clips on your iPhone using raw camera.
 
 ## Part 2: Build your main app & app clips
 
 ### A. Open the XCode, create a new iOS App project with SwiftUI as the interface, remember to use the correct team account.
 
 ![Create New Project](createNewProject.png)
 
 The creation of your main app has no difference with or without the App Clips. Just build the app however you planned to.
 
 ### B. Build an App Clip Target and add it to the main app project
 
 #### 1. Create an App Clip Target by File -> New -> Target...
 
 ![Create App Clip](createAppClip.png)
 
 #### 2. Search for the App Clip and click the next
 
 ![Search App Clip](searchAppClip.png)
 
 #### 3. Add the target to the main app project
 
 ![Add App Clip to the Project](addClip.png)
 
 ## Part 3: Test the App Clip
 
 ### A. After installed your App Clip Code Generator, create an App Clip Code using the terminal
 
 $ AppClipCodeGenerator generate --url https://appclip.example.com --index 9 --output /[YourPath]/filename.svg
 
 ![Command Line Tools Code](commandLine.png)
 
 Notice that if you want to customize the url, it needs to be on a public domain. Unless you are going to really publish the app, you can just use this demo one on default. Because we will test it in the local experiences, as long as you put the same url in the code and the app, you can load it with no problem.
 
 Here we show a App Clip Code we generated.
 
 ![App Clip Code](appclipcode.png)
 
 ### B. Connect the phone and build app & app clips
 
 Connect your phone to the Mac you are using, and select the device to your phone. If hinted for trust, click trust the computer. Hit Command + R to build both main app and the app clip to your phone. Notice: You can skip build the app clip if the app is published, otherwise you have to build it first to test it.
 
 ![Select Your Device](selectDevice.png)
 
 On your iPhone, open the settings and clicked the developer which located in the middle. Notice that the XCode might requires you to register the device first, feel free to do it by clcking on the error message and click "register".
 
 ![Find Developer in the Settings](developerSettings.png)
 
 In the developer settings, scroll down and find the local experiences, click it.
 
 ![Local Experiecnes in the Settings](localExperiencesSettings.png)
 
 Register a new local experience by click "Register Local Experiences".
 
 ![Register Local Experiences](registerLocalExp.png)
 
 Input the correct information. The URL must match with the App Clip Code, and the identifier should be the bundle identifider for your app clip. To look it up, click the project in the left file navigator, and you can find the bundle identifier for the App Clip.
 
 ![Find Identifier](findID.png)
 
 Change the Action into the view, input the title, description and a nice picture for your app clip.
 
 ![Input the local experiences](inputLocalExp.png)
 
 Then scan the App Clip Code on your computer, remember that both main app & app clip should already be installed on your iPhone before you do it.
 
 ![Scan the App Clip Code](scanCode.png)
 
 You will see a button appear, click it. The card for your app clip will appear.
 
 ![App Clip Card](raiseCard.png)
 
 Then click the view, you will go to the app clip view.
 
 ![Load then Clip](loadClip.png)
 
 ## Part 4: App Clip Programming
 
 ### A. Designing the App Clip Experience from setting the invocation URL
 - An App Clip experience is an entry point into your app that gets invoked using the URL. An App Clip always requires a corresponding full app, and after you submit your App Clip binary together with your full app’s binary to App Store Connect, you can configure a default App Clip experience.
 - Default App Clip links are URLs generated by Apple that invoke your App Clip without additional setup on your server. They follow this URL scheme:  https://appclip.apple.com/id?=<bundle_id>&key=value. Instead of the <bundle_id> placeholder, your default App Clip links include the bundle ID of your app and, optionally, parameters you set, represented as &key=value.

 - Before we finish all the work and submit the app to App Store Connect, we can create a launch URL for testing. This allows you to simulate launching the App Clip from an App Clip experience URL. To create one, just edit the app clip scheme and enable the _XCAppClipURL Environment Variable by clicking the checkbox. Finally, set its value to the URL you created.
 
 ![edit scheme](editscheme.jpg)
 
 ![environment variable](environmentvariable.png)
 
 - In this tutorial, you’ll launch an App Clip experience URL at one of restaurants, showing the info and accepting comments.
 
 ### B. Parsing the invocation URL
 
 #### 1. Create data model for app clip
 - Create a data model class that conforms to ObservableObject. You have also added a @Published property to notify your App Clip of a selected restaurant. Then instantiate your model.
 
 */
class blueclipModel: ObservableObject {
    @Published var resID: Int = 0
}
@StateObject private var clipModel = blueclipModel()
/*:

 - Then you should supply this property to the child views of the App Clip.
 
 #### 2. Parse the invocation URL
 - When a user interacts with your app through a link or activity associated with a web page, the NSUserActivity object contains information about the interaction, including the URL that led the user to your app. Parsing this URL is essential for your app to respond appropriately to the user's context. Replace body with the following to get the information from the URL:
 */
var body: some Scene {
    WindowGroup {
        ContentView()
            .environmentObject(clipModel)
            .onContinueUserActivity(
                NSUserActivityTypeBrowsingWeb,
                perform: handleUserActivity)
       }
}

func handleUserActivity(_ userActivity: NSUserActivity) {
    guard
        let incomingURL = userActivity.webpageURL,
        let components = URLComponents(
          url: incomingURL,
          resolvingAgainstBaseURL: true),
        let queryItems = components.queryItems
    else {
        return
    }

    guard
        let idValue = queryItems.first(where: { $0.name == "id" })?.value,
        let id = Int(idValue)
    else {
        return
    }
    clipModel.resID = id
}
/*:
 - Register a handleUserActivity for NSUserActivityTypeBrowsingWeb. iOS invokes this handler when it encounters an App Clip experience URL. Process the URL data via queryItems in the function handleUserActivity. If the information getting from the URL is valid, assign it to your app clip data model. Then you can build your own ContentView in the app clip.
 
 ### C. Sharing Assets, Code, Variables Between Targets
 An App Clip is a lightweight version of an app that is designed to provide a specific functionality or content without requiring users to download the full app. So App Clips are separate entities from the full app. There are methods sharing assets, code, and variables between targets
 
 #### 1. Sharing Assets and Code Between Targets
 - If you just want to share assets and code between app and app clip, you can just click the swift file you want in the Project navigator and update the target membership in the File inspector to include the app clip target:
 
 ![share code](sharecode.png)
 
 #### 2. Sharing Variables Between Targets
 - If you want to share variables between app and app clip, things can be a bit tricky. Even though we already have shared code with the main app, you can't call a variable instantiated in the main app. Especially if you have a variable with @environment property wrapper, you must want to obtain it where you want. Here are several methods.
 - App Groups: App Groups allow different apps from the same developer to access a shared container. You can create a shared App Group between your app and its App Clip, and use UserDefaults to store and retrieve data.
 
 **Step 1:** Set up an App Group in the Apple Developer portal. Go to "Certificates, Identifiers & Profiles". Under "Identifiers", select "App Groups" and create a new App Group. Give it a unique identifier.

 **Step 2:** Still in the developer portal, find your App and App Clip identifiers. Then edit each identifier and enable the App Group capability, then select the App Group you just created.
 
 **Step 3:** Select the target for your main App and go to the "Signing & Capabilities" tab. Click the "+" button to add a new capability and choose "App Groups". Check the box next to the App Group you created. Repeat these steps for your App Clip target.
 
 **Step 4:** Use UserDefaults with the App Group. Here's an example of how you can use this:
 */
// Writing Data
if let sharedDefaults = UserDefaults(suiteName: "group.com.yourcompany.shareddefaults") {
    // Set a value for a key
    sharedDefaults.set("yourValue", forKey: "yourKey")
    // Synchronize is not needed in most cases, but if you want to force the data to be written immediately, you can use it.
    sharedDefaults.synchronize()
}
// Reading Data
if let sharedDefaults = UserDefaults(suiteName: "group.com.yourcompany.shareddefaults") {
    // Retrieve a value for a key
    if let value = sharedDefaults.string(forKey: "yourKey") {
        print("Retrieved value: \(value)")
    }
}
/*:
 
 - iCloud Key-Value Store: If your App and App Clip are associated with the same iCloud Container, you can use the iCloud Key-Value Store to share small amounts of data in a key-value pair manner.
 */
 // save data
NSUbiquitousKeyValueStore.default.set(value, forKey: "YourKey")
 // retrieve data
let value = NSUbiquitousKeyValueStore.default.object(forKey: "YourKey")

/*:
 
 - Server-Side Integration: Another common method is to use your own server to manage shared data. Both the App and the App Clip would authenticate with your server and sync data as needed. This method is more scalable and not limited to the size restrictions of the above options.
 
 
 ## Part 5: More about App Clip
 
 See more about App Clip here. [Creating an App Clip with XCode ](https://developer.apple.com/documentation/app_clips/creating_an_app_clip_with_xcode) from Apple.

### A. Definition and Overview

App Clips are a part of Apple's iOS platform that allow users to quickly access and interact with a small part of an app. They're designed to be fast and lightweight, making them a great choice for performing a specific task like renting a bike, paying for parking, or ordering food.

#### 1. What are App Clips?

App Clips are small, lightweight parts of your app that let users start and finish an experience in seconds. While they're a part of your app, they're not the full app. They are fast to open and provide a focused, relevant experience.

#### 2. Brief history and evolution in iOS

App Clips were introduced in iOS 14, marking a significant evolution in the iOS ecosystem. They allow for quick interactions without the need for downloading the full app, providing a seamless user experience.

### B. Importance in Modern iOS Development

#### 1. Advantages for users and developers

- **For Users:** Quick access to app functionalities without downloading the full app.
- **For Developers:** Increased exposure and potential user engagement without the need for a full app download.

#### 2. Use cases and real-world applications

App Clips can be used in various scenarios like electronic commerce, parking, and food ordering. These use cases show the versatility and utility of App Clips in everyday life.

*/

// Code Example: Basic structure of an App Clip in Swift

/*:
Let's look at a SwiftUI implementation for an App Clip.
*/

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Welcome to the App Clip!")
            .font(.title)
            .padding()
        // Additional UI components and logic for your parking App Clip
    }
}

/*:
 ## Part 6: Technical Overview of App Clips
 
 ### A. Architecture and Components
 App Clips are a great way for users to quickly access and interact with a part of your app. Understanding the architecture and components is crucial for efficient development.
 
 #### 1. Core Components of an App Clip
 An App Clip is essentially a small part of your app that’s discoverable at the moment it’s needed.
 */

// Example Code: Core Components
struct AppClipView: View {
    var body: some View {
        Text("This is an App Clip")
    }
}

/*:
 #### 2. Relationship with the Full App
 While an App Clip is a part of the app, it is not the full app. The App Clip and the full app share the same bundle ID but have separate targets in Xcode.
 */

// Example Code: Relationship with Full App
struct FullAppView: View {
    var body: some View {
        Text("This is the Full App")
    }
}

/*:
 ### B. Size Limitations and Performance
 It’s important to keep your App Clip small, as the size impacts download speed and responsiveness.
 
 #### 1. Understanding Size Constraints
 The maximum size for an App Clip is 10 MB. This requires careful planning of resources and functionalities included in the App Clip.
 */

/*:
 #### 2. Optimizing for Fast Downloads and Launches
 To ensure a good user experience, focus on optimizing your App Clip for quick downloads and launches. This involves efficient coding practices and asset management.
 */
/*:
## Part 7: Future of App Clips

### A. Emerging Trends and Predictions

The role of App Clips in iOS development is continually evolving. With each new iOS version, Apple introduces enhancements that can significantly impact how developers use App Clips.

#### 1. The evolving role of App Clips in iOS development

Consider how App Clips can become more integrated with core app functionalities, offering a seamless transition for users from the clip to the full app. Also, the increasing focus on privacy and security in iOS might influence how App Clips function.

*/

import SwiftUI
import RealityKit

/*:
### B. Integrating with New Technologies

App Clips offer a unique opportunity to integrate with cutting-edge technologies like Augmented Reality (AR), Virtual Reality (VR), and the Internet of Things (IoT). These integrations can provide immersive and interactive experiences for users in a variety of contexts.

#### 1. AR, VR, and IoT possibilities

Below is a basic SwiftUI view that could be used as a starting point for an App Clip leveraging AR capabilities. This example demonstrates how to create a simple AR experience within an App Clip.

*/

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        return ARView(frame: .zero)
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ContentView7: View {
    var body: some View {
        ARViewContainer()
            .edgesIgnoringSafeArea(.all)
    }
}

/*:
This is a very basic AR setup. In a real-world App Clip, you would add more interactive elements and possibly integrate IoT devices, allowing users to interact with their environment in novel ways.

Remember, the key to a successful App Clip is to provide a focused, fast, and engaging experience that encourages users to download the full app for more features.

*/
