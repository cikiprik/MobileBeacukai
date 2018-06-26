//
//  DutyCalcController.swift
//  MobileBeacukai
//
//  Created by DEWA on 6/25/18.
//  Copyright © 2018 beacukai. All rights reserved.
//

import UIKit

class DutyCalcController: UIViewController {
    var selectedJnsImpor = Int()
    var selectedJnsBrg = String()
    var selectedJnsValuta = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedJnsImpor)
        print(selectedJnsBrg)
        print(selectedJnsValuta)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
