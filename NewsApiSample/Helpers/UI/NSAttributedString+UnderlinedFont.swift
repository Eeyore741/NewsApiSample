//
//  UILabel+UnderlinedFont.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 21/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import Foundation
import UIKit

extension NSAttributedString{
    
    class func underlinedAttributedString(_ string: String, color: UIColor?, font: UIFont?)->NSAttributedString{
        
        let font = font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize)
        let color = color ?? UIColor.darkText
        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.foregroundColor: color
            ,NSAttributedStringKey.underlineColor: color
            ,NSAttributedStringKey.font: font
            ,NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue
        ]
        return NSAttributedString.init(string: string,
                                       attributes: attributes)
    }
}
