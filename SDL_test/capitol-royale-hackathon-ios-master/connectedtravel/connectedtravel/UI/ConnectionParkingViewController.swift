//
//  ConnectionParkingViewController.swift
//  connectedtravel
//
//  Created by Tine Purg on 04/11/2019.
//  Copyright © 2019 Tine Purg. All rights reserved.
//
import UIKit
import SmartDeviceLink

class ConnectionParkingViewController: UIViewController, UINavigationControllerDelegate,
ProxyManagerDelegate {
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var table: UITableView!

    var proxyState = ProxyState.stopped
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - IBActions
    @IBAction func park(_ sender: UIButton) {
        let alertController = UIAlertController(title: "iOScreator", message:
            "msg", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
        let image = UIImage(systemName: "p.circle")
        DispatchQueue.main.async(execute: {[weak self]() -> Void in
            self?.button.setBackgroundImage(image, for: .normal)
        })
       
        
    }

    func didChangeProxyState(_ newState: ProxyState) {
        proxyState = newState;
        DispatchQueue.main.async(execute: {[weak self]() -> Void in
            self?.button.setBackgroundImage(UIImage(contentsOfFile: "p.circle"), for: .normal)
        })
    }
    
    func processJSON(){}
}


