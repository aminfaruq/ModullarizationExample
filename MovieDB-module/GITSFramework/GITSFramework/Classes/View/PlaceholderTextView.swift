//
//  PlaceholderTextView.swift
//  GITSFramework
//
//  Created by GITS INDONESIA on 4/26/17.
//  Copyright © 2017 GITS Indonesia. All rights reserved.
//

import UIKit

public class PlaceholderTextView: UITextView {
    @IBInspectable var placeholderColor: UIColor = UIColor.lightGray
    @IBInspectable var placeholderText: String = ""
    
    public func setPlaceholder(text: String) {
        placeholderText = text
    }
    
    override public var font: UIFont? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override public var contentInset: UIEdgeInsets {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override public var textAlignment: NSTextAlignment {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override public var text: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override public var attributedText: NSAttributedString? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.white
        setUp()
    }
    
    private func setUp() {
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(notification:)), name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }
    
    @objc public func textChanged(notification: NSNotification) {
        setNeedsDisplay()
    }
    
    func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        var x = contentInset.left + 4.0
        var y = contentInset.top  + 9.0
        let w = frame.size.width - contentInset.left - contentInset.right - 16.0
        let h = frame.size.height - contentInset.top - contentInset.bottom - 16.0
        
        if let style = self.typingAttributes[NSAttributedStringKey.paragraphStyle.rawValue] as? NSParagraphStyle {
            x += style.headIndent
            y += style.firstLineHeadIndent
        }
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    override public func draw(_ rect: CGRect) {
        if text!.isEmpty && !placeholderText.isEmpty {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = textAlignment
            let attributes: [ NSAttributedStringKey: Any ] = [
                NSAttributedStringKey.font : font!,
                NSAttributedStringKey.foregroundColor : placeholderColor,
                NSAttributedStringKey.paragraphStyle  : paragraphStyle]
            
            placeholderText.draw(in: placeholderRectForBounds(bounds: bounds), withAttributes: attributes)
        }
        super.draw(rect)
    }
}
