//
//  ViewController.swift
//  UIButtonConfiguration
//
//  Created by bibek timalsina on 05/02/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let demoButton = UIButton()
    var demoButtonConfig: UIButton.Configuration = .filled()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDemoButton()
        addMenu()
    }
    
    private func addMenu() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Click to interact", for: .normal)
        button.addAction(.init(handler: { action in
            print("clicked")
        }), for: .touchUpInside)
        
        let configs: [String: UIButton.Configuration] = [
            "Filled": .filled(),
            "Bordered": .bordered(),
            "Bordered Prominent": .borderedProminent(),
            "Bordered Tinted": .borderedTinted(),
            "Borderless": .borderless(),
            "Gray": .gray(),
            "Plain": .plain()
        ]
        
        let actions = configs.map {(key, config) in
            UIAction(title: key) { _ in
                self.demoButtonConfig = config
                self.demoButton.setNeedsUpdateConfiguration()
            }
        }
        
        button.configuration = configs.first?.value
        
        let menu = UIMenu(title: "Configs", options: .singleSelection, children: actions)
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        button.preferredMenuElementOrder = .automatic
        
        stackView.addArrangedSubview(button)
    }
    
    private func addDemoButton() {
        let button = demoButton
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addAction(.init(handler: { action in
            print("I am parrot")
        }), for: .touchUpInside)
        
        button.configurationUpdateHandler = { button in
            var config = self.demoButtonConfig
            config.buttonSize = .medium
            config.title = "Parrot"
            config.cornerStyle = .dynamic
            config.titleTextAttributesTransformer = .init({ container in
                var newContainer = container
                newContainer.font = UIFont.preferredFont(forTextStyle: .title1)
                return newContainer
            })
            config.image = UIImage(systemName: "person")
            config.imagePadding = 8
            config.imagePlacement = .leading
            button.configuration = config
        }
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        button.setNeedsUpdateConfiguration()
    }
    
}
