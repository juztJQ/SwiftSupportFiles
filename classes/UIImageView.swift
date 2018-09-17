//
//  UIImageView.swift
//  Distrito Appnimal
//
//  Created by Ivan Espitia on 3/05/18.
//  Copyright © 2018 IDPYBA. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    func downloadedFrom(url: URL, mode : UIViewContentMode) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    
    func downloadedFrom(link: String, mode: UIViewContentMode) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, mode: mode)
    }
    
    func rounded_image(border_color: UIColor) {
        self.layer.borderWidth = 2
        self.layer.masksToBounds = false
        self.layer.borderColor = border_color.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }

}
