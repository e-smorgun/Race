//
//  ViewController.swift
//  Race
//
//  Created by Evgeny on 18.05.22.
//

import UIKit

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

class ViewController: UIViewController {
    @IBOutlet var MainCar: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    var MainCarRect: CGRect = CGRect(x: -100, y: -100, width: 0, height: 0)
    var timer: Timer?
    var timerToCompare: Timer?
    var count = 0

    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        let carColor = UserDefaults.standard.string(forKey: UserDefaultsKey.kCars.rawValue)
        
        
        if UserDefaults.standard.object(forKey: UserDefaultsKey.kSpeed.rawValue) == nil {
            UserDefaults.standard.set(1, forKey: UserDefaultsKey.kSpeed.rawValue)}
        let difficult = UserDefaults.standard.integer(forKey: UserDefaultsKey.kSpeed.rawValue)
        
        switch(carColor){
        case "Red":
            MainCar.image = UIImage(named: "Red")
        case "Yellow":
            MainCar.image = UIImage(named: "Yellow")
        case "White":
            MainCar.image = UIImage(named: "White")
            default: MainCar.image = UIImage(named: "Red")}
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        leftGesture.direction = .left
        
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        rightGesture.direction = .right
        
        MainCarRect = CGRect(x: MainCar.frame.minX, y: MainCar.frame.minY, width: MainCar.frame.width, height: MainCar.frame.height)
        newCar()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(difficult), target: self, selector: #selector(newCar), userInfo: nil, repeats: true)
        
        self.view.addGestureRecognizer(leftGesture)
        self.view.addGestureRecognizer(rightGesture)
        super.viewDidLoad()
    }

    @objc func newCar() {
        let randomLine: Int = .random(in: 1...3)
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let image = UIImage(named: "NewCar")
        var randomXToCar = 0
        switch randomLine {
        case 1: randomXToCar = Int(screenWidth/2 - 168)
        case 2: randomXToCar = Int(screenWidth/2 - 33)
        case 3: randomXToCar = Int(screenWidth/2 + 102)
        default: break
        }
        
        var carRect: CGRect = CGRect(x: randomXToCar, y: -128, width: 66, height: 128)
        let car = UIImageView(frame: carRect)

        car.image = image
        self.view.addSubview(car)

        timerToCompare = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { timerToCompare in
            car.frame.origin.y += 8
            carRect.origin.y = car.frame.origin.y
        
            if carRect.minY > screenHeight {
                timerToCompare.invalidate()
                self.count += 1
                self.scoreLabel.text = "Score: \(self.count)"
            }
            if carRect.intersects(self.MainCarRect){
                timerToCompare.invalidate()
                self.view.willRemoveSubview(car)
                self.timer?.invalidate()
                
                self.saveRecord(score: self.count)
                
                let alert = UIAlertController(title: "Game Over", message: ":(((", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Menu", style: .default, handler: { action in
                    self.navigationController?.popToRootViewController(animated: true)
                }))
                alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { action in
                    car.removeFromSuperview()
                    self.count = 0
                    self.scoreLabel.text = "Score: \(self.count)"
                    self.newCar()
                    self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.newCar), userInfo: nil, repeats: true)
                }))
                self.present(alert, animated: true)
            }
        })
    }
    
    
    @objc func didSwipe(sender: UISwipeGestureRecognizer){
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        switch sender.direction {
        case .left:
            if MainCar.center.x - 135 > 0 {
            UIView.animate(withDuration: 0.2, delay: 0, options: .allowAnimatedContent) {
                self.view.layoutIfNeeded()
                self.leftConstraint.constant -= 135
                self.rightConstraint.constant += 135
                self.MainCar.center.x -= 135
                self.MainCarRect.origin.x = self.MainCar.frame.minX
            }
            }
        case .right:
            if MainCar.center.x + 135 < screenWidth {
            UIView.animate(withDuration: 0.2, delay: 0, options: .allowAnimatedContent) {
                self.view.layoutIfNeeded()
                self.leftConstraint.constant += 135
                self.rightConstraint.constant -= 135
                self.MainCar.center.x += 135
                self.MainCarRect.origin.x = self.MainCar.frame.minX
            }
        }
        default:
            break
        }
    }
    
    func saveRecord(score: Int) {
        if UserDefaults.standard.object(forKey: UserDefaultsKey.kRecords.rawValue) == nil {
            var records: [Records] = []
            let record = Records(scoreGame: self.count, dataGame: Date())
            records.append(record)
            UserDefaults.standard.set(try? PropertyListEncoder().encode(records), forKey: UserDefaultsKey.kRecords.rawValue)
        } else {
        
        if let recordsData: Data =  UserDefaults.standard.object(forKey:  UserDefaultsKey.kRecords.rawValue) as? Data {
            if var records: [Records] = try? PropertyListDecoder().decode(Array<Records>.self, from: recordsData) {
                    let record = Records(scoreGame: self.count, dataGame: Date())
                    records.append(record)
                    
                    let newRecods = records.sorted(by: {
                        return $0.scoreGame > $1.scoreGame
                    })
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(newRecods), forKey: UserDefaultsKey.kRecords.rawValue)
                }
            }
        }
    }
    
}
