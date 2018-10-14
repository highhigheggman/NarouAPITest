//
//  ViewController.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2018/09/29.
//  Copyright © 2018 yoshiki-t. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let narouAPI = NarouAPI()
        
        narouAPI.getNovelInfo(sortOption: .hyoka, completion: { apiResponse, error in
            
            guard let data = apiResponse else {
                print("Error: \(error!)")
                return
            }
            
            print(data.novelInfoList)
        })
        
    }


}

