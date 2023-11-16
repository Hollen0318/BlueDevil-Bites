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
                    
                    // New section for Comments
                    if let comments = resDataModel.comments[restaurant.placeId!], !comments.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Comments")
                                .font(.headline)
                                .padding(.leading, 10)
                            ForEach(comments.indices, id: \.self) { index in
                                CommentView(comment: comments[index])
                                    .frame(width: geometry.size.width)
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct MapView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

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
            CommentData(username: "Bob", content: "", score: 3),
            CommentData(username: "Charlie", content: "Amazing fries, would visit again.", score: 4),
            CommentData(username: "Hollen", content: "The BlueDeivil Bite App Demo is here, it is working great and I am seriously considering using it for a prolonged time", score: 5)
        ]

        // Pass the sample restaurant and data model to the RestaurantDetailView
        return RestaurantDetailView(restaurant: sampleRestaurant)
            .environmentObject(sampleDataModel)
    }
}
