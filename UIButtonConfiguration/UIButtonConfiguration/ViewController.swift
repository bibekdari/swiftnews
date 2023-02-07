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
        
        button.setTitle("Parrot", for: .normal)
        button.addAction(.init(handler: { action in
            print("I am parrot")
        }), for: .touchUpInside)
        
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.cornerStyle = .capsule
        
        config.image = UIImage(systemName: "person")
        config.imagePadding = 8
        config.imagePlacement = .leading
        
        config.titleTextAttributesTransformer = .init({ container in
            var newContainer = container
            newContainer.font = UIFont.preferredFont(forTextStyle: .title1)
            return newContainer
        })
        
        button.configuration = config
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
