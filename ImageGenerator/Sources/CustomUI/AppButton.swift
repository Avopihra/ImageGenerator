//
//  AppButton.swift
//  ImageGenerator
//
//  Created by Viktoriya on 28.05.2023.
//

import UIKit

//MARK: - Custom Button Class

final class AppButton: TouchableButton {

    var isAvailable: Bool = true {
        didSet {
            self.updateAvailability(isAvailable)
        }
    }

    init() {
        super.init(frame: .zero)
        customInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        customInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 9.0
    }
}

 extension AppButton {
    func customInit() {
        self.setupText()
        self.setupColor()
        self.updateButtonStyle()
    }

    func setupText() {
        self.setupTitleTextColor()
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.5
    }

    func setupTitleTextColor() {
        self.setTitleColor(UIColor.white, for: .normal)
    }

    func setupColor() {
        self.backgroundColor = UIColor.buttonBackground1
    }
    
    func updateAvailability(_ isAvailable: Bool) {
        self.isUserInteractionEnabled = isAvailable
        AnimationManager.animate {
            self.backgroundColor = isAvailable ? UIColor.buttonBackground1 : UIColor.buttonBackground2
            self.layer.borderColor = isAvailable ? UIColor.buttonBorder1.cgColor : UIColor.buttonBorder2.cgColor
        }
        self.layoutSubviews()
        self.layoutIfNeeded()
    }
    
    func updateButtonStyle() {
        self.setupColor()
        self.setupTitleTextColor()
        self.updateBorderAppearance()
    }
    
    func updateBorderAppearance() {
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.buttonBorder1.cgColor
    }
}
