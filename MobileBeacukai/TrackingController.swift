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

    @IBOutlet weak var txtVwHasil: UITextView!
    @IBOutlet weak var txtAwb: UITextField!
    @IBOutlet weak var btnTracking: UIButton!
    
    @IBOutlet weak var lblCif: UILabel!
    @IBOutlet weak var lblKdBilling: UILabel!
    @IBOutlet weak var lblPemberitahu: UILabel!
    @IBOutlet weak var lblPenerima: UILabel!
    @IBOutlet weak var lblPengirim: UILabel!
    
    
    @IBOutlet weak var lblJudulCif: UILabel!
    @IBOutlet weak var lblJudulKdBilling: UILabel!
    
    @IBOutlet weak var lblJudulPemberitahu: UILabel!
    
    @IBOutlet weak var lblJudulPenerima: UILabel!
    
    @IBOutlet weak var lblJudulPengirim: UILabel!
    @IBOutlet weak var petikKdBIlling: UILabel!
    @IBOutlet weak var petikPengirim: UILabel!
    
    @IBOutlet weak var petikCif: UILabel!
    @IBOutlet weak var petikPenerima: UILabel!
    @IBOutlet weak var petikPemberitahu: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideFormLabel()
        // Do any additional setup after loading the view.
        
       self.hideKeyboardWhenTappedAround()
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
            
         
            
            if(dataBangkir.success == "true"){
                
                DispatchQueue.main.sync() {
                    
                    
                    self.showFormLabel()
                    
                    print("details:")
                    for detail in dataBangkir.details {
                        print("- \(detail.namaPemberitahu)")
                        self.lblCif.text = detail.cif
                        self.lblPenerima.text = detail.namapenerima
                        self.lblPengirim.text = detail.namapengirim
                        self.lblKdBilling.text = detail.kodeBilling
                        self.lblPemberitahu.text = detail.namaPemberitahu
                        
                        // set status
                        var listStatus = ""
                        for status in detail.status{
                            
                            listStatus.append("("+status.wk+") - "+status.ket+" \n")
                        }
                        
                        self.txtVwHasil.text = listStatus
                        
                    }
                }
            } else {
                DispatchQueue.main.sync() {
                    self.txtVwHasil.text = "Data Tidak Ditemukan"
                }
            }
           
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
    
   
     func hideFormLabel(){
        lblCif.isHidden = true
        lblKdBilling.isHidden = true
        lblPemberitahu.isHidden = true
        lblPenerima.isHidden = true
        lblPengirim.isHidden = true
        txtVwHasil.isHidden = true
        
        petikCif.isHidden = true
        petikKdBIlling.isHidden = true
        petikPemberitahu.isHidden = true
        petikPenerima.isHidden = true
        petikPengirim.isHidden = true
        
        lblJudulCif.isHidden = true
        lblJudulPenerima.isHidden = true
        lblJudulKdBilling.isHidden = true
        lblJudulPengirim.isHidden = true
        lblJudulPemberitahu.isHidden = true
        
    }
    
    func showFormLabel(){
        lblCif.isHidden = false
        lblKdBilling.isHidden = false
        lblPemberitahu.isHidden = false
        lblPenerima.isHidden = false
        lblPengirim.isHidden = false
        txtVwHasil.isHidden = false
        
        petikCif.isHidden = false
        petikKdBIlling.isHidden = false
        petikPemberitahu.isHidden = false
        petikPenerima.isHidden = false
        petikPengirim.isHidden = false
        
        lblJudulCif.isHidden = false
        lblJudulPenerima.isHidden = false
        lblJudulKdBilling.isHidden = false
        lblJudulPengirim.isHidden = false
        lblJudulPemberitahu.isHidden = false
        
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


