//
//  ViewController.swift
//  HaHa
//
//  Created by Student on 2/8/18.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import AVFoundation

class HaHaViewController: UIViewController {
    let HA_HA_FILE = "haha"
    let HA_HA_FORMAT = "mp3"
    
    var player:AVAudioPlayer?
    var counter: Int
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var nelson: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        counter = 0;
        if let soundFilePath = Bundle.main.path(forResource: HA_HA_FILE, ofType: HA_HA_FORMAT) {
            let fileUrl = URL(fileURLWithPath: soundFilePath)
            do {
                player = try AVAudioPlayer(contentsOf: fileUrl)
            } catch let error as NSError {
                player = nil
                print(error)
            }
        } else {
            player = nil
        }
        player?.prepareToPlay()
        super.init(coder: aDecoder)
    }
    
    //HW: Add 2nd custom button that stops audio.
    @IBAction func playSound(_ sender: UIButton){
        if player != nil {
            player?.play()
            counter += 1
            label.text = "Ha Ha #\(counter)"
        }
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        //Animate button
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        shake.fromValue = NSValue(cgPoint: CGPoint(x: sender.center.x - 5, y: sender.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: sender.center.x + 5, y: sender.center.y))
        sender.layer.add(shake, forKey: "position")

        let shake2 = CABasicAnimation(keyPath: "position")
        shake2.duration = 0.1
        shake2.repeatCount = 2
        shake2.autoreverses = true
        shake2.fromValue = NSValue(cgPoint: CGPoint(x: nelson.center.x - 5, y: nelson.center.y))
        shake2.toValue = NSValue(cgPoint: CGPoint(x: nelson.center.x + 5, y: nelson.center.y))
        nelson.layer.add(shake2, forKey: "position")
    }
    
    //MARK: - View Events
    override func viewDidLoad() {
        super.viewDidLoad()
        label.shadowColor = UIColor.gray
        label.shadowOffset = CGSize(width: 3, height: -3)
        label.textColor = UIColor.white
        label.font = UIFont(name: "MarkerFelt-Wide", size: 30)
        label.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

