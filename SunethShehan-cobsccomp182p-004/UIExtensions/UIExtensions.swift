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
        self.layer.borderWidth = 0.6
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 9
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        self.leftViewMode = UITextField.ViewMode.always
        self.layer.borderColor =  UIColor.gray.cgColor
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
    
    func colorButtonBackground(){
        self.backgroundColor = UIColor(red:0.09, green:0.36, blue:0.49, alpha:1.0)
        self.setTitleColor(UIColor.white, for: .normal)
    }
}

extension UIImageView{
    func toRoundEdges(){
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
    
    func addWhiteBorder(){
       
       self.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
       self.layer.masksToBounds = true
       self.contentMode = .scaleToFill
       self.layer.borderWidth = 5
    }
    
    func addThinWhiteBorder(){
        self.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        self.layer.masksToBounds = true
        self.contentMode = .scaleToFill
        self.layer.borderWidth = 3
    }
    func toRoundedImage(){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
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

extension UIViewController{
    
   
    
}
