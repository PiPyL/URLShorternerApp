//
//  ViewController.swift
//  URLShortenerApp
//
//  Created by PiPyL on 1/20/20.
//  Copyright © 2020 PiPyL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var urlShortenerLabel: UILabel!
    @IBOutlet weak var generateButton: UIButton!
    
    private var urlShortenerResult: String?
    
    //MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configeUI()
        setupData()
    }
    
    //MARK: - Private
    
    private func configeUI() {
        
        generateButton.layer.cornerRadius = 20
        generateButton.clipsToBounds = true
    }
    
    private func setupData() {
        let tapURLShortenerLabel = UITapGestureRecognizer(target: self, action: #selector(didClickURLShortener))
        urlShortenerLabel.addGestureRecognizer(tapURLShortenerLabel)
    }
    
    @objc private func didClickURLShortener(sender:UITapGestureRecognizer) {
        if let urlString = urlShortenerResult, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }

    //MARK: - Action
    
    @IBAction func didClickGenerate(_ sender: Any) {
        if isValidate(urlString: urlTextField.text) {
            getURLShortenter()
        }
    }
    
    //MARK: - API
    
    private func getURLShortenter() {
        NetworkController.getURLShortener(urlString: urlTextField.text!) { [weak self] (error, urlShortener) in
            if let error = error {
                self?.setupErrorAlertController(error: error)
            } else {
                self?.urlShortenerResult = urlShortener
                DispatchQueue.main.async {
                    self?.urlShortenerLabel.attributedText = urlShortener!.getUnderLineAttributedText()
                    self?.urlTextField.text = ""
                    self?.urlTextField.resignFirstResponder()
                }
            }
        }
    }
    
    //MARK: - Helper
    
    func isValidate(urlString: String?) -> Bool {
                
        var error: String? = nil
        
        if urlString == "" || urlString == nil {
            error = "Please enter the URL!"
        } else if !urlString!.isValidURL {
            error = "Please check the URL entered!"
        }
        
        if let error = error {
            setupErrorAlertController(error: error)
            return false
        }
        return true
    }
    
    private func setupErrorAlertController(error: String) {
        
        let alertController = UIAlertController(title: "Notification", message: error, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

