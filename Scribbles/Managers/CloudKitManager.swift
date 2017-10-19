//
//  CloudKitManager.swift
//  Scribbles
//
//  Created by Bart Jacobs on 13/10/2017.
//  Copyright © 2017 Cocoacasts. All rights reserved.
//

import RxSwift
import RxCocoa
import CloudKit

class CloudKitManager {

    // MARK: - Properties

    private let container = CKContainer.default()

    // MARK: -

    private let _accountStatus = BehaviorRelay<CKAccountStatus>(value: .couldNotDetermine)

    var accountStatus: Observable<CKAccountStatus> { return _accountStatus.asObservable() }

    // MARK: - Initialization

    init() {
        // Request Account Status
        requestAccountStatus()

        // Setup Notification Handling
        setupNotificationHandling()
    }

    // MARK: - Notification Handling

    @objc private func accountDidChange(_ notification: Notification) {
        // Request Account Status
        DispatchQueue.main.async { self.requestAccountStatus() }
    }

    // MARK: - Helper Methods

    private func requestAccountStatus() {
        // Request Account Status
        container.accountStatus { [unowned self] (accountStatus, error) in
            // Print Errors
            if let error = error { print(error) }

            // Update Account Status
            print(accountStatus.rawValue)
            self._accountStatus.accept(accountStatus)
        }
    }

    // MARK: -

    fileprivate func setupNotificationHandling() {
        // Helpers
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(accountDidChange(_:)), name: Notification.Name.CKAccountChanged, object: nil)
    }

}
