//
//  MeasureViewController.swift
//  Measureify
//
//  Created by Gokul Nair on 10/10/20.
//

import UIKit

class MeasureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ARMeasureKit(_ sender: Any) {
        self.performSegue(withIdentifier: "arMeasure", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
