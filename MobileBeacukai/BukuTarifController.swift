//
//  BukuTarifController.swift
//  MobileBeacukai
//
//  Created by DEWA on 8/6/18.
//  Copyright © 2018 beacukai. All rights reserved.
//

import UIKit

class BukuTarifController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource,  UITableViewDelegate {
    var listDetail = [Detail]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TarifTableViewCell", for: indexPath) as! TarifTableViewCell
        
        let datax = listDetail[indexPath.row]
        print(datax.hsCodeFormat)
        cell.hscode?.text = datax.hsCodeFormat
        
//        cell.val?.text = datax.value
        
        
        return cell
    }
    
    func numberOfComponents(in pickerParam: UIPickerView) -> Int {
        return 1
    }
    

    @IBOutlet weak var pickerParam: UIPickerView!
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var btnCari: UIButton!
    var selectedParam = String()
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = ["HS Code", "Uraian Indonesia", "Description"]
        self.pickerParam.delegate = self;
        self.pickerParam.dataSource = self;
        tableView.isHidden = true
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerParam: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerData.count
    }
    
    func pickerView(_ pickerParam: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
   
   
    
    @IBAction func actCari(_ sender: Any) {
        selectedParam = pickerData[pickerParam.selectedRow(inComponent: 0)]
        print(selectedParam)
        loadList()
        tableView.delegate = self
        tableView.dataSource = self
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
    
    struct Btki: Decodable {
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
        let berlaku: String
        let bmMfn: String
        let hsCodeFormat: String
        let idBTBMI: Int
        let noSkep: String
        let tanggalSkep: String
        let uraianEn: String
        let uraianId: String
    }
    
    func loadList(){
        
        let util = Utils()
        let token = util.encrypt()
       
        
        var request = URLRequest(url: URL(string: util.urlBtki())!)
        request.httpMethod = "POST"
        let val = txtValue.text
        let postString = "par=\(selectedParam)&val=\(val ?? "-")&src=\(token)"
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
            let btki = try? JSONDecoder().decode(Btki.self, from: data)
            DispatchQueue.main.async {
                
                if(btki?.success == "true"){
                    self.tableView.isHidden = false
                    let arrayDetail = btki?.details
                    for aData in arrayDetail! {
                        self.listDetail.append(aData)
                    }
                    self.tableView.reloadData()
                } else {
                    self.tableView.isHidden = true
                }
                
            }
            
            
            
            
        }
        
        
        
        task.resume()
        
    }

}
