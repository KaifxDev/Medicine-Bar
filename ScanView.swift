//
//  ScanView.swift
//  Medicine-Bar
//
//  Created by Kaif Ali Khan Pathan on 30/03/2023.
//

import SwiftUI
import AVFoundation

class Coordinator: NSObject, CameraViewDelegate {
    var parent: ScanView
    
    init(_ parent: ScanView) {
        self.parent = parent
    }
    
    func cameraView(_ cameraView: CameraView, didCapturePhoto photo: UIImage) {
        parent.handleCapturedPhoto(photo)
        parent.presentationMode.wrappedValue.dismiss()
    }
}

struct ScanView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ScanViewModel
    @State var isShowingImagePicker = false
    var handleCapturedPhoto: (UIImage) -> Void
    
    
    init(viewModel: ScanViewModel, handleCapturedPhoto: @escaping (UIImage) -> Void) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.handleCapturedPhoto = handleCapturedPhoto
    }
    
    var body: some View {
        let cameraView = CameraView().environmentObject(viewModel)
        return cameraView
    }

    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
  //class Coordinator: NSObject, CameraViewDelegate {
  //    var parent: ScanView
  //
  //    init(_ parent: ScanView) {
  //        self.parent = parent
  //    }
  //
  //    func cameraView(_ cameraView: CameraView, didCapturePhoto photo: UIImage) {
  //        parent.handleCapturedPhoto(photo)
  //        parent.presentationMode.wrappedValue.dismiss()
  //    }
  //  }
}

protocol CameraViewDelegate: AnyObject {
    func cameraView(_ cameraView: CameraView, didCapturePhoto photo: UIImage)
}

final class CameraView: UIView, AVCapturePhotoCaptureDelegate, UIViewRepresentable, AVCaptureVideoDataOutputSampleBufferDelegate {
    var viewModel: ScanViewModel
    weak var delegate: CameraViewDelegate?
    @State var isShowingImagePicker = false
    @State var image: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .camera
    private let stillImageOutput = AVCapturePhotoOutput()
    
    init(viewModel: ScanViewModel, delegate: CameraViewDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    func makeUIView(context: Context) -> CameraView {
        return self
    }
    
    func updateUIView(_ uiView: CameraView, context: Context) {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCameraView()
    }
    
    private func setupCameraView() {
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo

        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)

            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = bounds
            previewLayer.videoGravity = .resizeAspectFill
            layer.addSublayer(previewLayer)

            let dataOutput = AVCaptureVideoDataOutput()
            dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
            dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
            captureSession.addOutput(dataOutput)

            captureSession.startRunning()
        } catch {
            print("Error setting up capture session: \(error.localizedDescription)")
        }
    }

    
    func takePhoto() {
        let settings = AVCapturePhotoSettings()
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            return
        }
        delegate?.cameraView(self, didCapturePhoto: image)
    }
    
    func loadImage() {
        guard let image = image else { return }
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("university_id.jpg") else { return }
        do {
            try data.write(to: url)
            viewModel.imageFileURL = url // Accessing the property directly from the viewModel object
        } catch {
            print("Error saving image: \(error.localizedDescription)")
        }
    }
    
}


/*
extension CameraView: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            return
        }
        delegate?.cameraView(self, didCapturePhoto: image)
    }
}
 */

/*
struct CameraPreviewView: UIViewRepresentable {
    @EnvironmentObject var viewModel: ScanViewModel
    func makeUIView(context: Context) -> UIView {
        let cameraView = CameraView(delegate: context.coordinator).environmentObject(viewModel)
        let containerView = UIView()
        containerView.addSubview(cameraView)
        cameraView.frame = containerView.bounds
        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, CameraViewDelegate {
        var parent: CameraPreviewView

        init(_ parent: CameraPreviewView) {
            self.parent = parent
        }

        func cameraView(_ cameraView: CameraView, didCapturePhoto photo: UIImage) {
            // handle photo capture
        }
    }
}
*/

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var sourceType: UIImagePickerController.SourceType
    @Binding var isShowingImagePicker: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.sourceType = sourceType
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        uiViewController.sourceType = sourceType
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }

            parent.sourceType = .camera
            parent.isShowingImagePicker = false
        }

    }
}


struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView(viewModel: ScanViewModel(), handleCapturedPhoto: { _ in})
    }
}


