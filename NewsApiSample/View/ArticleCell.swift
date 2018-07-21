//
//  ArticleCell.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 19/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    private let urlColor: UIColor! = UIColor.init(red: 167/255, green: 173/255, blue: 185/255, alpha: 1)
    private let headerColor: UIColor! = UIColor.init(red: 101/255, green: 115/255, blue: 125/255, alpha: 1)
    private let bodyColor: UIColor! = UIColor.init(red: 79/255, green: 91/255, blue: 102/255, alpha: 1)
    
    var headerLabel: UILabel! = UILabel()
    var bodyLabel: UILabel! = UILabel()
    var urlLabel: UILabel! = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setupConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    //MARK: - UI setup
    private func configureUI(){
        
        translatesAutoresizingMaskIntoConstraints = false
        separatorInset = UIEdgeInsetsMake(0, 10000, 0, 0)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1, compatibleWith: nil)
        headerLabel.textAlignment = NSTextAlignment.left
        headerLabel.numberOfLines = 0
        headerLabel.textColor = headerColor
        headerLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(headerLabel)
        
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body, compatibleWith: nil)
        bodyLabel.textAlignment = NSTextAlignment.left
        bodyLabel.numberOfLines = 0
        bodyLabel.textColor = bodyColor
        bodyLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(bodyLabel)
        
        urlLabel.translatesAutoresizingMaskIntoConstraints = false
        urlLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote, compatibleWith: nil)
        urlLabel.textAlignment = NSTextAlignment.left
        urlLabel.numberOfLines = 0
        urlLabel.textColor = bodyColor
        urlLabel.isUserInteractionEnabled = true
        urlLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(urlLabel)
        
        let tgr = UITapGestureRecognizer.init(target: self, action: #selector(self.onUrlLabelTap(_:)))
        urlLabel.addGestureRecognizer(tgr)
    }
    
    private func setupConstraints(){
        
        headerLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        bodyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 6).isActive = true
        bodyLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        bodyLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        
        urlLabel.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 6).isActive = true
        urlLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        urlLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        urlLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
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
}







