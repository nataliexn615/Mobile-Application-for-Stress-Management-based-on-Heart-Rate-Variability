//
//  PreviewView.swift
//  ASMR
//
//  Created by Li Cheuk Yin on 20/1/2021.
//  Copyright © 2021 Li Cheuk Yin. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PreviewView: UIView {

  var shouldUseClipboardImage: Bool = false {
    didSet {
      if shouldUseClipboardImage {
        if imageView.superview == nil {
          addSubview(imageView)
          let constraints = [
            NSLayoutConstraint(item: imageView, attribute: .top,
                               relatedBy: .equal,
                               toItem: self, attribute: .top,
                               multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .leading,
                               relatedBy: .equal,
                               toItem: self, attribute: .leading,
                               multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self, attribute: .trailing,
                               multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self, attribute: .bottom,
                               multiplier: 1, constant: 0),
          ]
          addConstraints(constraints)
        }

      } else {
        imageView.removeFromSuperview()
      }
    }
  }

  lazy private var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  var image: UIImage? {
    get {
      return imageView.image
    }
    set {
      imageView.image = newValue
    }
  }

  var previewLayer: AVCaptureVideoPreviewLayer {
    guard let layer = layer as? AVCaptureVideoPreviewLayer else {
      fatalError("Layer expected is of type VideoPreviewLayer")
    }
    return layer
  }

  var session: AVCaptureSession? {
    get {
      return previewLayer.session
    }
    set {
      previewLayer.session = newValue
    }
  }

  override class var layerClass: AnyClass {
    return AVCaptureVideoPreviewLayer.self
  }

}
