//
//  MenuViewController.swift
//  Big Cube
//
//  Created by Jake Leventhal on 4/30/18.
//  Copyright © 2018 Jake Leventhal. All rights reserved.
//

import UIKit
import AVFoundation
import FirebaseAuth
import FBSDKLoginKit

class MenuViewController: UIViewController {
	
	@IBOutlet weak var closeButton: UIButton!
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	
	// constraints
	@IBOutlet weak var friendsConstraint: NSLayoutConstraint!
	@IBOutlet weak var leaderboardsConstraint: NSLayoutConstraint!
	@IBOutlet weak var settingsConstraint: NSLayoutConstraint!
	@IBOutlet weak var logoutConstraint: NSLayoutConstraint!
	
	let name: String! = Auth.auth().currentUser!.displayName
	
	@IBAction func dismissMenu(_ sender: Any) {
		clickSound()
		self.dismiss(animated: true, completion: nil)
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		clickSound()
		
		// update the username label
		usernameLabel.text = name
		
		// adjust the constraints to fit the screen
		adjustConstraints()
		
		// update the score label
		ref.child("users/\(userID!)").child("score").observeSingleEvent(of: .value) { (snapshot) in
			if let score = snapshot.value as? Int {
				self.scoreLabel.text = "Score: \(score)"
			}
		}
    }
	
	func adjustConstraints() {
		let multiplier: CGFloat = UIScreen.main.bounds.height / 700
		self.friendsConstraint.constant *= multiplier
		self.leaderboardsConstraint.constant *= multiplier
		self.settingsConstraint.constant *= multiplier
		self.logoutConstraint.constant *= multiplier
	}
	
	@IBAction func goToFriends(_ sender: Any) {
		clickSound()
	}
	
	@IBAction func goToLeaderboards(_ sender: Any) {
		clickSound()
	}
	
	@IBAction func goToSettings(_ sender: Any) {
		clickSound()
	}
	
	@IBAction func logout(_ sender: Any) {
		// logout of Facebook
		FBSDKLoginManager().logOut()
	}
}

func clickSound() {
	if menuSoundsOn {
		menuSoundPlayer.play()
	}
}
