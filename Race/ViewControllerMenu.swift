//
//  ViewControllerMenu.swift
//  Race
//
//  Created by Evgeny on 26.05.22.
//

import UIKit

extension UIButton {
    func setCustomButton(x: Int, y: Int, title: String) {
        layer.cornerRadius = 5
        layer.backgroundColor = UIColor(red: 0.569, green: 0.561, blue: 0.882, alpha: 1).cgColor
        frame = CGRect(x: x/2-100, y: y, width: 200, height: 45)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
    }
}

class ViewControllerMenu: UIViewController {
    var startButton: UIButton = UIButton()
    var tableButton: UIButton = UIButton()
    var settingsButton: UIButton = UIButton()
    var scoreLabel: UILabel = UILabel()
        
    override func viewDidLoad() {
        let name = "Racer :))))"
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 48)]
        let myString = NSMutableAttributedString(string: name, attributes: myAttribute as [NSAttributedString.Key : Any] )
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let myRange = NSRange(location: 0, length: 5)

        startButton.setCustomButton(x: Int(screenWidth), y: 200, title: "Start")
        tableButton.setCustomButton(x: Int(screenWidth), y: 270, title: "Table")
        settingsButton.setCustomButton(x: Int(screenWidth), y: 340, title: "Settings")

        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: myRange)
        scoreLabel.frame = CGRect(x: screenWidth/2-150, y: 70, width: 500, height: 90)
        scoreLabel.attributedText = myString

        
        startButton.addTarget(self, action: #selector(didTapStartGame), for: .touchUpInside)
        tableButton.addTarget(self, action: #selector(didTapTableButton), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(didTapSettingsButton), for: .touchUpInside)

        view.addSubview(scoreLabel)
        view.addSubview(startButton)
        view.addSubview(tableButton)
        view.addSubview(settingsButton)

        super.viewDidLoad()
    }
    
    @objc func didTapStartGame() {
        let story: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: ViewController = story.instantiateViewController(withIdentifier: "Game") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapSettingsButton() {
        let story: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: ViewControllerSettings = story.instantiateViewController(withIdentifier: "Settings") as! ViewControllerSettings
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapTableButton() {
        let story: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: ViewControllerTable = story.instantiateViewController(withIdentifier: "Table") as! ViewControllerTable
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
