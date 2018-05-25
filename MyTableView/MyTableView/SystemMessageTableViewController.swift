//
//  SystemMessageTableViewController.swift
//  MyTableView
//
//  Created by wangqinghai on 2018/5/25.
//  Copyright © 2018年 wangqinghai. All rights reserved.
//

import UIKit

func doubleRandom(_ max: Double) -> Double {
    let r = arc4random()
    let mask: UInt32 = UInt32(max * 100000)
    return Double(r % mask) / 100000
}

func cgfloatRandom(_ max: Double) -> CGFloat {
    return CGFloat(doubleRandom(max))
}


func colorRandom() -> UIColor {
    return UIColor(red: cgfloatRandom(1.0), green: cgfloatRandom(1.0), blue: cgfloatRandom(1.0), alpha: cgfloatRandom(1.0))
}


class SystemMessageTableViewController: UIViewController {
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
        let tableview = UITableView(frame: frame)
        tableview.contentSize = CGSize(width: 0, height: 5000)
        tableview.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        tableview.backgroundColor = UIColor.green
//        tableview.wrapperView.backgroundColor = UIColor.gray
        self.contentView.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        
        tableview.register(UITableViewHeaderFooterView.classForCoder(), forHeaderFooterViewReuseIdentifier: "UITableViewHeaderFooterView")
        
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

extension SystemMessageTableViewController: UITableViewDataSource {
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList[section].count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataList.count
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view: UITableViewHeaderFooterView! = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UITableViewHeaderFooterView")
        view.tag = 2
        view.contentView.backgroundColor = colorRandom()
        return view
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view: UITableViewHeaderFooterView! = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UITableViewHeaderFooterView")
        view.tag = 1

        view.contentView.backgroundColor = colorRandom()
        return view
        
    }

    
}

extension SystemMessageTableViewController: UITableViewDelegate {
    
    //    @objc optional func tableView(_ tableView: MessageTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    //    @objc optional func tableView(_ tableView: MessageTableView, willDisplayHeaderView view: UIView, forSection section: Int)
    //    @objc optional func tableView(_ tableView: MessageTableView, willDisplayFooterView view: UIView, forSection section: Int)
    //    @objc optional func tableView(_ tableView: MessageTableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    //    @objc optional func tableView(_ tableView: MessageTableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    //    @objc optional func tableView(_ tableView: MessageTableView, didEndDisplayingFooterView view: UIView, forSection section: Int)
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.dataList[indexPath.section][indexPath.row])
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(self.sectionList[section].0)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(self.sectionList[section].1)
    }
    
    
    //    @objc optional func tableView(_ tableView: MessageTableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    //    @objc optional func tableView(_ tableView: MessageTableView, didHighlightRowAt indexPath: IndexPath)
    //    @objc optional func tableView(_ tableView: MessageTableView, didUnhighlightRowAt indexPath: IndexPath)
    //    @objc optional func tableView(_ tableView: MessageTableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    //    @objc optional func tableView(_ tableView: MessageTableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    //    @objc optional func tableView(_ tableView: MessageTableView, didSelectRowAt indexPath: IndexPath)
    //    @objc optional func tableView(_ tableView: MessageTableView, didDeselectRowAt indexPath: IndexPath)
}

