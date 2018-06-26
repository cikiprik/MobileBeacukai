//
//  DetailCurrController.swift
//  MobileBeacukai
//
//  Created by DEWA on 5/19/18.
//  Copyright © 2018 beacukai. All rights reserved.
//

import UIKit

class DetailCurrController: UIViewController, UITableViewDataSource,  UITableViewDelegate {
    
   
    
    @IBOutlet weak var tableView: UITableView!
    var listDetail = [Detail]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
         return listDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KursTableViewCell", for: indexPath) as! KursTableViewCell
        
        let datax = listDetail[indexPath.row]
        cell.cur?.text = datax.valuta
        
        cell.val?.text = datax.value
        if let data = try? Data(contentsOf: datax.flag)
        {
            let image: UIImage = UIImage(data: data)!
            cell.img?.image = image
        }
        
        return cell
    }
    
    
    var tglTerpilih: Date? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add this
       
        loadList()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    @IBOutlet weak var noSkep: UILabel!
    @IBOutlet weak var awalBerlaku: UILabel!
    @IBOutlet weak var akhirBerlaku: UILabel!
    @IBOutlet weak var tglSkep: UILabel!
    
    
    func loadList(){
        
        let util = Utils()
        let token = util.encrypt()
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyy"
        let tglDipilih = dateFormatterGet.string(from: tglTerpilih!)
        
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
                    self.noSkep.text = kurs?.noSkep
                    self.tglSkep.text = kurs?.tglSkep
                    self.awalBerlaku.text = (kurs?.tglAwal)! + " s/d "
                    self.akhirBerlaku.text = kurs?.tglAkhir
                    let arrayDetail = kurs?.details
                    for aData in arrayDetail! {
                        
                        self.listDetail.append(aData)
                    }
                    
                    self.tableView.reloadData()
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
