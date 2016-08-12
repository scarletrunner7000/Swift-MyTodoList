//
//  ViewController.swift
//  MyTodoList
//
//  Created by inagaki on 2016/08/12.
//  Copyright © 2016年 inagaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var todoList = [MyTodo]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //----------------
        // 読み込み処理を追加
        //----------------
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let todoListData = userDefaults.objectForKey("todoList") as? NSData {
            if let storedTodoList = NSKeyedUnarchiver.unarchiveObjectWithData(todoListData) as? [MyTodo] {
                todoList.appendContentsOf(storedTodoList)
            }
        }
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
                    let todo = MyTodo()
                    todo.todoTitle = textField.text!
                    self.todoList.insert(todo, atIndex: 0)

                    // テーブルに行が追加されたことをテーブルに通知
                    self.tableView.insertRowsAtIndexPaths(
                        [NSIndexPath(forRow: 0, inSection: 0)],
                        withRowAnimation: UITableViewRowAnimation.Right)

                    //----------------
                    // 保存処理を追加
                    //----------------
                    // シリアライズ
                    let data :NSData = NSKeyedArchiver.archivedDataWithRootObject(self.todoList)

                    // 保存
                    let userDefaults = NSUserDefaults.standardUserDefaults()
                    userDefaults.setObject(data, forKey: "todoList")
                    userDefaults.synchronize()
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

    // section 内の行数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    // ある行の cell を返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("todoCell", forIndexPath: indexPath)
        let todo = todoList[indexPath.row]
        cell.textLabel!.text = todo.todoTitle
        if todo.todoDone {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }

    // セルがタップされた時の動作
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let todo = todoList[indexPath.row]
        todo.todoDone = !todo.todoDone

        // セルの状態を変更
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)

        // データ保存
        // シリアライズ
        let data :NSData = NSKeyedArchiver.archivedDataWithRootObject(todoList)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(data, forKey: "todoList")
        userDefaults.synchronize()
    }

    // ある行のセルが編集可能かどうかの判定
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    // セルを削除した時の動作
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // 削除処理のとき

            todoList.removeAtIndex(indexPath.row)
            // セルを削除
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            // 保存
            let data :NSData = NSKeyedArchiver.archivedDataWithRootObject(todoList)
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setObject(data, forKey: "todoList")
            userDefaults.synchronize()
        }
    }

}

