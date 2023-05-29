//
//  MainViewController.swift
//  ImageGenerator
//
//  Created by Viktoriya on 26.05.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var requestTextField: UITextField?
    @IBOutlet private weak var imageView: UIImageView?
    @IBOutlet private weak var favoriteImageView: UIImageView?
    @IBOutlet private weak var imageStackView: UIStackView?
    @IBOutlet private weak var confirmButton: AppButton?
    @IBOutlet private weak var favoriteButton: AppButton?
    @IBOutlet private weak var limitLabel: UILabel?
    @IBOutlet private weak var titleLabel: UILabel?
    
    //MARK: - Private Properties
    
    private var countdownValue = 0
    private var countdownTimer: Timer?
    private var isReadyToRequest: Bool = true
    private var previousRequest = ""
    
    private var presenter: MainPresenter?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.setupImageView()
        self.setupTextField()
        self.setupLabels()
        self.setupMainActions()
        self.hideKeyboardWhenTappedAround()
    }
    
    //MARK: - Private Methods

    private func configureNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = translate("Main.search")
        titleLabel.textColor = .black
        self.navigationItem.titleView = titleLabel
    }
    
    private func setupImageView() {
        self.imageView?.image = UIImage(named: "Main.defaultImage")
        self.imageView?.layer.borderColor = UIColor.gray.cgColor
        self.imageView?.layer.borderWidth = 1.0
        self.imageStackView?.isHidden = true
    }
    
    private func setupLabels() {
        self.limitLabel?.attributedText = NSAttributedString(string: String(format: translate("Main.exceedingTheLimit"), "\(limitSecondsCount)"))
        self.limitLabel?.isHidden = true
        self.limitLabel?.textColor = UIColor.lightGray
        self.titleLabel?.text = translate("Main.text")
        self.titleLabel?.textColor = UIColor.black
    }
    
    private func setupMainActions() {
        //Generate
        self.confirmButton?.setTitle(translate("Main.generate"), for: .normal)
        self.confirmButton?.addTarget(self, action: #selector(generateImage), for: .touchUpInside)
        
        //Favorite
        self.favoriteButton?.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
    }
    
    @objc func generateImage() {
        guard let textField = self.requestTextField else {
            return
        }
        
        guard let request = textField.text,
              !request.isEmpty else {
            AnimationManager.shake(textField)
            Vibration.notificationOccured(notificationType: .error)
            return
        }
        
        if textField.text == previousRequest {
            AnimationManager.shake(textField)
            Vibration.notificationOccured(notificationType: .error)
            AlertManager.showErrorAlert(from: self, message: translate("Alert.alreadySend"))
            return
        }
        
        if !request.containsWhitespaceAndNewlines() {
            AlertManager.showLoader(from: self)
        }
        
        self.previousRequest = request
        Vibration.vibrate(style: .light)
        presenter?.generateImage(withText: request)
        self.favoriteImageView?.image = UIImage(named: "heartField")
    }
    
    @objc func addToFavorites() {
        guard let image = imageView?.image else {
            return
        }
        self.favoriteImageView?.image = UIImage(named: "heart")
        Vibration.notificationOccured(notificationType: .success)
        presenter?.addToFavorites(image)
    }
    
    private func setupTextField() {
        self.requestTextField?.delegate = self
        self.requestTextField?.attributedPlaceholder = NSAttributedString(string: translate("Main.enterText"),
                                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.requestTextField?.textColor = UIColor.black
        self.requestTextField?.layer.cornerRadius = 10
        self.requestTextField?.layer.borderWidth = 1.0
        self.requestTextField?.layer.borderColor = UIColor.gray.cgColor
        self.requestTextField?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if let text = self.requestTextField?.text {
            self.confirmButton?.isAvailable = !text.isEmpty && isReadyToRequest
        }
    }
    
    private func startCountdown() {
        mainThread {
            self.countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCountdown), userInfo: nil, repeats: true)
        }
        
        AlertManager.showLoader(from: self, isShow: false)
    }
    
    @objc func updateCountdown() {
        countdownValue -= 1
        if countdownValue >= 0 {
            self.limitLabel?.attributedText = NSAttributedString(string: String(format: translate("Main.exceedingTheLimit"), "\(self.countdownValue)"))
        } else {
            self.countdownTimer?.invalidate()
            self.confirmButton?.isAvailable = true
            self.isReadyToRequest = true
            self.limitLabel?.isHidden = true
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField == self.requestTextField else {
            return false
        }
        if isReadyToRequest {
            self.generateImage()
            textField.resignFirstResponder()
        }
        Vibration.notificationOccured(notificationType: .error)
        textField.resignFirstResponder()
        if let label = self.limitLabel {
            AnimationManager.shake(label)
        }
        return true
    }
}

//MARK: - ViewProtocol Methods

extension MainViewController: MainViewProtocol {
    func displayTimer(_ seconds: Int) {
        self.previousRequest = ""
        self.isReadyToRequest = false
        self.confirmButton?.isAvailable = false
        self.countdownValue = seconds
        self.limitLabel?.attributedText = NSAttributedString(string: String(format: translate("Main.exceedingTheLimit"), "\(countdownValue)"))
        self.limitLabel?.isHidden = false
        self.startCountdown()
    }
    
    func displayImage(_ image: UIImage) {
        imageView?.image = image
        self.imageStackView?.isHidden = false
        self.favoriteButton?.isAvailable = true
        AlertManager.showLoader(from: self, isShow: false)
    }
    
    func displayError(_ message: String) {
        self.previousRequest = ""
        Vibration.notificationOccured(notificationType: .error)
        AlertManager.showErrorAlert(from: self, message: message)
    }
}

//MARK: - Presenter Setup

extension MainViewController {
    func setup(presenter: MainPresenter?) {
        self.presenter = presenter
    }
}
