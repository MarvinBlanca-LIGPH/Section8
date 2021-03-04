//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
//    let eggTimes = [
//        "Soft" : 300,
//        "Medium" : 420,
//        "Hard" : 720
//    ]
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressVIew: UIProgressView!
    let eggTimes = [
        "Soft" : 3,
        "Medium" : 4,
        "Hard" : 7
    ]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player = AVAudioPlayer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        player.stop()
        progressVIew.progress = 0
        secondsPassed = 0
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressVIew.progress = Float(secondsPassed)/Float(totalTime)
        } else {
            playSound()
            timer.invalidate()
            titleLabel.text = "Egg's Done!!!"
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: ".mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
