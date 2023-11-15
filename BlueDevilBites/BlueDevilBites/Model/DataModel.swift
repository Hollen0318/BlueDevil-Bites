//
//  DataModel.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/6/23.
//

import Foundation
import Combine
import SwiftUI

let accessToken = "4fb83524bf2e30e93fd31d18f4143c49"

let sandBoxFileName = "ResData.json"

let downloadURL = "https://streamer.oit.duke.edu/places/items?tag=west_campus&access_token=" + accessToken

class ResDataModel: ObservableObject {
    @Published var restaurants: [Res] = []

    init() {
        load()
        download()
    }

    func download() {
        // Download the basic restaurant data
        guard let url = URL(string: downloadURL) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }

            do {
                let restaurants = try JSONDecoder().decode([Res].self, from: data)
                DispatchQueue.main.async {
                    self?.restaurants = restaurants
                    self?.fetchAdditionalDetails()
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
    }

    private func fetchAdditionalDetails() {
        for index in restaurants.indices {
            let restaurant = restaurants[index]
            guard let detailsURL = URL(string: "https://streamer.oit.duke.edu/places/items/index?place_id=\(restaurant.placeId)&access_token=\(accessToken)") else { continue }

            let task = URLSession.shared.dataTask(with: detailsURL) { [weak self] data, response, error in
                guard let data = data, error == nil else { return }

                do {
                    let additionalDetails = try JSONDecoder().decode(Res.self, from: data)
                    DispatchQueue.main.async {
                        self?.restaurants[index].schedule = additionalDetails.schedule
                        self?.restaurants[index].ownerOperator = additionalDetails.ownerOperator
                        self?.restaurants[index].paymentMethods = additionalDetails.paymentMethods
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
            task.resume()
        }
    }

    func save() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(sandBoxFileName) else { return }

        do {
            let data = try JSONEncoder().encode(restaurants)
            try data.write(to: url)
        } catch {
            print("Saving error: \(error)")
        }
    }

    func load() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(sandBoxFileName) else { return }

        do {
            let data = try Data(contentsOf: url)
            restaurants = try JSONDecoder().decode([Res].self, from: data)
        } catch {
            print("Loading error: \(error)")
        }
    }
}

class CommentsDataModel: ObservableObject {
    @Published var comments: [Comment] = []

    init() {
        // Wait for Vapor code
        downloadComments()
    }

    func addComment(_ comment: Comment) {
        comments.append(comment)
        uploadComment(comment)
    }

    func updateComment(_ comment: Comment) {
        if let index = comments.firstIndex(where: { $0.id == comment.id }) {
            comments[index] = comment
            uploadComment(comment)
        }
    }

    func deleteComment(withID id: Int) {
        comments.removeAll { $0.id == id }
        // Here you would add code to handle the server-side deletion
        // For example, an HTTP DELETE request
    }

    // MARK: - Server Communication

    func downloadComments() {
        // Simulate a REST call to download comments
        // Replace this with your actual HTTP GET request
        let url = URL(string: "https://yourserver.com/comments")!
        // Make sure to handle networking on the background thread
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.comments = (try? JSONDecoder().decode([Comment].self, from: data)) ?? []
                }
            } else {
                // Handle errors
            }
        }.resume()
    }

    func uploadComment(_ comment: Comment) {
        // Simulate a REST call to upload a comment
        // Replace this with your actual HTTP POST or PUT request
        let url = URL(string: "https://yourserver.com/comments")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // or "PUT" if updating
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(comment)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                // Handle errors
                print(error.localizedDescription)
            } else {
                // Handle the response
            }
        }.resume()
    }
}
