//
//  stadiumManager.swift
//  baseballgames
//
//  Created by Claudius Mbemba on 4/2/16.
//  Copyright © 2016 Claudius Mbemba. All rights reserved.
//

import UIKit

class stadiumManager: NSObject {
  
  static var stadiums:[stadium]? = []
  
  static func initStadiums() {
    let s1 = stadium()
    s1.name = "Citi Field"
    s1.city = "Chicago"
    s1.image = "baseball"
    s1.playDate = "4/3/16"
    s1.opposingTeam =  "Blue Jays"
    
    let s2 = stadium()
    s2.name = "AT&T Park"
    s2.city = "San Francisco"
    s2.image = "baseball"
    s2.playDate = "4/14/16"
    s2.opposingTeam =  "Blue Jays"
    
    let s3 = stadium()
    s3.name = "Chase Field"
    s3.city = "Phenoix"
    s3.image = "baseball"
    s3.playDate = "4/3/16"
    s3.opposingTeam =  "Yankees"
    
    
    self.stadiums?.append(s1)
    self.stadiums?.append(s2)
    self.stadiums?.append(s3)
  
  }
  
}
