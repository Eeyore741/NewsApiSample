//
//  PrettyTableView.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 19/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import UIKit

class PrettyTableView: UITableView {
    
    private let cellColor1 = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
    private let cellColor2 = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
    
    private let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    var topRefreshHandler: ()->Void = ({})
    var bottomRefreshHandler: ()->Void = ({})
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        configureUI()
    }
    
    private func configureUI(){
        
        estimatedRowHeight = UITableViewAutomaticDimension
        rowHeight = UITableViewAutomaticDimension
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        separatorStyle = UITableViewCellSeparatorStyle.none
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(onTopRefreshTriggered), for: UIControlEvents.valueChanged)
        
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        spinner.color = UIColor.black
        spinner.stopAnimating()
        
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 60))
        footerView.backgroundColor = UIColor.clear
        footerView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        tableFooterView = footerView
    }
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        
        isUserInteractionEnabled = true
        let cell = super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.contentView.backgroundColor = (indexPath.row % 2) == 0 ? cellColor1 : cellColor2
        
        if indexPath.row+1 == dataSource?.tableView(self, numberOfRowsInSection: 0) {
            
            if !spinner.isAnimating{
                
                spinner.startAnimating()
                self.onBottomRefreshTriggered()
            }
        }
        return cell;
    }
    
    //MARK: UI action
    @objc private func onTopRefreshTriggered(){
        print(#function)
        
        let deadlineTime = DispatchTime.now() + .milliseconds(1400)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            self.topRefreshHandler()
        }
    }
    
    private func onBottomRefreshTriggered(){
        print(#function)
        
        let deadlineTime = DispatchTime.now() + .milliseconds(1400)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            self.bottomRefreshHandler()
        }
    }
    
    func stopTopRefresh(){
        print(#function)
        
        refreshControl?.endRefreshing()
    }
    
    func stopBottomRefresh(){
        print(#function)
        
        spinner.stopAnimating();
    }
}








