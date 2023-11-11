//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Eric Lee on 11/11/23.
//

import UIKit
import Social

import UIKit

class ShareViewController: UIViewController {
	
	let apiManager = DefaultAPIManager()
	var urlString: String = ""
	var resultString: String = ""
	var imageView: UIImageView!
	
	var sharingData:NSExtensionContext?
	
	let resultLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.textColor = .yellow
		label.text = "하이"
		label.font = UIFont.systemFont(ofSize: 18)
		return label
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setURLString()
		self.view.backgroundColor = .black
		self.navigationItem.title = "링크 위험성 확인"
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelButtonTapped(_:)))
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.shareButtonTapped(_:)))
		
		// SF Image questionmark.circle.fill 추가
		imageView = UIImageView(image: UIImage(systemName: "questionmark.circle.fill"))
		imageView.isUserInteractionEnabled = true
		imageView.frame = CGRect(x: 0, y: 0, width: 180, height: 180)

		imageView.center = view.center
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
		imageView.addGestureRecognizer(tapGesture)
		view.addSubview(imageView)
		
		// 이미지뷰를 화면 중앙에 배치
		imageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			imageView.widthAnchor.constraint(equalToConstant: 180), // 원하는 너비로 조절
			imageView.heightAnchor.constraint(equalToConstant: 180) // 원하는 높이로 조절
		])
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.view.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
		UIView.animate(withDuration: 0.3, animations: { () -> Void in
			self.view.transform = .identity
		})
	}
	
	func setupUI() {
		view.addSubview(resultLabel)
		resultLabel.text = self.resultString
		
		NSLayoutConstraint.activate([
			resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
		])
	}
	
	func fetchData() {
		Task {
			do {
				let response = try await apiManager.checkURL(url: self.urlString)
				self.resultString = response.fraudPossibility ?? ""
				
				// 결과가 업데이트되면 메인 스레드에서 UI를 업데이트합니다.
				Task {
					await MainActor.run {
						self.updateUI()
					}
				}
			} catch {
				print("실패")
				print(urlString)
				updateUI()
			}
		}
	}
	
	func updateUI() {
		// 결과를 레이블에 표시
		resultLabel.text = "url String: \(self.urlString)"
	}

	@objc func cancelButtonTapped(_ sender: UIBarButtonItem) {
		self.hideExtensionWithCompletionHandler(completion: { _ in
			self.sharingData?.completeRequest(returningItems: nil, completionHandler: nil)
		})
	}
	
	@objc func shareButtonTapped(_ sender: UIBarButtonItem) {
		fetchData()
		print("share")
	}
	
	func hideExtensionWithCompletionHandler(completion: @escaping (Bool) -> Void) {
		UIView.animate(withDuration: 0.3, animations: {
			self.navigationController!.view.transform = CGAffineTransform(translationX: 0, y: self.navigationController!.view.frame.size.height)
		}, completion: completion)
	}
	
	func setURLString() {
		guard let item = sharingData?.inputItems.first as? NSExtensionItem,
				  let itemProvider = item.attachments?.first as? NSItemProvider
			else {
				print("설마")
				return
			}

			if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
				itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil) { [weak self] (url, error) in
					guard let self = self, let shareURL = url as? URL else {
						// Handle the case where self is nil or the URL is not valid
						return
					}

					// Ensure that urlString is updated on the main thread
					DispatchQueue.main.async {
						self.urlString = shareURL.absoluteString
						print(self.urlString)
					}
				}
			}
	}
	
	@objc func imageTapped() {
		// 이미지 회전 애니메이션 시작
		rotateImage()

		// 3초 후에 이미지 변경
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			// 변수에 따라 이미지 변경
			let isSuccess = true // 또는 false로 설정
			self.imageView.layer.removeAllAnimations()
			if isSuccess {
				self.imageView.image = UIImage(systemName: "checkmark.circle.fill")
			} else {
				self.imageView.image = UIImage(systemName: "xmark.circle.fill")
			}
		}
	}

	func rotateImage() {
		let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
		rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
		rotationAnimation.duration = 3.0
		rotationAnimation.isCumulative = true
		rotationAnimation.repeatCount = .infinity
		imageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
	}

	
}



//
//class ShareViewController: SLComposeServiceViewController {
//	var urlString = ""
//	var responseString = ""
//	let apiManager = DefaultAPIManager()
//	
//	override func isContentValid() -> Bool {
//		// Do validation of contentText and/or NSExtensionContext attachments here
//		return true
//	}
//	override func viewDidLoad() {
//		
//	}
//	
//	
//	override func didSelectPost() {
//		
//		DispatchQueue.main.async {
//			self.showAlert()
//		}
//		self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
//	}
//	
//	override func configurationItems() -> [Any]! {
//		// To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
//		let item2 = SLComposeSheetConfigurationItem()!
//		setURLString()
//		item2.title = "See ReaURL"
//		item2.value = "검사하기"
//		item2.tapHandler = {
//			let viewController = ShareResultViewController(urlString: self.urlString)
//			self.pushConfigurationViewController(viewController)
//		}
//		
//		
//		return [item2]
//	}
//	
//	func presentModalSheet() {
//		// Create a UIViewController for the Modal Sheet
//		let modalViewController = UIViewController()
//		modalViewController.modalPresentationStyle = .automatic
//		
//		// Create a UILabel to display the urlString
//		let label = UILabel()
//		label.text = self.urlString
//		label.textAlignment = .center
//		modalViewController.view.addSubview(label)
//		
//		// Add any other UI elements or customize the view as needed
//		
//		// Present the full-screen Modal Sheet
//		self.present(modalViewController, animated: true, completion: nil)
//	}
//
//	func showAlert() {
//		let alertController = UIAlertController(title: "위험성 검사 결과", message: self.responseString, preferredStyle: .alert)
//		let okAction = UIAlertAction(title: "확인", style: .default) { _ in
//			// 확인 버튼을 탭했을 때 수행할 작업
//			self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
//		}
//		alertController.addAction(okAction)
//		
//		self.present(alertController, animated: true, completion: nil)
//	}
//	
//	func syncNetworkCall(completion: @escaping (String) -> Void) {
//		// 비동기 네트워크 호출을 수행
//		asyncNetworkCall { result in
//			// 네트워크 호출이 완료되면 해당 콜백을 호출
//			completion(result)
//		}
//	}
//
//	func asyncNetworkCall(completion: @escaping (String) -> Void) {
//		Task{
//			do {
//				let respond = try await apiManager.checkURL(url: urlString)
//				let resultString = respond.fraudPossibility ?? ""
//				printContent(resultString)
//				completion(resultString)
//			} catch {
//				print("응안돼")
//			}
//		}
//	}
//	
//	func setURLString() {
//		if let item = extensionContext?.inputItems.first as? NSExtensionItem {
//			if let itemProvider = item.attachments?.first as? NSItemProvider {
//				if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
//					itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil) { [weak self] (url, error) in
//						guard let self = self, let shareURL = url as? URL else { return }
//						
//						self.urlString = shareURL.absoluteString
//						print(self.urlString)
//					}
//				}
//			}
//		}
//	}
//	
//}

