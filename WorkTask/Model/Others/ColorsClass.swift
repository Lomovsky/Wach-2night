//
//  ColorsClass.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 11.01.2021.
//

import UIKit
class Colors {
    var gl:CAGradientLayer!

    init() {
        let colorTop = UIColor(red: 0.75, green: 0.83, blue: 0.95, alpha: 1.00).cgColor
        let colorBottom = UIColor(red: 0.07, green: 0.45, blue: 0.87, alpha: 1.00).cgColor

        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}
