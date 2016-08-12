//
//  ViewController.swift
//  MyTodoList
//
//  Created by inagaki on 2016/08/12.
//  Copyright © 2016年 inagaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var todoList = [String]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapAddButton(sender: AnyObject) {
        // アラートダイアログ作成
        let alertController = UIAlertController(
            title: "TODO 追加",
            message: "TODO を入力してください",
            preferredStyle: UIAlertControllerStyle.Alert)
        // テキストエリア追加
        alertController.addTextFieldWithConfigurationHandler(nil)
        // OK ボタンを追加
        let okAction = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default,
            handler: { (action:UIAlertAction) -> Void in
                if let textField = alertController.textFields?.first {
                    self.todoList.insert(textField.text!, atIndex: 0)

                    // テーブルに行が追加されたことをテーブルに通知
                    self.tableView.insertRowsAtIndexPaths(
                        [NSIndexPath(forRow: 0, inSection: 0)],
                        withRowAnimation: UITableViewRowAnimation.Right)
                }
            }
        )
        // OK ボタンを追加
        alertController.addAction(okAction)

        // CANCEL ボタンがタップされた時の処理
        let cancelAction = UIAlertAction(
            title: "CANCEL",
            style: UIAlertActionStyle.Cancel,
            handler: nil)
        // CANCEL ボタンを追加
        alertController.addAction(cancelAction)

        // アラートダイアログを表示
        presentViewController(alertController, animated: true, completion: nil)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("todoCell", forIndexPath: indexPath)
        let todoTitle = todoList[indexPath.row]
        cell.textLabel!.text = todoTitle
        return cell
    }

}

