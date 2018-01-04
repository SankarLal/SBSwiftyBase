//
//  StorageViewController.swift
//  SBSwiftyBase
//
//  Created by support on 12/29/17.
//  Copyright © 2017 SANKARLAL. All rights reserved.
//

import UIKit

class StorageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Storages"
    }

    @IBAction func performSaveStorageButton() {
        
        // Store Array Values Into Document Directory
        print("ARRAY STATUS", DDModel.addUpdateCacheWithArray(["Array_1", "Array_2", "Array_3"], inNamedCache: "DD_ARRAY"))
        
        // Store Dictionary Values Into Document Directory
        print("DICT STATUS", DDModel.addUpdateCacheWithDictionary(["Values" : "Dict_1", "Values1" : "Dict_2", "Values2" : "Dict_3"], inNamedCache: "DD_DICT"))
        
        // Store Array Of Dictionary Values Into Document Directory
        print("ARRAY OF DICTIONARY STATUS", DDModel.addUpdateCacheWithArray([["Values" : "Dict_Array_1", "Values1" : "Dict_Array_2", "Values2" : "Dict_Array_3"]], inNamedCache: "DD_ARRAY_OF_DICT"))
        
        // Store Plist File Into Document Directory
        print("SAVE PLIST STATUS", DDModel.savePlistData("HELLO HOW ARE YOU!!!", inNamedCache: "PlistStorage", dataKey: "myItem"))
        
    }
    
    @IBAction func performRetriveStorageButton() {
        
        // Retrive Array Values From Document Directory
        print("GET ARRAY VALUES", DDModel.getArrayFromNamedCache("DD_ARRAY"))
        
        // Retrive Dictionary Values From Document Directory
        print("GET DICT VALUES", DDModel.getDictionaryFromNamedCache("DD_DICT"))

        // Retrive Array Of Dictionary Values From Document Directory
        print("GET ARRAY OF DICT VALUES", DDModel.getArrayFromNamedCache("DD_ARRAY_OF_DICT"))
        
        // Retrive Plist Full Values From Document Directory
        print("GET PLIST VALUES", DDModel.getPlistDataFromNamedCache("PlistStorage", dataKey: nil) ?? "NO VALUE")
        
        // Retrive Plist 'myItem' Key Value From Document Directory
        print("GET PLIST 'myItem' KEY VALUE", DDModel.getPlistDataFromNamedCache("PlistStorage", dataKey: "myItem") ?? "KEY DOESN'T EXISTS")
        
    }
    
    @IBAction func performDeleteStorageButton() {
        
        // Delete Array Values From Document Directory
        print("DELTE THE DD_ARRAY STATUS", DDModel.deleteCacheName("DD_ARRAY"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
