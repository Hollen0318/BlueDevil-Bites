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

    private var dataModelURL: URL {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Document Directory not found.")
        }
        return documentDirectory.appendingPathComponent("datamodel.json")
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
    }
    
    func load(dataModelFileURL: URL) {
        do {
            let data = try Data(contentsOf: dataModelFileURL)
            places = try JSONDecoder().decode([Place].self, from: data)
        } catch {
            print("Error loading data model from specified file: \(error)")
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
                let downloadedPlaces = try JSONDecoder().decode([Place].self, from: data)
                DispatchQueue.main.async {
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
