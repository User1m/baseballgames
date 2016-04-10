//
//  ViewController.swift
//  baseballgames
//
//  Created by Claudius Mbemba on 3/27/16.
//  Copyright © 2016 Claudius Mbemba. All rights reserved.
//

import UIKit
import WatchConnectivity


//set delegate and datasource delegates as self - can be done in interface xib as well
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
  
  @IBOutlet weak var stadiumPicker: UIPickerView!
  @IBOutlet weak var detailsButton: UIButton!
  @IBOutlet weak var setDefaultsButton: UIButton!
  @IBOutlet weak var dataLabel: UILabel!
  @IBOutlet weak var sendButton: UIButton!
  
  var session: WCSession!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    setupWCSession()
    
    stadiumPicker.delegate = self
    stadiumPicker.dataSource = self
    stadiumManager.initStadiums()
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return (stadiumManager.stadiums?.count)!
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return (stadiumManager.stadiums![row].name)!
  }
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let destination = segue.destinationViewController as! DetailsViewController
    destination.currentStadium = stadiumManager.stadiums![self.stadiumPicker.selectedRowInComponent(0)]
  }
  
}

extension ViewController: WCSessionDelegate {
  
  func setupWCSession() {
    if WCSession.isSupported() {
      session = WCSession.defaultSession()
      session.delegate = self
      session.activateSession()
      do {
        try session.updateApplicationContext( ["initiating" : "session from phone to watch" ])
      } catch _ {
        
      }
    }
  }
  
  enum sendDataType {
    case applicationContext
    case userInfo
    case sendMessage
  }
  
  func sendData(type: sendDataType, context:Dictionary<String, AnyObject>)  {
    if session.paired == true {
      do {
        switch type {
        case .applicationContext:
          try session.updateApplicationContext(context)
        case .userInfo:
          let transferResult = session.transferUserInfo(context)
          print("Transfer result: \(transferResult)")
        case .sendMessage:
          if(session.reachable){
            //            session.sendMessage(context, replyHandler: { (reply:[String : AnyObject]) -> Void in
            //              print(reply)
            //              }, errorHandler: { (error:NSError) -> Void in
            //                print(error)
            //            })
            session.sendMessage(context, replyHandler: nil, errorHandler: nil)
          }
        }
      } catch {
        print("error - send data failed")
      }
    } else {
      print("not paired")
    }
  }
  
  @IBAction func sendDataToWatch(sender: AnyObject) {
    /*
     let appcontext = ["key":"value"]
     sendData(.applicationContext, context: appcontext)
     */
    /*
     let userinfo = ["fname":"max",
     "lname":"april",
     "dob":"12/3/92",
     "car":"Camero"]
     sendData(.userInfo, context: userinfo)
     
     let transfers = session.outstandingUserInfoTransfers
     print("Outstanding transfers: \(transfers)")
     */
    
    let message = ["update":true]
    sendData(.sendMessage, context: message)
  }
  
  // MARK: App Context
  func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
    print("Phone Context: \(applicationContext)")
    
    dispatch_async(dispatch_get_main_queue(), {
      self.dataLabel.text = "Switch is: " + (applicationContext["SwitchState"] as! String)
    })
  }
  
  // MARK: userinfo
  func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
    print("UserInfo: \(userInfo)")
  }
  
  // MARK: Message1
  func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
    print("Message: \(message)")
  }
  
  // MARK: Message2
  func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
    print("Message w/ message: \(message) and reply: \(replyHandler)")
  }
  
}

