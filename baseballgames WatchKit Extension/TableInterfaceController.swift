//
//  TableInterfaceController.swift
//  baseballgames
//
//  Created by Claudius Mbemba on 4/2/16.
//  Copyright © 2016 Claudius Mbemba. All rights reserved.
//

import WatchKit
import Foundation


class TableInterfaceController: WKInterfaceController {
  
  @IBOutlet var table: WKInterfaceTable!
  
  //  let stadiumList = ["Angel Stadium", "Citi Field", "AT&T Park",  "Chase Field", "Dodger Stadium"]
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
    loadTable()
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  
  func loadTable() {
    table.setNumberOfRows(stadiumManager.stadiums!.count, withRowType: "row")
    
    for (i, s) in stadiumManager.stadiums!.enumerate() {
      
      let row = table.rowControllerAtIndex(i) as! TableRow
      row.rowLabel.setText(s.name)
    }
  }
  
  override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
    let item = stadiumManager.stadiums![rowIndex]
    print(item)
  }
  
  override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
    if segueIdentifier == "details" {
      return stadiumManager.stadiums![rowIndex]
    }
    return nil
  }
  
}
