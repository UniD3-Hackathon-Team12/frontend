//
//  EntryViewController.swift
//  ShareExtension
//
//  Created by Eric Lee on 11/12/23.
//

import UIKit

@objc(EntryViewController)

class EntryViewController : UIViewController {
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		let shareVC = ShareViewController()
		shareVC.sharingData = self.extensionContext
		let nav = UINavigationController(rootViewController: shareVC)
		self.present(nav, animated: false)
	}
}
