//
//  ViewController.swift
//  UIButtonConfiguration
//
//  Created by bibek timalsina on 05/02/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .tintColor
        
        button.setTitle("Parrot", for: .normal)
        button.addAction(.init(handler: { action in
            print("I am parrot")
        }), for: .touchUpInside)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
