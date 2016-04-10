//
//  DetailsInterfaceController.swift
//  baseballgames
//
//  Created by Claudius Mbemba on 4/2/16.
//  Copyright © 2016 Claudius Mbemba. All rights reserved.
//

import WatchKit
import Foundation


class DetailsInterfaceController: WKInterfaceController {
  
  
  @IBOutlet var nameLabel: WKInterfaceLabel!
  @IBOutlet var cityLabel: WKInterfaceLabel!
  @IBOutlet var gameDateLabel: WKInterfaceLabel!
  @IBOutlet var opponentLabel: WKInterfaceLabel!
  @IBOutlet var image: WKInterfaceImage!
  
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
    
    if let stadium = context as? stadium {
      nameLabel.setText(stadium.name)
      cityLabel.setText(stadium.city)
      gameDateLabel.setText(stadium.playDate)
      opponentLabel.setText(stadium.opposingTeam)
      image.setImageNamed(stadium.image!)
    }
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
}
