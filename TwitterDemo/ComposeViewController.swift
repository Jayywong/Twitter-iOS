//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by Jason Wong on 3/4/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var replytext: UITextField!
    
    var tweet: Tweet!
    //var profileimg: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //profileImageView.setImageWith(profileimg as! URL)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func SendButtonClicked(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol ComposeViewControllerDelegate: class {
    
}
