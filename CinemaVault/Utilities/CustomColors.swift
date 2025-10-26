//
//  CustomColors.swift
//  CinemaVault
//
//  Created by Shreedharshan on 25/10/25.
//

import UIKit


extension UIColor {
    
    class var themeColor: UIColor {
        return UIColor { traitCollection in
            
            return .hexToColor("08004D")
        }
    }

    
    class var secondThemeColor: UIColor {
        
        return UIColor.hexToColor("00EAD7")
    }
    
    class var themeTxtColor: UIColor {
        return UIColor { traitCollection in
            return .white
            }
        }
    
    
    static let darkTxtColor = UIColor(red: 0.133, green: 0.169, blue: 0.271, alpha: 1)
    static let secondaryColor = UIColor.white
    static let blackColor = UIColor.white    
    
}
