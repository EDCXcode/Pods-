//
//  ViewController.swift
//  Pod-swift练习
//
//  Created by edc on 2017/4/7.
//  Copyright © 2017年 edc. All rights reserved.
//

import UIKit
import AFNetworking


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.yellow
        

      
        
        let parameters = ["key1" : 1, "key2" : 2]
        
        EDCAFNet.shared.request(requestType: .POST , url: "", parameters: parameters) { (str , error) in
           
            
        }
        
     
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        print("点什么")
        
    }
}
