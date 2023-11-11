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
	var responseString = ""
	let apiManager = DefaultAPIManager()
	
	override func isContentValid() -> Bool {
		// Do validation of contentText and/or NSExtensionContext attachments here
		return true
	}
	override func viewDidLoad() {
		
	}
	
	
	override func didSelectPost() {
		
		DispatchQueue.main.async {
			self.showAlert()
		}
		self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
	}
	
	override func configurationItems() -> [Any]! {
		// To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
		let item2 = SLComposeSheetConfigurationItem()!
		setURLString()
		item2.title = "See ReaURL"
		item2.value = "검사하기"
		item2.tapHandler = {
			let viewController = ShareResultViewController(urlString: self.urlString)
			self.pushConfigurationViewController(viewController)
		}
		
		
		return [item2]
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
		let alertController = UIAlertController(title: "위험성 검사 결과", message: self.responseString, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "확인", style: .default) { _ in
			// 확인 버튼을 탭했을 때 수행할 작업
			self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
		}
		alertController.addAction(okAction)
		
		self.present(alertController, animated: true, completion: nil)
	}
	
	func syncNetworkCall(completion: @escaping (String) -> Void) {
		// 비동기 네트워크 호출을 수행
		asyncNetworkCall { result in
			// 네트워크 호출이 완료되면 해당 콜백을 호출
			completion(result)
		}
	}

	func asyncNetworkCall(completion: @escaping (String) -> Void) {
		Task{
			do {
				let respond = try await apiManager.checkURL(url: urlString)
				let resultString = respond.fraudPossibility ?? ""
				printContent(resultString)
				completion(resultString)
			} catch {
				print("응안돼")
			}
		}
	}
	
	func setURLString() {
		if let item = extensionContext?.inputItems.first as? NSExtensionItem {
			if let itemProvider = item.attachments?.first as? NSItemProvider {
				if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
					itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil) { [weak self] (url, error) in
						guard let self = self, let shareURL = url as? URL else { return }
						
						self.urlString = shareURL.absoluteString
						print(self.urlString)
					}
				}
			}
		}
	}
	
}

