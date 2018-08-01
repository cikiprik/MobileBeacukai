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

    @IBOutlet weak var txtVwTracking: UITextView!
    @IBOutlet weak var txtAwb: UITextField!
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
        let awb = txtAwb.text
    
        var request = URLRequest(url: URL(string: "https://esbbcext01.beacukai.go.id:9089/RestBeacukaiApi/TrackingBarangKiriman")!)
        request.httpMethod = "POST"
        let postString = "par=\(awb ?? "-")&src=\(token)"
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
            
            guard let dataBangkir = try? JSONDecoder().decode(BarangKiriman.self, from: data) else {
                print("Error: Couldn't decode data ")
                return
            }
            
            print("kurs: \(dataBangkir.success)")
            print("kurs: \(dataBangkir.message)")
//            if(dataBangkir.success == "true"){
//                self.txtVwTracking.text  = "Data Ada"
//            } else {
//                self.txtVwTracking.text = "Data Tidak Ditemukan"
//            }
//            print("details:")
//            for detail in dataBangkir.details {
//                print("- \(detail.namaPemberitahu)")
//            }
        }
        task.resume()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    struct BarangKiriman: Decodable {
        let success: String
        let message: String
        
        
        let details: [Detail]
        
        enum CodingKeys : String, CodingKey {
            case success
            case message
            case details = "detail"
        }
    }
    
    struct Detail: Decodable {
        let cif: String
        let kodeBilling: String
        let namaPemberitahu: String
        let namapenerima: String
        let namapengirim: String
        let noHouseAwb: String
        let tglHouseAwb: String
        let status: [Status]
    }
    
    struct Status: Decodable {
        let ket: String
        let kode: String
        let wk: String
      
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
