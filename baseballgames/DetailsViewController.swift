//
//  DetailsViewController.swift
//  baseballgames
//
//  Created by Claudius Mbemba on 4/3/16.
//  Copyright © 2016 Claudius Mbemba. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var playDateLabel: UILabel!
  @IBOutlet weak var opposingTeamLabel: UILabel!
  @IBOutlet weak var dismissButton: UIButton!

  var currentStadium = stadium()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.

  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    nameLabel.text = currentStadium.name
    playDateLabel.text = currentStadium.playDate
    opposingTeamLabel.text = currentStadium.opposingTeam
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func dismiss(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
