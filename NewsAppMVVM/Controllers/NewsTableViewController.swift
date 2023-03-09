//
//  NewsTableViewController.swift
//  NewsAppMVVM
//
//  Created by Òscar Muntal on 9/3/23.
//

import UIKit
import RxSwift

class NewsTableViewController: UITableViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        populateNews()
    }
}

private extension NewsTableViewController {
    func populateNews() {
        let apiKey = "PRIVATE-API-KEY"
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)") else { fatalError("URL doesn't work") }
        let resource = Resource<ArticleResponse>(url: url)
        
        URLRequest.requestDecodable(resource: resource)
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
    }
}
