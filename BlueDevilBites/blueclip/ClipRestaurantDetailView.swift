//
//  RestaurantDetailView.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/15/23.
//
import SwiftUI
import MapKit
import WebKit

struct ClipRestaurantDetailView: View {
    @EnvironmentObject var model: blueclipModel
//    var comments: [CommentData]
    // State variables to store form data
    @State private var score: Int = 0
    @State private var commentContent: String = ""
    @State private var commenterName: String = ""
    @State private var showingSuccessAlert = false

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Image("\(model.selectedRes!.name)_1") // Use the restaurant's name with the index
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height / 3)
                    
                    Text(model.selectedRes!.name)
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading, 10)
                    
                    HStack {
                        Image(systemName: "house")
                        Text("\(model.selectedRes!.location)")
                            .bold()
                    }
                    .padding(.leading, 10)
                
                    HStack {
                        Image(systemName: "menucard")
                        // Check for both nil and empty string
                        Text("Status:")
                            .bold()
                        
                        Text(model.selectedRes!.isOpen ? "Open" : "Closed")
                                .bold()
                                .foregroundColor(model.selectedRes!.isOpen ? .green : .red)
                    }
                    .padding(.leading, 10)
                    
                    // Updated code for handling phone number
                    HStack {
                        Image(systemName: "phone.fill")
                        // Check for both nil and empty string
                        Text((model.selectedRes!.phone?.isEmpty ?? true) ? "N/A" : model.selectedRes!.phone!)
                            .bold()
                    }
                    .padding(.leading, 10)
                    
                    if let googleMapURL = model.selectedRes!.position.googleMap,
                       let url = URL(string: googleMapURL) {
                        Link(destination: url) {
                            HStack {
                                Image(systemName: "map") // Or use a custom image
                                Text("Navigate via Google Map")
                            }
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                        }
                        .padding(.leading, 10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Comments")
                            .font(.headline)
                            .padding(.leading, 10)
                        if (!model.selectedCom.isEmpty) {
                            ForEach(model.selectedCom.indices, id: \.self) { index in
                                CommentView(comment: model.selectedCom[index])
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
        let restaurantID = model.selectedRes!.placeIdString // Replace with actual property name
        model.selectedCom.append(commentData)
        
        // Prepare URL and URLRequest
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
