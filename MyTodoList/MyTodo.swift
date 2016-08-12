//
//  MyTodo.swift
//  MyTodoList
//
//  Created by inagaki on 2016/08/12.
//  Copyright © 2016年 inagaki. All rights reserved.
//

import Foundation


class MyTodo: NSObject, NSCoding {
    // Todo のタイトル
    var todoTitle :String?
    // Todo を完了したかどうかを表すフラグ
    var todoDone :Bool = false

    // コンストラクタ
    override init() {
    }

    // デシリアライズ
    required init?(coder aDecoder: NSCoder) {
        todoTitle = aDecoder.decodeObjectForKey("todoTitle") as? String
        todoDone = aDecoder.decodeBoolForKey("todoDone")
    }

    // シリアライズ
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(todoTitle, forKey: "todoTitle")
        aCoder.encodeBool(todoDone, forKey: "todoDone")
    }
}


