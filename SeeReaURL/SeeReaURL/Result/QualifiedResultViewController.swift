//
//  QualifiedResultViewController.swift
//  SeeReaURL
//
//  Created by Seo Cindy on 11/11/23.
//

import UIKit

class QualifiedResultViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var linkview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        addContentScrollView()
        setPageControl()

        self.linkview.layer.cornerRadius = 10
        self.scrollView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }

    // 결과 제목
    
    // Remember! 경고 문구
    
    // 링크 보여주기
    
    // 버튼1 : 링크 이동
    
    // 버튼2 : 링크 복사
    
    // Tip! 문구
    
    // 사례 화면 구현 : 스크롤 뷰
    var images = [#imageLiteral(resourceName: "img2"), #imageLiteral(resourceName: "img1")]
    var imageViews = [UIImageView]()
    
    private func addContentScrollView() {
            
            for i in 0..<images.count {
                let imageView = UIImageView()
                let xPos = scrollView.frame.width * CGFloat(i)
                imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
                imageView.image = images[i]
                scrollView.addSubview(imageView)
                scrollView.contentSize.width = imageView.frame.width * CGFloat(i + 1)
            }
            
        }
    private func setPageControl() {
            pageControl.numberOfPages = images.count
            
        }
        
        private func setPageControlSelectedPage(currentPage:Int) {
            pageControl.currentPage = currentPage
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let value = scrollView.contentOffset.x/scrollView.frame.size.width
            setPageControlSelectedPage(currentPage: Int(round(value)))
        }

    
}
