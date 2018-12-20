//
//  CameraViewController.swift
//  SnapChatMenu
//
//  Created by HalseyW-15 on 2018/12/20.
//  Copyright © 2018 wushhhhhh. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var ivPhoto: UIImageView!
    
    var captureSession = AVCaptureSession()
    var photoOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var isPhotoTaken = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        captureSession.sessionPreset = .hd1920x1080
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.connection?.videoOrientation = .portrait
        cameraView.layer.addSublayer(previewLayer!)
        
        var deviceInput: AVCaptureDeviceInput?
        let camera = AVCaptureDevice.default(for: .video)
        
        do {
            deviceInput = try AVCaptureDeviceInput(device: camera!)
        } catch {
            deviceInput = nil
        }
        
        if let input = deviceInput, captureSession.canAddInput(input) {
            captureSession.addInput(input)
            photoOutput = AVCapturePhotoOutput()
            if let output = photoOutput, captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
                captureSession.startRunning()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.bounds
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isPhotoTaken {
            ivPhoto.isHidden = true
        } else {
            takePhoto()
        }
        isPhotoTaken.toggle()
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            let image = UIImage.init(data: imageData)
            ivPhoto.image = image
            ivPhoto.isHidden = false
        }
    }
    
    func takePhoto() {
        if let output = photoOutput {
            output.capturePhoto(with: AVCapturePhotoSettings.init(), delegate: self)
        }
    }
}
