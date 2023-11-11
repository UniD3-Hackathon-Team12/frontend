//
//  ShareResultViewController.swift
//  ShareExtension
//
//  Created by Eric Lee on 11/12/23.
//

import UIKit

class ShareResultViewController: UIViewController {
	let apiManager = DefaultAPIManager()
	var urlString: String = ""
	var resultString: String = ""
	
	let resultLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 18)
		return label
	}()
	
	let button: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Tap me", for: .normal)
		button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
		return button
	}()
	
	init(urlString: String, resultString: String = "") {
		// Initialize properties before calling super.init()
		self.urlString = urlString
		self.resultString = resultString
		
		// Call the designated initializer of the superclass
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		
		setupUI()
//		fetchData()
		
	}
	
	
	func setupUI() {
		view.addSubview(resultLabel)
		view.addSubview(button)
		
		NSLayoutConstraint.activate([
			resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
			button.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
			button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
			}
		}
	}
	
	func updateUI() {
		// 결과를 레이블에 표시
		resultLabel.text = "url String: \(self.urlString)"
	}
	
	@objc func buttonTapped() {
		// Handle button tap
		fetchData()
	}
	
}
