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
    var fob = Double()
    var insurance = Double()
    var freight = Double()
    var npwp = Bool()
    // impor umum
    var bm = Double()
    var ppn = Double()
    var pph = Double()
    var ppnbm = Double()
    
    
    @IBOutlet weak var lblBm: UILabel!
    @IBOutlet weak var lblPpn: UILabel!
    @IBOutlet weak var lblPph: UILabel!
    @IBOutlet weak var lblPpnBm: UILabel!
    @IBOutlet weak var lblTotBayar: UILabel!
    @IBOutlet weak var txtLartas: UITextView!
    
    @IBOutlet weak var txtKeterangan: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedJnsImpor)
        print(selectedJnsBrg)
        print(selectedJnsValuta)
        print(fob)
       
        loadHasilCalc()
        
        // Do any additional setup after loading the view.
    }
    
    func loadHasilCalc(){
        // tarik dari service
        let util = Utils()
        let token = util.encrypt()
        var request = URLRequest(url: URL(string: util.urlDutyCalc())!)
        request.httpMethod = "POST"
        print(token)
        var npwpnya = String()
        if(npwp){
            npwpnya = "1"
        } else {
            npwpnya = "0"
        }
        
        let postString = "src=\(token)&jnsAju=\(selectedJnsImpor+1)&jnsBrg=\(selectedJnsBrg)&fob=\(fob)&insurance=\(insurance)&freight=\(freight)&valuta=\(selectedJnsValuta)&paramBM=\(bm)&paramPPN=\(ppn)&paramPPH=\(pph)&paramPPNBM=\(ppnbm)&paramNPWP=\(npwpnya)"
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
//            print(responseString ?? "-")
            
            // Decode data to object
            let dataBrg = try? JSONDecoder().decode(HasilCalc.self, from: data)
            DispatchQueue.main.async {
                let arrayDetail = dataBrg?.details
                for aData in arrayDetail! {
                   
                    self.lblBm.text = aData.bm
                    self.lblPpn.text = aData.ppn
                    self.lblPph.text = aData.pph
                    self.lblPpnBm.text = aData.ppnbm
                    self.txtLartas.text = aData.urLartas
                    self.lblTotBayar.text = aData.totalBayar
                    self.txtKeterangan.text = aData.urKeterangan
                    
                }
            }
            
            
            struct HasilCalc: Decodable {
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
                let bm: String
                let ppn: String
                let pph: String
                let ppnbm: String
                let totalBayar: String
                let tarifBM: String
                let tarifPPN: String
                let tarifPPH: String
                let tarifPPNBM: String
                let urLartas: String
                let urKeterangan: String
            }
            
            
            
        }
        
        
        
        task.resume()
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
