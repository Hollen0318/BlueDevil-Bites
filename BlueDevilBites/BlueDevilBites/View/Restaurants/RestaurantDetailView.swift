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

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(restaurant.name)
                    .font(.largeTitle)
                    .bold()

                if let phone = restaurant.phone {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text(phone)
                    }
                }

                Text("Location: \(restaurant.location)")
                Text("Open Now: \(restaurant.isOpen ? "Yes" : "No")")

                if let googleMapURL = restaurant.position.googleMap,
                   let url = URL(string: googleMapURL) {
                    MapView(url: url)
                        .frame(height: 300)
                }

                HStack {
                    Text("Tags: ")
                    ForEach(restaurant.tags, id: \.self) { tag in
                        Text(tag)
                            .padding(5)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
            }
            .padding()
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
        // Pass a sample restaurant data for preview
        RestaurantDetailView(restaurant: Res(
            placeIdString: "1",
            isOpenString: "true",
            name: "Sample Restaurant",
            position: Res.Position(latitude: "40.7128", longitude: "-74.0060", googleMap: "http://maps.google.com"),
            location: "123 Main St",
            phone: "123-456-7890",
            tags: ["Italian", "Cozy", "Family-friendly"]
        ))
    }
}
