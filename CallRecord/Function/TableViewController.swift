//
//  TableViewController.swift
//  CallRecord
//
//  Created by manman on 2017/7/19.
//  Copyright © 2017年 manman. All rights reserved.
//

import UIKit

let shutDownMax:NSInteger = 60
class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    private var numberRow:NSInteger = 6
    private let tableViewCellIdentify = "tableViewCellIdentify"
    private var tableView:UITableView = UITableView()
    private var verifyCodeButton:UIButton = UIButton()
    fileprivate var shutDownTime:Timer!
    fileprivate var shutDownInt:Int = shutDownMax

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        setCustomUIAutolayout()
    }
    
    
    
    func setCustomUIAutolayout()
    {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = self.view.frame
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: tableViewCellIdentify)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(tableView)
    }


    //MARK:- UITableViewDataSources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberRow
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentify)
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        if  indexPath.row == 3 {
            verifyCodeButton.layer.cornerRadius = 3
            verifyCodeButton.tag = 11
            verifyCodeButton.frame = CGRect.init(x: 0, y: 0, width: 100, height: 30)
            verifyCodeButton.setTitle("发送验证码", for: UIControlState.normal)
            verifyCodeButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            verifyCodeButton.backgroundColor = UIColor.blue
            verifyCodeButton.setTitleColor(UIColor.white, for: UIControlState.normal)
            verifyCodeButton.addTarget(self, action: #selector(verifyCodeButtonAction(sender:)), for: UIControlEvents.touchUpInside)
            cell?.contentView.addSubview(verifyCodeButton)
           
            
        }else
        {
            cell?.textLabel?.text = indexPath.row.description
        }
        
        

        return cell!
    }
    
    
    func verifyCodeButtonAction(sender:UIButton)  {
        
        print("点击验证码")
        
        numberRow = 4
        self.shutDownRegular(button: sender)
        self.tableView.reloadData()
        
        
        
        
    }
    
    
    
    func shutDownRegular(button:UIButton) {
        
        
        button.isEnabled = false
        button.setTitle("60s", for: UIControlState.disabled)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = UIColor.lightGray
        shutDownTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(shutDownStart(timer:)), userInfo: button, repeats: true)
        shutDownTime.fire()
    }
    
    func shutDownStart(timer:Timer) {
        print("second",self.shutDownInt)
        self.shutDownInt -= 1
        let  button = timer.userInfo as! UIButton
        
        let tmpButton:UIButton = self.tableView.viewWithTag(11) as! UIButton
        tmpButton.setTitle(String(format: "重发(%d)",self.shutDownInt), for: UIControlState.disabled)
        tmpButton.backgroundColor = UIColor.gray
        if self.shutDownInt <= 0 {
            timer.invalidate()
            button.isEnabled = true
            button.backgroundColor = UIColor.blue
            self.shutDownInt = shutDownMax
        }
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
