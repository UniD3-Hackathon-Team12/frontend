//
//  HomeViewController.swift
//  SeeReaURL
//
//  Created by Seo Cindy on 11/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    let apiManager = DefaultAPIManager()
    var segmentState = 1 // 1: url, 2: account

    var isValidAccount: Bool = false {
        didSet(oldValue) {
            print(oldValue)
            let alert = UIAlertController(title: "사칭계정 확인 결과", message: "\(isValidAccount ? "\n정상적인 계정입니다." : "\n유효하지 않은 계정입니다.")", preferredStyle: .alert)
            let close = UIAlertAction(title: "Close", style: .destructive, handler: nil)
            alert.addAction(close)
            present(alert, animated: true, completion: nil)
        }
    }
    
    var vc = RecentlyReportedTableViewCell()
    var apiData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldStyle()

        let nib = UINib(nibName: RecentlyReportedTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: RecentlyReportedTableViewCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self

        // 네비게이션 바 해제
        self.navigationController?.navigationBar.isHidden = true;
        
        // API
        vc.delegate = self
        vc.fetchHotURLs()
        print("completed")
    }



    @IBAction func segValueChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            typeLabel.text = "확인하고 싶은 링크를 입력하세요"
            textField.placeholder = "https://fake.com"
            segmentState = 1
        case 1:
            typeLabel.text = "확인하고 싶은 계정 이름을 입력하세요"
            textField.placeholder = "blackpinkofficial"
            segmentState = 2
        default:
            break
        }
    }


    func setTextFieldStyle() {
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor(named: "pointColor")?.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.0
    }


    @IBAction func searchButtonClicked(_ sender: UIButton) {
        if textField.text != nil {
            print("\(textField.text!)")

            if segmentState == 1 {
                // url 유효성 검사

                // 페이지 전환
                // 유효한 링크인 경우
                guard let qualifiedResultVC = self.storyboard?.instantiateViewController(withIdentifier: "QualifiedResultVC") as? QualifiedResultViewController else { return }
                self.navigationController?.pushViewController(qualifiedResultVC, animated: true)

                // 유효하지 않은 링크인 경우
                //            guard let socialLoginVC = self.storyboard?.instantiateViewController(withIdentifier: “SocialLoginVC”) as? SocialLoginViewController else {return}
                //            self.navigationController?.pushViewController(socialLoginVC, animated: true)


            } else {
                checkAccount(account: textField.text!)
            }

            textField.text = ""
        }
    }

    func checkAccount(account: String) {
        Task {
            do {
                let response = try await apiManager.getAccountValidation(accountName: account)
                isValidAccount = response
            }
            catch {

            }
        }
    }

}


extension HomeViewController: UITableViewDelegate, SendStringData {
    func sendData(mydata: [String]) {
        apiData = mydata
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentlyReportedTableViewCell.identifier, for: indexPath) as? RecentlyReportedTableViewCell else { return UITableViewCell() }

        cell.setData(apiData[indexPath.row])
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiData.count
    }
}
