//
//  SiriShortcutVC.swift
//  ExploreUserActivity
//
//  Created by Abhilash Palem on 03/03/23.
//

import UIKit
import Intents
import IntentsUI

class SiriShortcutVC: UIViewController {
    
    let type = "com.abhilash.exploreUserActivity.SiriShortcut"
    
    lazy var shortcutBtn: UIButton = {
        let btn = UIButton(frame: .init(x: 0, y: 0, width: 200, height: 100))
        btn.tintColor = UIColor.orange
        btn.titleLabel?.textColor = .white
        btn.setTitle("Add Shortcut", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(shortcutBtn)
        shortcutBtn.center = self.view.center
        shortcutBtn.addTarget(self, action: #selector(shortcutBtnTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activateActivity()
    }
    
    @objc func shortcutBtnTapped() {
        presentSiriAddViewController()
    }
    
}
extension SiriShortcutVC {
    func activateActivity() {
        let title = "Siri Shortcut w UserActivity"
        let activity = NSUserActivity(activityType: type)
        activity.title = title
        activity.userInfo = [
            "info": Bundle.main.infoDictionary!
        ]
        activity.suggestedInvocationPhrase = title
        activity.isEligibleForPrediction = true
        self.userActivity = activity
    }
    
    func presentSiriAddViewController() {
        guard let activity = self.userActivity else { return }
        let shortcut = INShortcut(userActivity: activity)
        let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        vc.modalPresentationStyle = .formSheet
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}
extension SiriShortcutVC: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true)
    }
}
