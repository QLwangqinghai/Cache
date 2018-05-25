//
//  ViewController.swift
//  MyTableView
//
//  Created by wangqinghai on 2018/5/25.
//  Copyright © 2018年 wangqinghai. All rights reserved.
//

import UIKit


class MyViewController2: UIViewController {
    var textView1: UITextView!
    var bottomView: UIView!
    
    var contentView: UIView {
        return self.view!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView.init())
        
        self.edgesForExtendedLayout = .all
        
        self.contentView.backgroundColor = UIColor.red
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        let tableview = MessageTableView(frame: frame)
        tableview.contentSize = CGSize(width: 0, height: 5000)
        tableview.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        tableview.backgroundColor = UIColor.green
        tableview.wrapperView.backgroundColor = UIColor.gray
        self.contentView.addSubview(tableview)
        tableview.tableViewDelegate = self
        tableview.dataSource = self
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            tableview.reloadData()
        }
        
        let bottomView: UIView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 100, width: UIScreen.main.bounds.width, height: 100));
        bottomView.backgroundColor = UIColor.yellow
        self.contentView.addSubview(bottomView);
        
        let textView1: UITextView = UITextView(frame: CGRect(x: 10, y: 5, width: 130, height: 30))
        textView1.backgroundColor = UIColor.red
        bottomView.addSubview(textView1)
        self.textView1 = textView1
        
        let button: UIButton = UIButton(frame: CGRect.init(x: 150, y: 5, width: 80, height: 30));
        button.backgroundColor = UIColor.green
        bottomView.addSubview(button)
        button.addTarget(self, action: #selector(buttonClicked1(button:)), for: UIControlEvents.touchUpInside);
        
        let button1: UIButton = UIButton(frame: CGRect.init(x: 250, y: 5, width: 80, height: 30));
        button1.backgroundColor = UIColor.gray
        bottomView.addSubview(button1)
        button1.addTarget(self, action: #selector(buttonClicked(button:)), for: UIControlEvents.touchUpInside);
        
        self.bottomView = bottomView
    }
    
    @objc func buttonClicked1(button: UIButton) {
        
        
        
        
    }
    @objc func buttonClicked(button: UIButton) {
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        self.navigationController?.setNavigationBarHidden(true, animated: true)
        //        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let a : UINavigationBar? = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    var sectionList: [(Int, Int)] = {
        var list: [(Int, Int)] = []
        for j in 0 ..< 30 {
            list.append((Int(arc4random() % 20 + 30), Int(arc4random() % 20 + 30)))
        }
        return list
    }()
    var dataList: [[Int]] = {
        var list: [[Int]] = []

        for j in 0 ..< 30 {
            var l3: [Int] = []
            for i in 0 ..< 30 {
                l3.append(Int(arc4random() % 20 + 30))
            }
            list.append(l3)
        }

        return list
    }()
    
}

extension MyViewController2: MessageTableViewDataSource {
    func tableView(_ tableView: MessageTableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList[section].count
    }
    func tableView(_ tableView: MessageTableView, cellForRowAt indexPath: IndexPath) -> MessageTableViewCell {
        return MessageTableViewCell.init(frame: CGRect(), reuseIdentifier: "")
    }
    func numberOfSections(in tableView: MessageTableView) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: MessageTableView, hasHeaderInSection section: Int) -> Bool {
        return false
    }
    func tableView(_ tableView: MessageTableView, hasFooterInSection section: Int) -> Bool {
        return false
    }
    
    func tableView(_ tableView: MessageTableView, viewForHeaderInSection section: Int) -> MessageTableViewHeaderFooterView {
        return MessageTableViewHeaderFooterView(frame: CGRect(), reuseIdentifier: "")
    }
    func tableView(_ tableView: MessageTableView, viewForFooterInSection section: Int) -> MessageTableViewHeaderFooterView {
        return MessageTableViewHeaderFooterView(frame: CGRect(), reuseIdentifier: "")
        
    }
}

extension MyViewController2: MessageTableViewDelegate {
    
    //    @objc optional func tableView(_ tableView: MessageTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    //    @objc optional func tableView(_ tableView: MessageTableView, willDisplayHeaderView view: UIView, forSection section: Int)
    //    @objc optional func tableView(_ tableView: MessageTableView, willDisplayFooterView view: UIView, forSection section: Int)
    //    @objc optional func tableView(_ tableView: MessageTableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    //    @objc optional func tableView(_ tableView: MessageTableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    //    @objc optional func tableView(_ tableView: MessageTableView, didEndDisplayingFooterView view: UIView, forSection section: Int)
    
    
    func tableView(_ tableView: MessageTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.dataList[indexPath.section][indexPath.row])
    }
    
    
    func tableView(_ tableView: MessageTableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: MessageTableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    //    @objc optional func tableView(_ tableView: MessageTableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    //    @objc optional func tableView(_ tableView: MessageTableView, didHighlightRowAt indexPath: IndexPath)
    //    @objc optional func tableView(_ tableView: MessageTableView, didUnhighlightRowAt indexPath: IndexPath)
    //    @objc optional func tableView(_ tableView: MessageTableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    //    @objc optional func tableView(_ tableView: MessageTableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    //    @objc optional func tableView(_ tableView: MessageTableView, didSelectRowAt indexPath: IndexPath)
    //    @objc optional func tableView(_ tableView: MessageTableView, didDeselectRowAt indexPath: IndexPath)
}



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        DispatchQueue.main.async {
            self.present(SystemMessageTableViewController(), animated: true, completion: {
                
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

