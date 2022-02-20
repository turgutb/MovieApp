//
//  SplashViewController.swift
//  MovieApp
//
//  Created by MacBook on 20.02.2022.
//

import UIKit
import Firebase
import FirebaseRemoteConfig

class SplashViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var remoteConfig = RemoteConfig.remoteConfig()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()

    }
    
    func loadUI() {
        NetworkMonitor.shared.startMonitoring()
        if NetworkMonitor.shared.isConnected {
            print("Is Connected")
            setupRemoteConfig()
            fetchRemoteConfig()
            setLabelText()
            goToVC()
        } else {
            let alert = UIAlertController(title: "Hata", message: "İnternet Bağlantınız Kontrol Ediniz.", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: {_ in
                            exit(0)
                        }))
                        self.present(alert, animated: true, completion: nil)
                        return
        }
    }
    
    func setupRemoteConfig() {
        let defaultValues = [
            "title" : "LOODOS" as NSObject
            ]
        RemoteConfig.remoteConfig().setDefaults(defaultValues)
    }
    func fetchRemoteConfig() {
        let settings = RemoteConfigSettings()
            settings.minimumFetchInterval = 0
            remoteConfig.configSettings = settings
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) { Status, error in
            guard error == nil else {
                print("\(error)")
                return
            }
            print("Value in clouded")
            self.remoteConfig.activate()
        }
    }
    
    func setLabelText() {
        let labelText = RemoteConfig.remoteConfig().configValue(forKey: "title").stringValue ?? ""
        print("labelText:", labelText)
        var charIndex = 0.0
        for letter in labelText {
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) {
                (timer) in
                self.label.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    func goToVC() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyboard.instantiateViewController(withIdentifier: "TvShowViewController") as! TvShowViewController
            let navigationController = UINavigationController(rootViewController: detailVC)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
        }
    }
}
