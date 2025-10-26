//
//  UIKitExtensions.swift
//  CinemaVault
//
//  Created by Shreedharshan on 25/10/25.
//

import UIKit


extension UIColor {

    static func hexToColor (_ hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

extension UIButton  {
    
    func setAppImage(_ imageName: String) {
       
        self.tintColor = .themeTxtColor
        self.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate).imageFlippedForRightToLeftLayoutDirection(), for: .normal)
        
    }
}

extension UIApplication {
    func topMostViewController(base: UIViewController? = nil) -> UIViewController? {
        let baseVC = base ?? self.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController
        
        if let nav = baseVC as? UINavigationController {
            return topMostViewController(base: nav.visibleViewController)
        }
        
        if let tab = baseVC as? UITabBarController {
            return topMostViewController(base: tab.selectedViewController)
        }
        
        if let presented = baseVC?.presentedViewController {
            return topMostViewController(base: presented)
        }
        
        return baseVC
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let img = UIImage(data: data) {
                DispatchQueue.main.async { self.image = img }
            }
        }
    }
}
