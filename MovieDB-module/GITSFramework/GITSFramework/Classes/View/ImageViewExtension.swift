//
//  ImageViewExtension.swift
//  Pods
//
//  Created by GITS Indonesia on 3/17/17.
//
//

import Foundation

extension UIImage {
    public var uncompressedPNGData: Data      { return UIImagePNGRepresentation(self)!        }
    public var highestQualityJPEGNSData: Data { return UIImageJPEGRepresentation(self, 1.0)!  }
    public var highQualityJPEGNSData: Data    { return UIImageJPEGRepresentation(self, 0.75)! }
    public var mediumQualityJPEGNSData: Data  { return UIImageJPEGRepresentation(self, 0.5)!  }
    public var lowQualityJPEGNSData: Data     { return UIImageJPEGRepresentation(self, 0.25)! }
    public var lowestQualityJPEGNSData:Data   { return UIImageJPEGRepresentation(self, 0.0)!  }
}

public class CircleImageView: UIImageView {
    @IBInspectable public var borderWidth: CGFloat = 0
    @IBInspectable public var garisColor: UIColor = UIColor.clear
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = false
        layer.cornerRadius = frame.height/2
        clipsToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = garisColor.cgColor
    }
}
