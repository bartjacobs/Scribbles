//
//  RootViewController.swift
//  Scribbles
//
//  Created by Bart Jacobs on 13/10/2017.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RootViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet var accountStatusLabel: UILabel!

    // MARK: -

    private let cloudKitManager = CloudKitManager()

    // MARK: -

    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Subscribe to Account Status
        cloudKitManager
            .accountStatus
            .asDriver(onErrorJustReturn: .couldNotDetermine)
            .map { (accountStatus) -> String in
                switch accountStatus {
                case .couldNotDetermine: return "Unable to Determine iCloud Account Status"
                case .available: return "User Signed in to iCloud"
                case .restricted: return "Not Permitted to Access iCloud Account"
                case .noAccount: return "User Not Signed in to iCloud"
                }
            }
            .drive(accountStatusLabel.rx.text)
            .disposed(by: disposeBag)
    }

}
