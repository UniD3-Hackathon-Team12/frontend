//
//  HomeViewController.swift
//  SeeReaURL
//
//  Created by Seo Cindy on 11/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextFieldStyle()
        
    }
    
    func setTextFieldStyle() {
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor(named: "pointColor")?.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.0
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        if textField.text != nil {
            print("\(textField.text!)")
        }
    }
    
}
