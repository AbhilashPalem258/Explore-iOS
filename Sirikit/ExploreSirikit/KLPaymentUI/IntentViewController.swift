//
//  IntentViewController.swift
//  KLPaymentUI
//
//  Created by Abhilash Palem on 04/10/22.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    private var rideButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ride Now", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.titleLabel?.font = UIFont.init(name: "Helvetica-New", size: 20.0)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        // Do configuration here, including preparing views and calculating a desired size for presentation.
//        guard let intent = interaction.intent else {
//            completion(true, parameters, self.desiredSize)
//            return
//        }
        let intent = interaction.intent
        if intent is INRequestPaymentIntent {
            view.backgroundColor = .green
            view.addSubview(rideButton)
            rideButton.addTarget(self, action: #selector(rideButtonTapped), for: .touchUpInside)
            rideButton.translatesAutoresizingMaskIntoConstraints = false
            rideButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            rideButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            rideButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
            rideButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        } else if intent is INSendPaymentIntent {
            view.backgroundColor = .red
        }
        completion(true, parameters, self.desiredSize)
    }
    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
    @objc func rideButtonTapped() {
        print("Ride Button tapped")
    }
    
}
