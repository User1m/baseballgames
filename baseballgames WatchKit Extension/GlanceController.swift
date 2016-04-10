//
//  GlanceController.swift
//  baseballgames WatchKit Extension
//
//  Created by Claudius Mbemba on 3/27/16.
//  Copyright © 2016 Claudius Mbemba. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {
  
  @IBOutlet var stadiumLabel: WKInterfaceLabel!
  @IBOutlet var playDateLabel: WKInterfaceLabel!
  @IBOutlet var image: WKInterfaceImage!
  @IBOutlet var teamLbl: WKInterfaceLabel!
  
  var timer = NSTimer()
  var counter = 0
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    
    stadiumManager.initStadiums()
    
    let s = setupGlance()
    
    //webpage is for handoff
    updateUserActivity("com.Glance.ScheduleUpdate", userInfo: ["gKey":"\(s.city!)"], webpageURL: nil)
    
    startTimer()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  func startTimer(){
    timer = NSTimer.scheduledTimerWithTimeInterval(5.0,
                                                   target: self,
                                                   selector: #selector(GlanceController.updateTimerData(_:)),
                                                   userInfo: nil,
                                                   repeats: true)
    
  }
  
  func updateTimerData(timer:NSTimer) -> Void {
    // MARK: Grab data & update Glance
    print("fired")
    
    setupGlance()
  }
  
  
  func setupGlance() -> stadium {
    
    let s:stadium = stadiumManager.stadiums![counter++]

    if counter >= stadiumManager.stadiums?.count {
      counter = 0
    }
    stadiumLabel.setText(s.city)
    teamLbl.setText(s.name)
    playDateLabel.setText(s.playDate)
    
    return s
  }
}
