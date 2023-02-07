//
//  ViewController.swift
//  UIButtonConfiguration
//
//  Created by bibek timalsina on 05/02/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let demoButton = UIButton()
    var demoButtonConfig: UIButton.Configuration = {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .medium
        return config
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDemoButton()
        addMenu()
    }
    
    private func addMenu() {
        let vStackView = UIStackView()
        vStackView.axis = .vertical
        vStackView.spacing = 8
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStackView)
        NSLayoutConstraint.activate([
            vStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
        
        func makeMenu() {
            vStackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
            let hStackView1 = UIStackView()
            hStackView1.axis = .horizontal
            hStackView1.spacing = 8
            
            hStackView1.addArrangedSubview(predefinedConfigsMenu {
                makeMenu()
                self.demoButtonConfig = $0
            })
            hStackView1.addArrangedSubview(buttonSizeMenu {
                self.demoButtonConfig.buttonSize = $0
            })
            hStackView1.addArrangedSubview(cornerStyleMenu {
                self.demoButtonConfig.cornerStyle = $0
            })
            
            let hStackView2 = UIStackView()
            hStackView2.axis = .horizontal
            hStackView2.spacing = 8
            
            hStackView2.addArrangedSubview(titleTextStyle { textStyle in
                self.demoButtonConfig.titleTextAttributesTransformer = .init({ container in
                    var newContainer = container
                    newContainer.font = UIFont.preferredFont(forTextStyle: textStyle)
                    return newContainer
                })
            })
            
            hStackView2.addArrangedSubview(imagePlacement {
                self.demoButtonConfig.imagePlacement = $0
            })
            
            vStackView.addArrangedSubview(hStackView1)
            vStackView.addArrangedSubview(hStackView2)
        }
        makeMenu()
    }
    
    private func addDemoButton() {
        let button = demoButton
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addAction(.init(handler: { action in
            print("I am parrot")
        }), for: .touchUpInside)
        
        button.configurationUpdateHandler = { button in
            var config = self.demoButtonConfig
            config.title = "Parrot"
            config.image = UIImage(systemName: "person")
            config.imagePadding = 8
            button.configuration = config
        }
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        button.setNeedsUpdateConfiguration()
    }
    
    // MARK: - Helpers
    private func predefinedConfigsMenu(action: @escaping (UIButton.Configuration) -> Void) -> UIButton {
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
                action(config)
                self.demoButton.setNeedsUpdateConfiguration()
            }
        }
        
        return menuButton(title: "Configs", children: actions)
    }
    
    private func buttonSizeMenu(action: @escaping (UIButton.Configuration.Size) -> Void) -> UIButton {
        let configs: [String: UIButton.Configuration.Size] = [
            "Large": .large,
            "Medium": .medium,
            "Small": .small,
            "Mini": .mini
        ]
        
        let actions = configs.map {(key, size) in
            UIAction(title: key) { _ in
                action(size)
                self.demoButton.setNeedsUpdateConfiguration()
            }
        }
        
        return menuButton(title: "Size", children: actions)
    }
    
    private func cornerStyleMenu(action: @escaping (UIButton.Configuration.CornerStyle) -> Void) -> UIButton {
        let configs: [String: UIButton.Configuration.CornerStyle] = [
            "Large": .large,
            "Medium": .medium,
            "Small": .small,
            "Dynamic": .dynamic,
            "Capsule": .capsule,
            "Fixed": .fixed
        ]
        
        let actions = configs.map {(key, size) in
            UIAction(title: key) { _ in
                action(size)
                self.demoButton.setNeedsUpdateConfiguration()
            }
        }
        
        return menuButton(title: "Corner Style", children: actions)
    }
    
    private func titleTextStyle(action: @escaping (UIFont.TextStyle) -> Void) -> UIButton {
        let configs: [String: UIFont.TextStyle] = [
            "title1": .title1,
            "title2": .title2,
            "title3": .title3,
            "large title": .largeTitle,
            "headline": .headline,
            "sub headline":.subheadline,
            "body": .body,
            "callout": .callout,
            "caption1": .caption1,
            "caption2": .caption2,
            "footnote":.footnote
        ]
        
        let actions = configs.map {(key, style) in
            UIAction(title: key) { _ in
                action(style)
                self.demoButton.setNeedsUpdateConfiguration()
            }
        }
        
        return menuButton(title: "Title Text Style", children: actions)
    }
    
    private func imagePlacement(action: @escaping (NSDirectionalRectEdge) -> Void) -> UIButton {
        let configs: [String: NSDirectionalRectEdge] = [
            "leading": .leading,
            "bottom": .bottom,
            "trailing": .trailing,
            "all": .all,
            "top": .top
        ]
        
        let actions = configs.map {(key, value) in
            UIAction(title: key) { _ in
                action(value)
                self.demoButton.setNeedsUpdateConfiguration()
            }
        }
        
        return menuButton(title: "Image Placement", children: actions)
    }
    
    private func menuButton(title: String, children: [UIMenuElement]) -> UIButton {
        let button = UIButton()
        button.configuration = .borderless()
        let menu = UIMenu(title: title, options: .singleSelection, children: children)
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        button.preferredMenuElementOrder = .automatic
        return button
    }
    
}
