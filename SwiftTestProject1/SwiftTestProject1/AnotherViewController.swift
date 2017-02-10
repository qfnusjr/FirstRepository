//
//  AnotherViewController.swift
//  SwiftTestProject1
//
//  Created by sjr on 16/12/20.
//  Copyright © 2016年 dianwangjr. All rights reserved.
//

import UIKit
import SwiftyJSON

class AnotherViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    var db: SQLiteDB!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        // 获取数据库实例
//        db = SQLiteDB.sharedInstance
//        // 如果表还不存在则创建表（其中uid为自增主键）
//        let result = db.execute(sql: "create table if not exists t_user(uid integer primary key,uname varchar(20),mobile varchar(20))")
//        print(result)
//        // 如果有数据则加载
//        initUser()
        
//        testJson()
        testSwiftyJSON()
    }
    
    // 从SQLite加载数据
    func initUser() {
        let data = db.query(sql: "select * from t_user")
        if data.count > 0 {
            // 获取最后一行数据显示
            let user = data[data.count - 1]
            usernameTextField.text = user["uname"] as? String
            phoneTextField.text = user["mobile"] as? String
        }
    }

    // 保存数据到t_user表
    @IBAction func save(_ sender: Any) {
        self.view.resignFirstResponder()
        
        let username = usernameTextField.text!
        let mobile = phoneTextField.text!
        // 插入数据库
        let sql = "insert into t_user(uname,mobile) values('\(username)','\(mobile)')"
        let result = db.execute(sql: sql)
        print(result)
    }
    
    func testJson() {
        let user:[String: Any] = [
            "uname": "张三",
            "tel": ["mobile": "138", "home": "010"]
        ]
        if !JSONSerialization.isValidJSONObject(user) {
            print("is not a valid json object")
            return
        }
        // 将对象转成JSON
        let data = try?JSONSerialization.data(withJSONObject: user, options: [])
        let str = String(data: data!, encoding: .utf8)
        print("JSON str:"); print(str)
        
        // 把Data对象转换回JOSN对象
        let json = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String : Any]
        print("JSON object:", json)
        // 验证JSON对象可用性
        let uname = json?["uname"]
        let mobile = (json?["tel"] as! [String : Any])["mobile"]
        print("get JSON object:", "uname:\(uname)", "mobile:\(mobile)")
        
        // 解析json字符串
        let string = "[{\"ID\":1,\"Name\":\"元台禅寺\",\"LineID\":1},{\"ID\":2,\"Name\":\"田坞里山塘\",\"LineID\":1},{\"ID\":3,\"Name\":\"滴水石\",\"LineID\":1}]"
        let JSONData = string.data(using: String.Encoding.utf8)
        let JSONArray = try! JSONSerialization.jsonObject(with: JSONData!, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String : Any]]
        print("记录数：\(JSONArray.count)")
        for value in JSONArray {
            print("ID: ", value["ID"]!, "Name: ", value["Name"]!)
        }
    }
    
    func testSwiftyJSON() {
        let url = URL(string: "http://www.hangge.com/getJsonData.php")
        let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: request, completionHandler:{(data, response, error) in
            if error != nil {
                print(error)
            } else {
                let json = JSON(data: data!)
                if let number = json[0]["phones"][0]["number"].string {
                    print("第一个联系人的第一个电话号码：", number)
                }
            }
        }) as URLSessionTask
        dataTask.resume()
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
