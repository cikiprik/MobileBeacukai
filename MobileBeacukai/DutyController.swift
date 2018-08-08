//
//  DutyController.swift
//  MobileBeacukai
//
//  Created by DEWA on 6/22/18.
//  Copyright © 2018 beacukai. All rights reserved.
//

import UIKit

class DutyController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet weak var lblJnsValuta: UILabel!
    @IBOutlet weak var lblJnsBrg: UILabel!
    @IBOutlet weak var lblJnsImpor: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var pickerJnsImpor: UIPickerView!
    @IBOutlet weak var pickerJnsBrg: UIPickerView!
    @IBOutlet weak var pickerJnsValas: UIPickerView!
    @IBOutlet weak var btnCount: UIButton!
    @IBOutlet weak var lblFobEqual: UILabel!
    @IBOutlet weak var lblFob: UILabel!
    @IBOutlet weak var txtFob: UITextField!
    
    @IBOutlet weak var lblInsurance: UILabel!
    @IBOutlet weak var lblInsuranceEqual: UILabel!
    @IBOutlet weak var txtInsurance: UITextField!
    
    @IBOutlet weak var lblFreight: UILabel!
    @IBOutlet weak var lblFreightEqual: UILabel!
    @IBOutlet weak var txtFreight: UITextField!
    
    @IBOutlet weak var lblNpwp: UILabel!
    @IBOutlet weak var lblNpwpEqual: UILabel!
    @IBOutlet weak var switchNpwp: UISwitch!
    
    @IBOutlet weak var lblBM: UILabel!
    @IBOutlet weak var lblBMEqual: UILabel!
    @IBOutlet weak var txtBM: UITextField!
    
    @IBOutlet weak var lblPPN: UILabel!
    @IBOutlet weak var lblPPNEqual: UILabel!
    @IBOutlet weak var txtPPN: UITextField!
    
    @IBOutlet weak var lblPPH: UILabel!
    @IBOutlet weak var txtPPH: UITextField!
    @IBOutlet weak var lblPPHEqual: UILabel!
    
    @IBOutlet weak var lblPPnBM: UILabel!
    @IBOutlet weak var lblPPnBMEqual: UILabel!
    @IBOutlet weak var txtPPnBM: UITextField!
    
    
    
    var pickerDataJnsImpor = ["Barang Kiriman Melalui PJT/POS", "Barang Penumpang", "Barang Penumpang Keluarga", "Barang Impor Umum"];
    var imporUmum = false;
    var selectedJnsImpor = Int()
    var selectedJnsBrg = String()
    var selectedJnsValuta = String()
    var pickerDataJnsBrg = [String]()
    
    @IBAction func indexChanged(_ sender: Any) {
        // ketika ganti form
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            hideFormKedua()
            showFormPertama()
            hideFormImporUmum()
        case 1:
            hideFormPertama()
            showFormKedua()
            if(imporUmum){
                showFormImporUmum()
            } else {
                hideFormImporUmum()
            }
        default:
            break
        }
    }
    
    
    
    var pickerDataJnsValas = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // load data
        initData()
        
        self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showFormPertama(){
        btnCount.isHidden = true
        pickerJnsImpor.isHidden = false
        pickerJnsBrg.isHidden = false
        pickerJnsValas.isHidden = false
        lblJnsImpor.isHidden = false
        lblJnsBrg.isHidden = false
        lblJnsValuta.isHidden = false
        
    }
    
    func hideFormPertama(){
       
        pickerJnsImpor.isHidden = true
        pickerJnsBrg.isHidden = true
        pickerJnsValas.isHidden = true
        lblJnsImpor.isHidden = true
        lblJnsBrg.isHidden = true
        lblJnsValuta.isHidden = true
    }
    
    func showFormKedua(){
         btnCount.isHidden = false
         lblFob.isHidden = false
         lblFobEqual.isHidden = false
         txtFob.isHidden = false
        
        lblInsurance.isHidden = false
        lblInsuranceEqual.isHidden = false
        txtInsurance.isHidden = false
        
        lblFreight.isHidden = false
        lblFreightEqual.isHidden = false
        txtFreight.isHidden = false
        
        lblNpwp.isHidden = false
        lblNpwpEqual.isHidden = false
        switchNpwp.isHidden = false
    }
    
    func hideFormKedua(){
        lblFob.isHidden = true
        lblFobEqual.isHidden = true
        txtFob.isHidden = true
        
        lblInsurance.isHidden = true
        lblInsuranceEqual.isHidden = true
        txtInsurance.isHidden = true
        
        lblFreight.isHidden = true
        lblFreightEqual.isHidden = true
        txtFreight.isHidden = true
        
        lblNpwp.isHidden = true
        lblNpwpEqual.isHidden = true
        switchNpwp.isHidden = true
    }
    
    func showFormImporUmum(){
        lblBM.isHidden = false
        lblBMEqual.isHidden = false
        txtBM.isHidden = false
        
        lblPPN.isHidden = false
        lblPPNEqual.isHidden = false
        txtPPN.isHidden = false
        
        lblPPH.isHidden = false
        lblPPHEqual.isHidden = false
        txtPPH.isHidden = false
        
        lblPPnBM.isHidden = false
        lblPPnBMEqual.isHidden = false
        txtPPnBM.isHidden = false
    }
    
    func hideFormImporUmum(){
        
        lblBM.isHidden = true
        lblBMEqual.isHidden = true
        txtBM.isHidden = true
        txtBM.text = nil
        
        lblPPN.isHidden = true
        lblPPNEqual.isHidden = true
        txtPPN.isHidden = true
        txtPPN.text = nil
        
        lblPPH.isHidden = true
        lblPPHEqual.isHidden = true
        txtPPH.isHidden = true
        txtPPH.text = nil
        
        lblPPnBM.isHidden = true
        lblPPnBMEqual.isHidden = true
        txtPPnBM.isHidden = true
        txtPPnBM.text = nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func initData(){
        
        loadDataBrg()
        loadValuta()
        
        self.pickerJnsImpor.dataSource = self;
        self.pickerJnsImpor.delegate = self;
        self.pickerJnsBrg.dataSource = self;
        self.pickerJnsBrg.delegate = self;
        self.pickerJnsValas.dataSource = self;
        self.pickerJnsValas.delegate = self;
        
        hideFormKedua()
        showFormPertama()
        hideFormImporUmum()
        
    }
    
    func loadDataBrg(){
        // tarik dari service
        let util = Utils()
        let token = util.encrypt()
        var request = URLRequest(url: URL(string: util.urlJnsBrg())!)
        request.httpMethod = "POST"
        print(token)
        let postString = "src=\(token)"
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                
            }
            
            // Decode data to object
            let dataBrg = try? JSONDecoder().decode(DataBrg.self, from: data)
            DispatchQueue.main.async {
                let arrayDetail = dataBrg?.details
                for aData in arrayDetail! {
                    self.pickerDataJnsBrg.append(aData)
                }
                self.pickerJnsBrg.reloadAllComponents()
            }
            
            
            
            
        }
        
        
        
        task.resume()
    }
    
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let calcDutyController = segue.destination as? DutyCalcController {
                // send data param
                calcDutyController.selectedJnsImpor = selectedJnsImpor
                calcDutyController.selectedJnsBrg = pickerDataJnsBrg[pickerJnsBrg.selectedRow(inComponent: 0)]
                calcDutyController.selectedJnsValuta = pickerDataJnsValas[pickerJnsValas.selectedRow(inComponent: 0)]
                if(txtFob.text == nil || (txtFob.text?.isEmpty)!){
                    calcDutyController.fob = 0
                } else {
                    calcDutyController.fob = Double(txtFob.text!)!
                }
                if(txtInsurance.text == nil || (txtInsurance.text?.isEmpty)!){
                    calcDutyController.insurance = 0
                } else {
                    calcDutyController.insurance = Double(txtInsurance.text!)!
                }
                
                if(txtFreight.text == nil || (txtFreight.text?.isEmpty)!){
                    calcDutyController.freight = 0
                } else {
                    calcDutyController.freight = Double(txtFreight.text!)!
                }
                // impor umum
                if(imporUmum){
                    if(txtBM.text == nil || (txtBM.text?.isEmpty)!){
                        calcDutyController.bm = 0
                    } else {
                        calcDutyController.bm = Double(txtBM.text!)!
                    }
                    
                    if(txtPPN.text == nil || (txtPPN.text?.isEmpty)!){
                        calcDutyController.ppn = 0
                    } else {
                        calcDutyController.ppn = Double(txtPPN.text!)!
                    }
                    
                    if(txtPPH.text == nil || (txtPPH.text?.isEmpty)!){
                        calcDutyController.pph = 0
                    } else {
                        calcDutyController.pph = Double(txtPPH.text!)!
                    }
                    
                    if(txtPPnBM.text == nil || (txtPPnBM.text?.isEmpty)!){
                        calcDutyController.ppnbm = 0
                    } else {
                        calcDutyController.ppnbm = Double(txtPPnBM.text!)!
                    }
                }
                
                calcDutyController.npwp = switchNpwp.isOn
                
            }
            
        }
    
    
    func loadValuta(){
        // tarik dari service
        let util = Utils()
        let token = util.encrypt()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyy"
        let tglDipilih = dateFormatterGet.string(from: Date())
        
        var request = URLRequest(url: URL(string: util.urlKurs())!)
        request.httpMethod = "POST"
        print(token)
        let postString = "tglKurs=\(tglDipilih)&src=\(token)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                
            }
            
            //let responseString = String(data: data, encoding: .utf8)
            //print(responseString ?? "-")
            
            // Decode data to object
            let kurs = try? JSONDecoder().decode(Kurs.self, from: data)
            DispatchQueue.main.async {
                
                let arrayDetail = kurs?.details
                for aData in arrayDetail! {
                    
                    self.pickerDataJnsValas.append(aData.valuta)
                }
                self.pickerJnsValas.reloadAllComponents()
            }
            
        }
        
        
        
        task.resume()
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return pickerDataJnsImpor.count
        }else if (pickerView.tag == 2){
            return pickerDataJnsBrg.count
        } else if (pickerView.tag == 3){
            return pickerDataJnsValas.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        
        if (pickerView.tag == 1){
            label.text = pickerDataJnsImpor[row]
           return label
        }else if (pickerView.tag == 2){
            label.text = pickerDataJnsBrg[row]
            return label
        } else if (pickerView.tag == 3){
            label.text = pickerDataJnsValas[row]
            return label
        } else {
            return label
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 1){
            // print(row)
            // print(pickerDataJnsImpor[row])
            selectedJnsImpor = row
            if (row == 3){
                // impor umum
                imporUmum = true
               
            } else {
                imporUmum = false
               
            }
        } 
        
        
    }
    
    @IBAction func calcDuty(_ sender: Any) {
        //
    }
    
    
    struct DataBrg: Decodable {
        let success: String
        let message: String
        let details: [String]
        
        enum CodingKeys : String, CodingKey {
            case success
            case message
            case details = "detail"
        }
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

 
    
}
