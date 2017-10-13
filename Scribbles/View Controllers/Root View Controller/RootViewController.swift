//
//  RootViewController.swift
//  Scribbles
//
//  Created by Bart Jacobs on 13/10/2017.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import UIKit
import CloudKit

class RootViewController: UIViewController {

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        CKContainer.default().fetchUserRecordID { (recordID, error) in
            if let error = error {
                print(error)
            } else if let recordID = recordID {
                print(recordID)
            }
        }
    }

}
