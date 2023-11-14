//
//  DataModel.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/6/23.
//

import Foundation
import Combine

class PlacesDataModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var searchText: String = ""
    private var dataModelURL: URL {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Document Directory not found.")
        }
        return documentDirectory.appendingPathComponent("res.json")
    }
    
    init() {
        loadFromFile()
    }
    
    func loadFromFile() {
        if FileManager.default.fileExists(atPath: dataModelURL.path) {
            do {
                let data = try Data(contentsOf: dataModelURL)
                places = try JSONDecoder().decode([Place].self, from: data)
            } catch {
                print("Error loading data model: \(error)")
            }
        } else {
            save()
        }
        
        for (index, var place) in places.enumerated() {
            place.id = index + 1
            places[index] = place
        }
    }
    
    func load(dataModelFileURL: URL) {
        do {
            let data = try Data(contentsOf: dataModelFileURL)
            places = try JSONDecoder().decode([Place].self, from: data)
        } catch {
            print("Error loading data model from specified file: \(error)")
        }
        save()
        for (index, var place) in places.enumerated() {
            place.id = index + 1
            places[index] = place
        }
    }
    
    func add(place: Place) {
        places.append(place)
        save()
    }
    
    func update(placeId: String, updatedPlace: Place) {
        if let index = places.firstIndex(where: { $0.place_id == placeId }) {
            places[index] = updatedPlace
            save()
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(places)
            try data.write(to: dataModelURL)
        } catch {
            print("Error saving data model: \(error)")
        }
    }
    
    func download() {
        let urlString = "https://streamer.oit.duke.edu/places/items?tag=west_campus&access_token=4fb83524bf2e30e93fd31d18f4143c49"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            do {
                var downloadedPlaces = try JSONDecoder().decode([Place].self, from: data)
                DispatchQueue.main.async {
                    for (index, var downloadedPlace) in downloadedPlaces.enumerated() {
                        downloadedPlace.id = index + 1
                        downloadedPlaces[index] = downloadedPlace
                    }
                    self?.places = downloadedPlaces
                    self?.save()
                }
            } catch {
                print("Error downloading places: \(error)")
            }
        }
        
        task.resume()
    }
    
    func list() {
        for place in places {
            print(place.name)
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
