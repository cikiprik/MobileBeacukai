//
//  TrackingController.swift
//  MobileBeacukai
//
//  Created by DEWA on 5/9/18.
//  Copyright © 2018 beacukai. All rights reserved.
//

import UIKit
import CryptoSwift

class TrackingController: UIViewController {

    @IBOutlet weak var btnTracking: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onTracking(_ sender: Any) {
        print("Track")
        let util = Utils()
         let token = util.encrypt()
        print(token)
        let tgl = "17-05-2018"
    
        var request = URLRequest(url: URL(string: "https://esbbcext01.beacukai.go.id:9089/RestBeacukaiApi/kurs")!)
        request.httpMethod = "POST"
        let postString = "tglKurs=\(tgl)&src=\(token)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                
            }
            
//            let responseString = String(data: data, encoding: .utf8)
            
            guard let kurs = try? JSONDecoder().decode(Kurs.self, from: data) else {
                print("Error: Couldn't decode data into Blog")
                return
            }
            
            print("kurs: \(kurs.noSkep)")
            print("kurs: \(kurs.tglSkep)")
            
            print("details:")
            for detail in kurs.details {
                print("- \(detail.valuta)")
            }
        }
        task.resume()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    struct Kurs: Decodable {
        let noSkep: String
        let tglSkep: String
        let tglAwal: String
        let tglAkhir: String
        
        let details: [Detail]
        
        enum CodingKeys : String, CodingKey {
            case noSkep
            case tglSkep
            case tglAwal
            case tglAkhir
            case details = "detail"
        }
    }
    
    struct Detail: Decodable {
        let valuta: String
        let flag: URL
        let value: String
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
