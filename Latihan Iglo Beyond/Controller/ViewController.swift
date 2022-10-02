//
//  ViewController.swift
//  Latihan Iglo Beyond
//
//  Created by Muhammad Alwan on 08/09/22.
//

import UIKit

// variable & outlet
class ViewController: UIViewController {
    
    @IBOutlet weak var splashScreenImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSplashScreen()
        animateSplashScreen(completion: {
            self.goToLoginVC()
        })
    }
    
    private func setupSplashScreen() {
        splashScreenImageView.alpha = 0
    }
    
    private func animateSplashScreen(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 1.5, delay: 0.0, options: .curveEaseIn, animations: {
            self.splashScreenImageView.alpha = 1.0
        }, completion: { _ in
            completion()
        })
    }
    
    private func goToLoginVC() {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = loginStoryboard.instantiateInitialViewController() as! LoginViewController
        loginViewController.modalPresentationStyle = .fullScreen
        loginViewController.modalTransitionStyle = .crossDissolve
        self.present(loginViewController, animated: true)
    }
    
}
