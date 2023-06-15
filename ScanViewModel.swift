//
//  ScanViewModel.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 31/03/2023.
//

import Foundation
import SwiftUI

class ScanViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var imageFileURL: URL?
    
    func saveImage() -> URL? {
        guard let image = image else { return nil }
        guard let data = image.jpegData(compressionQuality: 0.5) else { return nil }
        
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentsDirectory.appendingPathComponent("university_id.jpg")
            try data.write(to: fileURL)
            imageFileURL = fileURL // update the value of imageFileURL
            return fileURL
        } catch {
            print("Error saving image: \(error.localizedDescription)")
            return nil
        }
    }
    
    func loadImage() -> UIImage? {
        guard let fileURL = getFilePath() else { return nil }
        do {
            let imageData = try Data(contentsOf: fileURL)
            let image = UIImage(data: imageData)
            return image
        } catch {
            print("Error loading image: \(error.localizedDescription)")
            return nil
        }
    }
    
    func deleteImage() {
        guard let fileURL = getFilePath() else { return }
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print("Error deleting image: \(error.localizedDescription)")
        }
    }
    
    private func getFilePath() -> URL? {
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = documentsDirectory.appendingPathComponent("university_id.jpg")
            return fileURL
        } catch {
            print("Error getting file path: \(error.localizedDescription)")
            return nil
        }
    }
}


