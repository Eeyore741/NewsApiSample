//
//  ArticleListViewController.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 19/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import UIKit

class ArticleListViewController: UIViewController{
    
    private let baseUrl = "https://newsapi.org"
    private let authorizationToken = "2f8fd248fe3d459e895cc38d57b13f81"
    private let apiVersion = "v2"
    private let articlesPerPage = 14
    private var articles: [Article] = []
    private lazy var generalArticleService: GeneralArticleService = {
            let rrs = RemoteArticleService.init(apiVersion: apiVersion, baseUrl: baseUrl, authorizationToken: authorizationToken)
            let lrs = LocalArticleService.init(apiVersion: apiVersion)
            return GeneralArticleService.init(localRepository: lrs, remoteRepository: rrs, apiVersion: apiVersion, baseUrl: baseUrl, authorizationToken: authorizationToken)
    }()
    private let tableView = PrettyTableView.init(frame: CGRect.zero, style: UITableViewStyle.plain)
    private let articleCellIdentifier = "articleCellIdentifier"
    private let backgroundColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configure(tableView: tableView)
        setupConstraints()
        requestArticles()
    }
    
    func requestArticles(){
        
        let page = Int.init(Float.init(articles.count)/Float.init(articlesPerPage))+1
        generalArticleService.getArticles(inAmountOf: articlesPerPage,
                                          fromPage: page, { (result) in
                                            
                                            switch result{
                                                
                                            case .success(let newArticles):
                                                self.appendArticles(newArticles: newArticles)
                                                
                                            case .failure(let error):
                                                self.simpleAlert(ArticleListViewControllerError.ErrorTitle.localizedDescription, message: error.localizedDescription)
                                            }
                                            self.tableView.stopBottomRefresh()
                                            self.tableView.stopTopRefresh()
        })
    }
    
    func configureUI(){
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = backgroundColor
    }
    
    func configure(tableView: PrettyTableView){
        
        view.addSubview(tableView)
        tableView.backgroundColor = backgroundColor
        tableView.layer.cornerRadius = 6.0;
        tableView.layer.masksToBounds = true
        tableView.register(ArticleCell.self, forCellReuseIdentifier: articleCellIdentifier)
        tableView.topRefreshHandler = {
            self.updateArticles()
        }
        tableView.bottomRefreshHandler = {
            self.requestArticles()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupConstraints(){
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    func updateArticles(){
        
        generalArticleService.updateArticles { (result) in
            
            switch result{
                
            case .success:
                self.articles.removeAll()
                self.tableView.reloadData()
                self.requestArticles()
                
            case .failure(let error):
                
                self.simpleAlert(ArticleListViewControllerError.ErrorTitle.localizedDescription, message: error.localizedDescription)
            }
            self.tableView.stopTopRefresh()
            self.tableView.stopBottomRefresh()
        }
    }
    
    func appendArticles(newArticles: [Article]){
        
        tableView.stopBottomRefresh()
        tableView.stopTopRefresh()
        tableView.beginUpdates()
        articles.append(contentsOf: newArticles)
        var ips: [IndexPath] = []
        for a in newArticles{
            guard articles.contains(a) else {continue}
            guard let index = articles.index(where: { (item) -> Bool in
                item.identifier == a.identifier
            }) else{
                continue
            }
            ips.append(IndexPath.init(row: index, section: 0))
        }
        tableView.insertRows(at: ips, with: UITableViewRowAnimation.automatic)
        tableView.endUpdates()
    }
}

extension ArticleListViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let article = articles[indexPath.row]
        let cell : ArticleCell = tableView.dequeueReusableCell(withIdentifier: articleCellIdentifier, for: indexPath) as! ArticleCell
        cell.headerLabel.text = article.source?.name
        cell.bodyLabel.text = article.description
        cell.urlLabel.attributedText = NSAttributedString.underlinedAttributedString(article.url ?? "",
                                                                                     color: cell.urlLabel.textColor,
                                                                                     font: cell.urlLabel.font)
        return cell
    }
}

extension ArticleListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let articleDetailVc = ArticleDetailViewController()
        articleDetailVc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        articleDetailVc.article = articles[indexPath.row]
        
        present(articleDetailVc, animated: true) {}
    }
}

enum ArticleListViewControllerError: Error{
    
    case ErrorTitle
}

//MARK: - Localization
extension ArticleListViewControllerError: LocalizedError{
    
    public var errorDescription: String? {
        
        switch self {
            
        case .ErrorTitle:
            return NSLocalizedString("ArticleListViewControllerError: general error title", comment: "")
        }
    }
}








