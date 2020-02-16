//
//  UIExtensions.swift
//  SunethShehan-cobsccomp182p-004
//
//  Created by Suneth on 2/6/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import UIKit

extension UITextField {
    
    func toStyledTextField() { // Give Round Border and Left Placholder Padding
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        self.leftViewMode = UITextField.ViewMode.always
    }
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    func placeholderColor(color: UIColor) {
        let attributeString = [
            NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.6),
            NSAttributedString.Key.font: self.font!
            ] as [NSAttributedString.Key : Any]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: attributeString)
    }
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

extension UIButton{
    func toRoundButtonEdges(){
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}

//extensions for View Controllers
extension RegistrationViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.imgProPicture.image = image
    }
}

extension PostEventViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.imgEventImage.image = image
    }
}

extension UpdateProfileViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.imgProPicture.image = image
    }
}

