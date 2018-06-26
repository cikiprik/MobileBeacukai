//
//  URLConstants.swift
//  MobileBeacukai
//
//  Created by DEWA on 6/23/18.
//  Copyright © 2018 beacukai. All rights reserved.
//

import Foundation

struct APPURL {
    
    private struct Domains {
        static let Prod = "https://esbbcext01.beacukai.go.id:9089/RestBeacukaiApi"
//        static let Dev = "http://test-dev.cloudapp.net"
//        static let UAT = "http://test-UAT.com"
//        static let Local = "192.145.1.1"
//        static let QA = "testAddress.qa.com"
    }
    
    private  struct Routes {
        static let Kurs = "/kurs"
        static let JnsBrg = "/ServiceJenisBarang"
        
    }
    
    private  static let Domain = Domains.Prod
    private  static let BaseURLKurs = Domain + Routes.Kurs
    private  static let BaseURLJnsBrg = Domain + Routes.JnsBrg
    
//    static var FacebookLogin: String {
//        return BaseURL  + "/auth/facebook"
}
