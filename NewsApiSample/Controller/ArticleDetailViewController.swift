//
//  ArticleDetailViewController.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 21/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    var urlColor: UIColor! = UIColor.init(red: 167/255, green: 173/255, blue: 185/255, alpha: 1)
    var headerColor: UIColor! = UIColor.init(red: 101/255, green: 115/255, blue: 125/255, alpha: 1)
    var bodyColor: UIColor! = UIColor.init(red: 79/255, green: 91/255, blue: 102/255, alpha: 1)
    var backgroundColor: UIColor! = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
    var dismissViewColor: UIColor! = UIColor.lightGray
    var dismissViewHeight: CGFloat! = 6
    var dateFormatter: DateFormatter! = DateFormatter()
    
    var article: Article?
    private var titleLabel: UILabel! = UILabel()
    private var dateLabel: UILabel! = UILabel()
    private var thumbnailImageView: UIImageView! = UIImageView()
    private var descriptionLabel: UILabel! = UILabel()
    private var sourceLabel: UILabel! = UILabel()
    private var urlLabel: UILabel! = UILabel()
    private var dismissView: UIView! = UIView()
    private let contentView: UIView! = UIView()
    private let scrollView: UIScrollView! = UIScrollView()
    private let stackView: UIStackView! = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupConstraints()
        presentArticle(article)
    }
    
    override func preferredScreenEdgesDeferringSystemGestures() -> UIRectEdge {
        
        return UIRectEdge.top
    }
    
    private func configureUI(){
        
        view.backgroundColor = UIColor.clear
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = backgroundColor
        contentView.layer.cornerRadius = 6
        let sgr = UISwipeGestureRecognizer.init(target: self, action: #selector(onTopToBottomSwipe(_:)))
        sgr.direction = UISwipeGestureRecognizerDirection.down
        contentView.isUserInteractionEnabled = true
        contentView.addGestureRecognizer(sgr)
        view.addSubview(contentView)
        
        dateFormatter.dateStyle = DateFormatter.Style.long
        
        dismissView.translatesAutoresizingMaskIntoConstraints = false
        dismissView.backgroundColor = dismissViewColor
        dismissView.layer.cornerRadius = dismissViewHeight/2
        contentView.addSubview(dismissView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = backgroundColor
        scrollView.layer.cornerRadius = 6
        scrollView.clipsToBounds = true
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        contentView.addSubview(scrollView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = backgroundColor
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.alignment = UIStackViewAlignment.top
        stackView.distribution = UIStackViewDistribution.equalSpacing
        stackView.spacing = 10
        scrollView.addSubview(stackView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1, compatibleWith: nil)
        titleLabel.textAlignment = NSTextAlignment.left
        titleLabel.numberOfLines = 0
        titleLabel.textColor = headerColor
        titleLabel.adjustsFontForContentSizeCategory = true
        stackView.addArrangedSubview(titleLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote, compatibleWith: nil)
        dateLabel.textAlignment = NSTextAlignment.left
        dateLabel.numberOfLines = 0
        dateLabel.textColor = bodyColor
        dateLabel.isUserInteractionEnabled = true
        dateLabel.adjustsFontForContentSizeCategory = true
        stackView.addArrangedSubview(dateLabel)

        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.contentMode = UIViewContentMode.scaleAspectFill
        thumbnailImageView.layer.cornerRadius = 6
        thumbnailImageView.clipsToBounds = true
        stackView.addArrangedSubview(thumbnailImageView)

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body, compatibleWith: nil)
        descriptionLabel.textAlignment = NSTextAlignment.left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = bodyColor
        descriptionLabel.adjustsFontForContentSizeCategory = true
        stackView.addArrangedSubview(descriptionLabel)

        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote, compatibleWith: nil)
        sourceLabel.textAlignment = NSTextAlignment.left
        sourceLabel.numberOfLines = 0
        sourceLabel.textColor = bodyColor
        sourceLabel.isUserInteractionEnabled = true
        sourceLabel.adjustsFontForContentSizeCategory = true
        stackView.addArrangedSubview(sourceLabel)

        urlLabel.translatesAutoresizingMaskIntoConstraints = false
        urlLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote, compatibleWith: nil)
        urlLabel.textAlignment = NSTextAlignment.left
        urlLabel.numberOfLines = 0
        urlLabel.textColor = bodyColor
        urlLabel.isUserInteractionEnabled = true
        urlLabel.adjustsFontForContentSizeCategory = true
        stackView.addArrangedSubview(urlLabel)
    }
    
    private func setupConstraints(){
        
        contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true

        dismissView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 10).isActive = true
        dismissView.centerXAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerXAnchor).isActive = true
        dismissView.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.widthAnchor, multiplier: 0.3).isActive = true
        dismissView.heightAnchor.constraint(equalToConstant: dismissViewHeight).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: dismissView.bottomAnchor, constant: 16).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func presentArticle(_ article: Article?){
        
        guard let article = article else {
            
            titleLabel.text = nil
            dateLabel.text = nil
            descriptionLabel.text = nil
            sourceLabel.text = nil
            urlLabel.text = nil
            thumbnailImageView.image = nil
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            return
        }
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        sourceLabel.text = article.source?.name
        
        if article.url != nil{
            
            urlLabel.attributedText = NSAttributedString.underlinedAttributedString(article.url!,
                                                                                    color: urlLabel.textColor,
                                                                                    font: urlLabel.font)
            let tgr = UITapGestureRecognizer.init(target: self, action: #selector(self.onUrlLabelTap(_:)))
            urlLabel.addGestureRecognizer(tgr)
        }
        let date = Article.dateFromString(article.publishedAt)
        dateLabel.text = date != nil ? dateFormatter.string(from: date!) : nil
        
        if article.urlToImage != nil {
            
            thumbnailImageView.loadImageUsingCacheWithURLString(article.urlToImage!,
                                                                placeHolder: nil)
            { (result) in
                
                switch result{
                    
                case .success( _):
                    self.thumbnailImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
                    UIView.animate(withDuration: 0.33, animations: {
                        
                        self.view.layoutIfNeeded()
                    })
                    break
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
    
    //MARK: - UI action
    @objc func onUrlLabelTap(_ sender: UITapGestureRecognizer) {
        
        guard let urlString = urlLabel.text else{
            return
        }
        guard let url = URL.init(string: urlString) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func onTopToBottomSwipe(_ sender: UITapGestureRecognizer) {
        
        self.dismiss(animated: true)
    }
}








