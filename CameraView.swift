//
//  CameraView.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 01/04/2023.
//
/*
import Foundation
import SwiftUI
import AVFoundation

struct CameraView: View {
    @EnvironmentObject var viewModel: ScanViewModel
    weak var delegate: CameraViewDelegate?
    @State var isShowingImagePicker = false
    @State var image: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .camera
    private let stillImageOutput = AVCapturePhotoOutput()
    
    init(delegate: CameraViewDelegate) {
        self.delegate = delegate
    }
    
    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                CameraPreviewView()
            }
            
            HStack {
                Spacer()
                
                Button(action: {
                    self.isShowingImagePicker = true
                }) {
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .padding()
                }
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$image, sourceType: self.$sourceType)
                }
                
                Button(action: {
                    self.takePhoto()
                }) {
                    Image(systemName: "camera")
                        .font(.largeTitle)
                        .padding()
                }
                .disabled(image != nil)
                
                Spacer()
            }
            .padding(.bottom, 20)
        }
    }
    
    func takePhoto() {
        guard let settings = AVCapturePhotoSettings.maxQualityPhotoSettings() else { return }
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func loadImage() {
        guard let image = image else { return }
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("university_id.jpg") else { return }
        
        do {
            try data.write(to: url)
            viewModel.imageFileURL = url
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
    }
}

*/
