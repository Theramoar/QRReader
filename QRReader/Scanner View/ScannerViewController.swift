//
//  ScannerViewController.swift
//  QRReader
//
//  Created by Misha Kuznecov on 27/01/2021.
//

import AVFoundation
import UIKit


class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var device: AVCaptureDevice?
    private var capturedObject: AVMetadataMachineReadableCodeObject?

    private var fetcher = NetworkDataFetcher()
    private var userData: UserData = .shared
    
    @IBOutlet private var videoView: UIView!
    private var resultView: ResultView!
    private var activityIndicator: UIActivityIndicatorView!
    
    
    private var flashON = false
    let systemSoundID: SystemSoundID = 1016
    

// MARK: - View Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQRReader()
        navigationItem.title = "Scanner"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.navImageFromAsset("sun"), style: .plain, target: self, action: #selector(toggleFlash))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFrame()
        setupActivityIndicator()
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resultView = ResultView()
        self.view.addSubview(self.resultView)
        self.resultView.setupConstraints()
        
        
    }

    
// MARK: - Setup methods
    private func setupActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .medium)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .gray)
        }
        activityIndicator.center = CGPoint(x: view.center.x, y: view.center.y - 30)
            
        self.videoView.addSubview(activityIndicator)
    }
    
    private func setupFrame() {
        let frameView = FrameView()
        videoView.addSubview(frameView)
        frameView.setupConstraints()
    }
    
    private func setupQRReader() {
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        device = videoCaptureDevice
        
        setDeviceInput()
        setDeviceOutput()
        addVideoLayer()
        
        captureSession.startRunning()
    }
    
    private func setDeviceInput() {
        guard let device = device else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: device)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
    }
    
    private func setDeviceOutput() {
        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
    }
    
    private func addVideoLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = videoView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        videoView.layer.addSublayer(previewLayer)
    }
    
    
    
    private func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    

// MARK: - QR Code Capture Methods
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            if readableObject.stringValue != capturedObject?.stringValue {
                capturedObject = readableObject
                guard let stringValue = readableObject.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                found(code: stringValue)
            }
        }
    }
    
    func found(code: String) {
        activityIndicator.startAnimating()
        fetcher.sendAPIKeyTo(url: code) { [weak self] answer, message in
            guard let self = self else { return }
            if self.userData.soundEnabled {
                AudioServicesPlaySystemSound(self.systemSoundID)
            }
            self.activityIndicator.stopAnimating()
            self.resultView.scanResult = answer
        }
    }
    

// MARK: - Button Methods
    @objc private func toggleFlash() {
        flashON.toggle()
        
        guard let device = device, device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
        } catch {
            print(error)
        }
        
        device.torchMode = device.torchMode == .on ? .off : .on
        device.unlockForConfiguration()
    }
}
