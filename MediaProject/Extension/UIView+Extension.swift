//
//  UIView+Extension.swift
//  MediaProject
//
//  Created by cho on 1/30/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}
