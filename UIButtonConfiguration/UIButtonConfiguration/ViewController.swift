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
    var selectedConfigTitle: String = "Filled"
    var isImageVisible: Bool = true
    var isSubtitleEnabled: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDemoButton()
        addMenu()
        addDemoButton2()
    }
    
    private func addDemoButton2() {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addAction(.init(handler: { action in
            print("I am parrot")
        }), for: .touchUpInside)
        
        var config = UIButton.Configuration.filled()
        config.title = "I am Duck"
        config.subtitle = "Quack"
        config.titleAlignment = .center
        config.titlePadding = 12
        config.baseBackgroundColor = .purple
        config.baseForegroundColor = .white
//        config.background.backgroundColor = .black
        config.background.strokeColor = .green
        config.background.strokeWidth = 2
//        config.showsActivityIndicator = true
        config.buttonSize = .large
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "atom")
        config.imagePlacement = .trailing
        config.imagePadding = 8
        config.titleTextAttributesTransformer = .init({ container in
            var newContainer = container
            newContainer.font = UIFont.preferredFont(forTextStyle: .title3)
            return newContainer
        })
        button.configuration = config
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
        button.setNeedsUpdateConfiguration()
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
        
        func hStack() -> UIStackView {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 8
            return stack
        }
        
        func makeMenu() {
            vStackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
            
            let hStackView1 = hStack()
            
            hStackView1.addArrangedSubview(predefinedConfigsMenu {
                makeMenu()
                self.demoButtonConfig = $0
            })
            hStackView1.addArrangedSubview(buttonSizeMenu {
                $0.map {
                    self.demoButtonConfig.buttonSize = $0
                }
            })
            hStackView1.addArrangedSubview(cornerStyleMenu {
                $0.map {
                    self.demoButtonConfig.cornerStyle = $0
                }
            })
            
            let hStackView2 = hStack()
            
            hStackView2.addArrangedSubview(titleTextStyle {
                $0.map { textStyle in
                    self.demoButtonConfig.titleTextAttributesTransformer = .init({ container in
                        var newContainer = container
                        newContainer.font = UIFont.preferredFont(forTextStyle: textStyle)
                        return newContainer
                    })
                }
            })
            
            hStackView2.addArrangedSubview(imagePlacement {
                $0.map {
                    self.demoButtonConfig.imagePlacement = $0
                }
            })
            
            vStackView.addArrangedSubview(hStackView1)
            vStackView.addArrangedSubview(hStackView2)
            
            let hStackView3 = hStack()
            let labelImage = UILabel()
            labelImage.text = "Show Image?"
            hStackView3.addArrangedSubview(labelImage)
            
            let toggleImage = UISwitch()
            toggleImage.addAction(.init(handler: { _ in
                self.isImageVisible.toggle()
                self.demoButton.setNeedsUpdateConfiguration()
            }), for: .touchUpInside)
            toggleImage.isOn = isImageVisible
            hStackView3.addArrangedSubview(toggleImage)
            
            vStackView.addArrangedSubview(hStackView3)
            
            let hStackView4 = hStack()
            let labelSubtitle = UILabel()
            labelSubtitle.text = "Show Subtitle?"
            hStackView4.addArrangedSubview(labelSubtitle)
            
            let toggleSubtitle = UISwitch()
            toggleSubtitle.addAction(.init(handler: { _ in
                self.isSubtitleEnabled.toggle()
                self.demoButton.setNeedsUpdateConfiguration()
            }), for: .touchUpInside)
            toggleSubtitle.isOn = isSubtitleEnabled
            hStackView4.addArrangedSubview(toggleSubtitle)
            
            vStackView.addArrangedSubview(hStackView4)
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
            if self.isSubtitleEnabled {
                config.subtitle = "Hello"
            }
            if self.isImageVisible {
                config.image = UIImage(systemName: "person")
                config.imagePadding = 8
            }
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
        let configs: [(String, UIButton.Configuration)] = [
            ("Filled", .filled()),
            ("Bordered", .bordered()),
            ("Bordered Prominent", .borderedProminent()),
            ("Bordered Tinted", .borderedTinted()),
            ("Borderless", .borderless()),
            ("Gray", .gray()),
            ("Plain", .plain())
        ]
        
        return menuButton(title: "Configs", configs: configs, saveTitle: true, action: action)
    }
    
    private func buttonSizeMenu(action: @escaping (UIButton.Configuration.Size?) -> Void) -> UIButton {
        let configs: [(String, UIButton.Configuration.Size?)] = [
            ("Size", nil),
            ("Large", .large),
            ("Medium", .medium),
            ("Small", .small),
            ("Mini", .mini)
        ]
        
        return menuButton(title: "Size", configs: configs, action: action)
    }
    
    private func cornerStyleMenu(action: @escaping (UIButton.Configuration.CornerStyle?) -> Void) -> UIButton {
        let configs: [(String, UIButton.Configuration.CornerStyle?)] = [
            ("Corner Style", nil),
            ("Large", .large),
            ("Medium", .medium),
            ("Small", .small),
            ("Dynamic", .dynamic),
            ("Capsule", .capsule),
            ("Fixed", .fixed)
        ]
        
        return menuButton(title: "Corner Style", configs: configs, action: action)
    }
    
    private func titleTextStyle(action: @escaping (UIFont.TextStyle?) -> Void) -> UIButton {
        let configs: [(String, UIFont.TextStyle?)] = [
            ("Title Text Style", nil),
            ("title1", .title1),
            ("title2", .title2),
            ("title3", .title3),
            ("large title", .largeTitle),
            ("headline", .headline),
            ("sub headline",.subheadline),
            ("body", .body),
            ("callout", .callout),
            ("caption1", .caption1),
            ("caption2", .caption2),
            ("footnote",.footnote)
        ]
        
        return menuButton(title: "Title Text Style", configs: configs, action: action)
    }
    
    private func imagePlacement(action: @escaping (NSDirectionalRectEdge?) -> Void) -> UIButton {
        let configs: [(String, NSDirectionalRectEdge?)] = [
            ("Image Placement", nil),
            ("leading", .leading),
            ("bottom", .bottom),
            ("trailing", .trailing),
            ("all", .all),
            ("top", .top)
        ]
        
        return menuButton(title: "Image Placement", configs: configs, action: action)
    }
    
    private func menuButton<T>(
        title: String,
        configs: [(String, T)],
        saveTitle: Bool = false,
        action: @escaping (T) -> Void
    ) -> UIButton {
        let button = UIButton()
        var menu = UIMenu()
        
        let children = configs.map {(key, size) in
            let action = UIAction(title: key) { _ in
                if saveTitle {
                    self.selectedConfigTitle = key
                }
                action(size)
                self.demoButton.setNeedsUpdateConfiguration()
            }
            if saveTitle && key == self.selectedConfigTitle {
                action.state = .on
            }
            return action
        }
        
        button.configuration = .borderless()
        menu = UIMenu(title: title, options: .singleSelection, children: children)
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        button.preferredMenuElementOrder = .automatic
        return button
    }
    
}
