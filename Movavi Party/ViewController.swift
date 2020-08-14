//
//  ViewController.swift
//  Movavi Party
//
//  Created by Max Nikulin on 07.06.2019.
//  Copyright © 2019 Movavi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var beerSwitch: UISwitch!
  @IBOutlet weak var ufoSwitch: UISwitch!
  @IBOutlet weak var rockMusicSwitch: UISwitch!
  
  @IBOutlet weak var beerLabel: UILabel!
  @IBOutlet weak var ufoLabel: UILabel!
  @IBOutlet weak var movingUfoLabel: UILabel!
  @IBOutlet weak var rockMusicLabel: UILabel!
  
  @IBOutlet weak var ufoLeft: NSLayoutConstraint!
  
  var player: AVAudioPlayer = AVAudioPlayer()
  
  var beerState: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    self.beerSwitch.transform = CGAffineTransform.init(scaleX: 3, y: 3)
    self.ufoSwitch.transform = CGAffineTransform.init(scaleX: 3, y: 3)
    self.rockMusicSwitch.transform = CGAffineTransform.init(scaleX: 3, y: 3)
    
    self.beerState = beerSwitch.isOn
  }

  @IBAction func beerSwitched(_ sender: Any) {
    
    if beerSwitch.isOn {
      if !self.beerState {
        let alertController = UIAlertController.init(title: "Вы уверены?", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: "Да", style: .default, handler: { (action) in
          self.beerLabel.text = "Всё пиво"
        }))
        alertController.addAction(UIAlertAction.init(title: "Да", style: .cancel, handler: { (action) in
          self.beerLabel.text = "Всё пиво"
        }))
        self.show(alertController, sender: nil)
      }
    } else {
      beerLabel.text = "Одно пиво"
    }
  }
  
  @IBAction func ufoSwitched(_ sender: Any) {

    if ufoSwitch.isOn {
      ufoLabel.isHidden = true
      
      ufoLeft.constant = 0
      view.updateConstraints()
      view.layoutIfNeeded()
      self.movingUfoLabel.font = UIFont.systemFont(ofSize: 50)
      movingUfoLabel.text = "🛸"
      movingUfoLabel.isHidden = false
      animateUfo()
    }  else {
      ufoLabel.isHidden = false
      movingUfoLabel.isHidden = true
      
      rockMusicLabel.isHidden = true
      player.stop()
    }
  }
  
  @IBAction func rockMusicSwitched(_ sender: Any) {
    if rockMusicSwitch.isOn {
      rockMusicLabel.text = "🎸"
      playGarageRock()
    } else {
      rockMusicLabel.text = "Включить\nгаражный рок"
      player.stop()
    }
  }
  
  func animateUfo() {
    ufoLeft.constant = self.view.center.x - 30
    
    UIView.animate(withDuration: 3.1, delay: 0.5, options: .curveEaseOut, animations: {
      self.view.layoutIfNeeded()
    }, completion: { finished in
      
      self.ufoLeft.constant -= 60
      self.view.layoutIfNeeded()
      self.movingUfoLabel.font = UIFont.systemFont(ofSize: 150)
      self.movingUfoLabel.text = "💥"
      self.playGarageRock();
    })
  }
  
  func playGarageRock() {
    do {
      let path = Bundle.main.path(forResource: "Link Wray - Rumble", ofType: "mp3")
      let url = URL.init(fileURLWithPath: path!)
      player = try AVAudioPlayer(contentsOf: url)
      player.play()
      
      rockMusicLabel.text = "Включен гаражный рок"
      rockMusicLabel.isHidden = false
    } catch {
      
    }
  }
}
