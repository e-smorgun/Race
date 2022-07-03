//
//  ViewControllerSettings.swift
//  Race
//
//  Created by Evgeny on 12.06.22.
//

import UIKit
extension UIImageView {
    func setActiveCar() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.569, green: 0.561, blue: 0.882, alpha: 1).cgColor
        layer.cornerRadius = 10
    }
    
    func setPassiveCar() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.cornerRadius = 10
    }
}
class ViewControllerSettings: UIViewController {
    @IBOutlet weak var imageRedCar: UIImageView!
    @IBOutlet weak var imageYellowCar: UIImageView!
    @IBOutlet weak var imageWhiteCar: UIImageView!
    @IBOutlet weak var slideLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    class Records: Codable {
        let scoreGame: Int
        let dateGame: Date

        init(scoreGame: Int, dataGame: Date) {
            self.scoreGame = scoreGame
            self.dateGame = dataGame
        }
    }
    
    enum UserDefaultsKey: String {
        case kRecords = "kRecords"
        case kCars = "kCars"
        case kSpeed = "kSpeed"
    }
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Settings"
        
        let carColor = UserDefaults.standard.string(forKey: "kCars")
        let difficult = UserDefaults.standard.integer(forKey: "kSpeed")
        slider.value = Float(difficult)
        slideLabel.text = String(Int(slider.value))

        
        imageRedCar.image = UIImage(named: "Red")
        imageYellowCar.image = UIImage(named: "Yellow")
        imageWhiteCar.image = UIImage(named: "White")

        switch(carColor){
        case "Red":
            imageRedCar.setActiveCar()
            imageYellowCar.setPassiveCar()
            imageWhiteCar.setPassiveCar()
        case "Yellow":
            imageRedCar.setPassiveCar()
            imageYellowCar.setActiveCar()
            imageWhiteCar.setPassiveCar()
        case "White":
            imageRedCar.setPassiveCar()
            imageYellowCar.setPassiveCar()
            imageWhiteCar.setActiveCar()
            default: break}
    
        let redCarGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRedCar))
        let whiteCarGesture = UITapGestureRecognizer(target: self, action: #selector(didTapWhiteCar))
        let yellowCarGesture = UITapGestureRecognizer(target: self, action: #selector(didTapYellowCar))
        
        imageRedCar.isUserInteractionEnabled = true
        imageYellowCar.isUserInteractionEnabled = true
        imageWhiteCar.isUserInteractionEnabled = true

        imageRedCar.addGestureRecognizer(redCarGesture)
        imageYellowCar.addGestureRecognizer(yellowCarGesture)
        imageWhiteCar.addGestureRecognizer(whiteCarGesture)
        super.viewDidLoad()
    }

    @objc func didTapRedCar() {
        imageRedCar.setActiveCar()
        imageYellowCar.setPassiveCar()
        imageWhiteCar.setPassiveCar()
        
        UserDefaults.standard.set("Red", forKey: "kCars")
    }
    
    @objc func didTapYellowCar() {
        imageRedCar.setPassiveCar()
        imageYellowCar.setActiveCar()
        imageWhiteCar.setPassiveCar()
        
        UserDefaults.standard.set("Yellow", forKey: "kCars")
    }
    
    @objc func didTapWhiteCar() {
        imageRedCar.setPassiveCar()
        imageYellowCar.setPassiveCar()
        imageWhiteCar.setActiveCar()
        
        UserDefaults.standard.set("White", forKey: "kCars")
    }
    
    @IBAction func slider(_ sender: UISlider)
    {
        slideLabel.text = String(Int(sender.value))
        UserDefaults.standard.set(slideLabel.text, forKey: "kSpeed")
    }
    
}
