//
//  ViewControllerGameOver.swift
//  Race
//
//  Created by Evgeny on 18.05.22.
//

import UIKit

class ViewControllerGameOver: UIViewController {
    @IBOutlet weak var ScoreLabel: UILabel!
    
    var score = 0
    override func viewDidLoad() {
        ScoreLabel.text = "Score: \(score)"
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapTryAgainButton(){
        
    }


}
