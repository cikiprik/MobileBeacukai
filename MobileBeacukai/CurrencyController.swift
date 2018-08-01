//
//  CurrencyController.swift
//  MobileBeacukai
//
//  Created by DEWA on 5/19/18.
//  Copyright © 2018 beacukai. All rights reserved.
//

import UIKit

class CurrencyController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBOutlet weak var tglKurs: UIDatePicker!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailCurrController = segue.destination as? DetailCurrController {
            detailCurrController.tglTerpilih = tglKurs.date
        }
    }
    
    @IBAction func btnOk(_ sender: Any) {
        
        
    // find kurs
       // tglkurs = tglKurs.date
        //print(tglkurs)
        
        
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
