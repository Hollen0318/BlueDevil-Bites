//
//  RestaurantDetailView.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/15/23.
//
import SwiftUI
import MapKit
import WebKit

struct RestaurantDetailView: View {
    var restaurant: Res
    @EnvironmentObject var resDataModel: ResDataModel
    
    // State variables to store form data
    @State private var score: Int = 0
    @State private var commentContent: String = ""
    @State private var commenterName: String = ""
    @State private var showingSuccessAlert = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Image("\(restaurant.name)_1") // Use the restaurant's name with the index
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height / 3)
                    
                    Text(restaurant.name)
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading, 10)
                    
                    
                    // Updated code for handling phone number
                    HStack {
                        Image(systemName: "phone.fill")
                        // Check for both nil and empty string
                        Text((restaurant.phone?.isEmpty ?? true) ? "N/A" : restaurant.phone!)
                            .bold()
                    }
                    .padding(.leading, 10)
                
                    
                    Text("Location: \(restaurant.location)")
                        .bold()
                        .padding(.leading, 10)
                    
                    HStack {
                        Text("Status: ")
                            .bold()
                        
                        Text(restaurant.isOpen ? "Open" : "Closed")
                                .bold()
                                .foregroundColor(restaurant.isOpen ? .green : .red)
                    }
                    .padding(.leading, 10)
                    
                    if let googleMapURL = restaurant.position.googleMap,
                       let url = URL(string: googleMapURL) {
                        Link(destination: url) {
                            HStack {
                                Image(systemName: "map") // Or use a custom image
                                Text("Open in Google Maps")
                            }
                            .padding()
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                        }
                        .padding(.leading, 10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Comments")
                            .font(.headline)
                            .padding(.leading, 10)
                        
                        if let comments = resDataModel.comments[restaurant.placeId!], !comments.isEmpty {
                            ForEach(comments.indices, id: \.self) { index in
                                CommentView(comment: comments[index])
                                    .frame(width: geometry.size.width)
                            }
                        } else {
                            Text("No comments yet") // Add this line
                                .padding(.leading, 10)
                        }
                    }
                    
                    // New Review Submission Form
                    VStack {
                        Text("Leave a review")
                            .font(.headline)
                            .padding()

                        StarRatingView(score: $score) // Custom view for star rating
                            .padding()

                        TextField("Your Name", text: $commenterName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()

                        TextEditor(text: $commentContent)
                            .frame(minHeight: 100) // Adjust the minimum height as needed
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()


                        Button("Submit") {
                            submitReview()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            .ignoresSafeArea()
        }
        .alert(isPresented: $showingSuccessAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Your review has been successfully submitted."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    // Function to handle review submission
    private func submitReview() {
        let commentData = CommentData(username: commenterName, content: commentContent, score: score)
        let restaurantID = restaurant.placeIdString // Replace with actual property name

        // Prepare URL and URLRequest
        let vaporAccessToken = "hz271"
        guard let url = URL(string: "http://\(vaporServerAddress)/comments/\(restaurantID)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Serialize the CommentData
        guard let uploadData = try? JSONEncoder().encode(commentData) else {
            return
        }

        // Create URLSession data task
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                // Handle error scenario
                print("Error: \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                // Handle server error scenario
                print("Server error")
                return
            }
            // Handle successful scenario, parse the response data if needed
            if let mimeType = response.mimeType, mimeType == "application/json",
               let data = data {
                // Optionally handle the response data
                print("the uploaded data is \(data)")
                resDataModel.updateData()
                // State variables to store form data
                score = 0
                commentContent = ""
                commenterName = ""
                showingSuccessAlert = true
            }
        }
        // Start the task
        task.resume()
    }

}

//struct MapView: UIViewRepresentable {
//    var url: URL
//
//    func makeUIView(context: Context) -> some UIView {
//        let webView = WKWebView()
//        webView.load(URLRequest(url: url))
//        return webView
//    }
//
//    func updateUIView(_ uiView: UIViewType, context: Context) {}
//}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample restaurant
        let sampleRestaurant = Res(
            placeIdString: "1",
            isOpenString: "true",
            name: "McDonald's",
            position: Res.Position(latitude: "35.9980", longitude: "-78.9382", googleMap: "http://maps.google.com"),
            location: "123 Duke St",
            phone: "919-123-4567",
            tags: ["Fast Food", "Burgers", "Fries"]
        )

        // Create a sample data model with comments
        let sampleDataModel = ResDataModel()
        sampleDataModel.comments[sampleRestaurant.placeId!] = [
            CommentData(username: "Alice", content: "My favorite restaurant at Duke", score: 5),
            CommentData(username: "Bob", content: "Nice position but way too crowded and under staffed", score: 3),
            CommentData(username: "Charlie", content: "Amazing fries, would visit again.", score: 4),
            CommentData(username: "Hollen", content: "The BlueDeivil Bite App Demo is here, it is working great and I am seriously considering using it for a prolonged time", score: 5)
        ]

        // Pass the sample restaurant and data model to the RestaurantDetailView
        return RestaurantDetailView(restaurant: sampleRestaurant)
            .environmentObject(sampleDataModel)
    }
}
