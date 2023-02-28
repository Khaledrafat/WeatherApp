//
//  ViewController.swift
//  WeatherApp
//
//  Created by mac on 26/02/2023.
//

import UIKit
import Lottie

class SplashVC : ParentVC {

    @IBOutlet weak var LottieView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLottie()
    }
    
    // MARK: - Navigate To Home
    private func navigateToHome() {
        let vc = HomeVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        self.present(nav, animated: true, completion: nil)
    }

    // MARK: - Setup Lottie
    private func setupLottie() {
        LottieView.contentMode = .scaleAspectFit
        LottieView.loopMode = .loop
        LottieView.animationSpeed = 0.5
        LottieView.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.navigateToHome()
        }
    }
}

