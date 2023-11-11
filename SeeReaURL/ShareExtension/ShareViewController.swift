//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Eric Lee on 11/11/23.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {
	var urlString = ""
	let apiManager = DefaultAPIManager()
	
	override func isContentValid() -> Bool {
		// Do validation of contentText and/or NSExtensionContext attachments here
		return true
	}
	
	override func didSelectPost() {
		if let item = extensionContext?.inputItems.first as? NSExtensionItem {
			if let itemProvider = item.attachments?.first as? NSItemProvider {
				if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
					itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil, completionHandler: { (url, error) -> Void in
						if let shareURL = url as? NSURL {
							self.urlString = shareURL.absoluteString ?? ""
							print(self.urlString)
						}
						
						DispatchQueue.main.async {
							self.showAlert()
						}
					})
				}
			}
		}
		
		self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
	}
	
	override func configurationItems() -> [Any]! {
		// To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
		return []
	}
	
	func presentModalSheet() {
		// Create a UIViewController for the Modal Sheet
		let modalViewController = UIViewController()
		modalViewController.modalPresentationStyle = .automatic
		
		// Create a UILabel to display the urlString
		let label = UILabel()
		label.text = self.urlString
		label.textAlignment = .center
		modalViewController.view.addSubview(label)
		
		// Add any other UI elements or customize the view as needed
		
		// Present the full-screen Modal Sheet
		self.present(modalViewController, animated: true, completion: nil)
	}

	func showAlert() {
		Task {
			do {
				let response = try await apiManager.checkURL(url: self.urlString)
				
				// Move the alert presentation inside the Task block
				let alertController = UIAlertController(title: "위험성 검사 결과", message: response.fraudPossibility ?? "닐이네", preferredStyle: .alert)
				let okAction = UIAlertAction(title: "확인", style: .default) { _ in
					// 확인 버튼을 탭했을 때 수행할 작업
					self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
				}
				alertController.addAction(okAction)
				
				self.present(alertController, animated: true, completion: nil)
				
			} catch {
				print("에러")
			}
		}
	}
	
}
