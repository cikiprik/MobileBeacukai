//
//  Utils.swift
//  MobileBeacukai
//
//  Created by DEWA on 5/19/18.
//  Copyright © 2018 beacukai. All rights reserved.
//

import Foundation
import CryptoSwift

class Utils {
    func encrypt() -> String {
        do {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyyMMddHHmmss"
            let date = Date()
            let today = dateFormatterGet.string(from: date)
            //print(today)
            let input: Array<UInt8> = Array(today.utf8)
            
            let keynya = ""
            let keynyautf8 = keynya.data(using: .utf8)
            
            let hash =  keynyautf8?.sha256()
            let key: Array<UInt8> = Array(hash!.bytes[0..<16])
            let iv: Array<UInt8> = [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
            
            
            let encrypted = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs5).encrypt(input)
            //        let decrypted = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs5).decrypt(encrypted)
            
            let hexaString = encrypted.map{String(format: "%02x", $0)}.joined()
            //        print(hexaString)
            //        let hasil = String(bytes: decrypted, encoding: .utf8)
            return hexaString
        } catch {
            print(error)
            return "-"
        }
        
    }
    
    
    func urlKurs() -> String {
        return "https://esbbcext01.beacukai.go.id:9089/RestBeacukaiApi/kurs"
    }

    func urlJnsBrg() -> String {
        return "https://esbbcext01.beacukai.go.id:9089/RestBeacukaiApi/ServiceJenisBarang"
    }
    
    func urlDutyCalc() -> String {
        return "https://esbbcext01.beacukai.go.id:9089/RestBeacukaiApi/KalkulatorAndroid"
    }
    
    
}
