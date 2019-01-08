//
//  ViewController.swift
//  Bull's Eye
//
//  Created by Ahmed adham on 10/22/18.
//  Copyright © 2018 Ahmed adham. All rights reserved.
//

import UIKit

class HomeVC : UIViewController {

    var currentValue : Int = 0
    var targetValue : Int = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider : UISlider!
    @IBOutlet weak var targetLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var roundLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewGame()
        updateLabels()
    }

    @IBAction func startOver(){
        startNewGame()
        updateLabels()
    }
    func startNewGame(){
        score = 0
        round = 0
        startRound()
    }
    
    func startRound(){
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    @IBAction func sliderMoved(_ slider : UISlider){
        currentValue = lroundf(slider.value)
    }

    @IBAction func showAlert(){
    
        let difference : Int = abs(targetValue - currentValue)
        var points = 100 - difference
        score += points
        
        let title : String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        }
        else if difference < 5 {
            title = "you almost had it!"
            points += 50
        }
        else if difference < 10 {
            title = "Pretty good!"
        }
        else {
            title = "Not even close!"
        }
        let message = "Your Score \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startRound()
            self.updateLabels()
        
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }


}

