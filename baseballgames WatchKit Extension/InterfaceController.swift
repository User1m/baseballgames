//
//  InterfaceController.swift
//  baseballgames WatchKit Extension
//
//  Created by Claudius Mbemba on 3/27/16.
//  Copyright © 2016 Claudius Mbemba. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
  
  //  let stadiumList = ["Angel Stadium", "Citi Field", "AT&T Park",  "Chase Field"]
  
  @IBOutlet var teamLabel: WKInterfaceLabel!
  
  var session: WCSession!
  
  override init() {
    super.init()
    setupWCSession()
  }
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
    
    stadiumManager.initStadiums()
    loadStadiums()
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  @IBOutlet var picker: WKInterfacePicker!
  
  func loadStadiums() -> Void {
    var items:[WKPickerItem] = [WKPickerItem]()
    
    for s in stadiumManager.stadiums! {
      let item = WKPickerItem()
      item.title = s.name
      item.accessoryImage = WKImage(imageName: "baseball")
      //      item.contentImage = WKImage(imageName: s.image!)
      item.caption = s.city
      items.append(item)
    }
    
    teamLabel.setText(stadiumManager.stadiums![0].playDate)
    
    picker.setItems(items)
  }
  
  @IBAction func pickerChanged(value: Int) {
    // MARK: Haptic Feedback
    WKInterfaceDevice.currentDevice().playHaptic(.Click)
    
    teamLabel.setText(stadiumManager.stadiums![value].playDate)
  }
  
  @IBAction func switchSendData(value: Bool) {
    //    if (value) {
    sendData(.applicationContext, context: ["SwitchState":(value) ? "on" : "off"])
    
    let userinfo = ["fname":"Claudius",
                    "lname":"Mbemba",
                    "dob":"11/22/92",
                    "car":"Camero"]
    sendData(.userInfo, context: userinfo)
    
    let transfers = session.outstandingUserInfoTransfers
    print("Outstanding transfers: \(transfers)")
    
    //    let message = ["update":false]
    //    sendData(.sendMessage, context: message)
    
    //    }
  }
}

extension InterfaceController: WCSessionDelegate {
  
  enum sendDataType {
    case applicationContext
    case userInfo
    case sendMessage
  }
  
  func sendData(type: sendDataType, context:Dictionary<String, AnyObject>)  {
    do {
      switch type {
      case .applicationContext:
        try session.updateApplicationContext(context)
      case .userInfo:
        session.transferUserInfo(context)
      case .sendMessage:
        if(session.reachable){
          session.sendMessage(context, replyHandler: { (reply:[String : AnyObject]) -> Void in
            print(reply)
            }, errorHandler: { (error:NSError) -> Void in
              print(error)
          })
        }
      }
    } catch {
      print("error - send data failed")
    }
  }
  
  func setupWCSession() -> Void {
    //create Session
    if WCSession.isSupported() {
      session = WCSession.defaultSession()
      session.delegate = self
      session.activateSession()
      do {
        try session.updateApplicationContext( ["initiating" : "session from watch to phone" ])
      } catch _ {
        
      }
    }
  }
  
  // MARK: ApplicationContext
  func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
    print("Watch Context appContext: \(applicationContext)")
  }
  
  // MARK: UserInfo
  func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
    print("Watch Context userinfo: \(userInfo)")
  }
  
  // MARK: Message1
  func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
    print("Watch Context message: \(message)")
  }
  
  // MARK: Message2
  func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
    print("Message w/ message: \(message) and reply: \(replyHandler)")
  }
  
  // MARK: GlanceData
  override func handleUserActivity(userInfo: [NSObject : AnyObject]?) {
    print("Glance Data Recieved: \(userInfo)")
    //    if let info:stadium = userInfo as! stadium {
    teamLabel.setText((userInfo!["gKey"] as? String)!)
    //    }
  }

  // MARK: Local Notification
  override func handleActionWithIdentifier(identifier: String?, forLocalNotification localNotification: UILocalNotification) {
    let data = localNotification
    print(data)
  }
  
  // MARK: Remote Notification
  override func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification: [NSObject : AnyObject]) {
    let data = remoteNotification["myKey"] as? String
    print(data!)
  }
  
  // MARK: ForceTouch
  @IBAction func stadiumsForceTouch() {
    print("stadiumsForceTouch")
  }
  
  @IBAction func upcomingForceTouch() {
    print("upcomingForceTouch")

  }
  
  @IBAction func opposingForceTouch() {
    print("opposingForceTouch")

  }
  
  @IBAction func testForceTouch() {
    print("testForceTouch")

  }
  
}
