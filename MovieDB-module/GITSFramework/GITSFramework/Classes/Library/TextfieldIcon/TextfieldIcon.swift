//
//  TextfieldIcon.swift
//  GITSFramework
//
//  Created by Ajie Pramono Arganata on 06/11/18.
//

import Foundation

public class TextfieldIcon: UITextField {
    @IBInspectable public var iconImage: UIImage {
        get {
            return self.iconImage
        } set {
            self.leftView = UIImageView(image: newValue)
            self.rightViewMode = .always
        }
    }
}
