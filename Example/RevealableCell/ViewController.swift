//
//  ViewController.swift
//  RevealableCell
//
//  Created by Shaps Mohsenin on 01/03/2016.
//  Copyright (c) 2016 Shaps Mohsenin. All rights reserved.
//

import UIKit
import LoremIpsum
import RevealableCell

enum Cell: String {
    case Left = "leftAlignedCell"
    case Right = "rightAlignedCell"
}

class ViewController: UITableViewController {
    
    
    
    
    
    func configureCell(cell: TableViewCell, indexPath: NSIndexPath, message: Message) {
        /*
         
         This demonstrates the usage of a RevealableCell
         ---
         
         1. Your cell must be a subclass of RevealableTableViewCell
         2. You must register a nib or a RevealableView subclass using:
            tableView.registerNib(nib, forRevealableViewReuseIdentifier: "identifier")
            tableView.registerClass(revealableViewClass, forRevealableViewReuseIdentifier: "identifier")
         3. In cellForRowAtIndexPath you can dequeue and configure an instance using:
            if let view = tableView.dequeueReusableRevealableViewWithIdentifier("identifier") as? MyRevealableView {
               view.titleLabel.text = ""
               cell.setRevealableView(view, style: .Slide, direction: .Left)
            }
         
         This new implementation, allows reusable revealableViews of the same type as well as allowing you to have
         different styles/directions for individual cells.
         
         Run this project, to see a demo similar to the iMessage app on your iOS device.
         
         */
        
        if let timeStampView = tableView.dequeueReusableRevealableViewWithIdentifier("timeStamp") as? TimestampView {
            timeStampView.date = message.date
            timeStampView.width = 55
            cell.setRevealableView(timeStampView, style: message.cell == .Left ? .Over : .Slide)
        }
        
        cell.messageLabel.text = message.text
    }
    
    
    
    
    
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "TimestampView", bundle: nil), forRevealableViewReuseIdentifier: "timeStamp")
        tableView.registerNib(UINib(nibName: "TimestampView", bundle: nil), forRevealableViewReuseIdentifier: "name")
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        messages = [
            Message(cell: .Left, date: NSDate(timeIntervalSinceNow: 60), text: "Do you know how to put an Ad on Craig's List?", name: "Francesco"),
            Message(cell: .Right, date: NSDate(timeIntervalSinceNow: 120), text: "Yes, its easy. Why?", name: "Shaps"),
            Message(cell: .Left, date: NSDate(timeIntervalSinceNow: 160), text: "We need a nurse to fuck my grandma at night", name: "Francesco"),
            Message(cell: .Right, date: NSDate(timeIntervalSinceNow: 240), text: "Oh my. Well lord knows you can find that, and more, on craigslist! Haha", name: "Shaps"),
            Message(cell: .Left, date: NSDate(timeIntervalSinceNow: 340), text: "lol no my grandma needs fuck at night", name: "Francesco"),
            Message(cell: .Right, date: NSDate(timeIntervalSinceNow: 400), text: "Oh, don't we all ;)", name: "Shaps"),
            Message(cell: .Left, date: NSDate(timeIntervalSinceNow: 550), text: "help! God damn it help! Auto correct sucks!", name: "Francesco"),
            Message(cell: .Right, date: NSDate(timeIntervalSinceNow: 600), text: "HAHAHAHA!", name: "Shaps")
        ]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let controller = UIAlertController(title: "Welcome", message: "Swipe to the left to see it in action", preferredStyle: .Alert)
        controller.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        presentViewController(controller, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> RevealableTableViewCell {
        let message = messages[indexPath.item]
        let cell = tableView.dequeueReusableCellWithIdentifier(message.cell.rawValue, forIndexPath: indexPath) as! TableViewCell
        configureCell(cell, indexPath: indexPath, message: message)
        return cell
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 49
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let message = messages[indexPath.item]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(message.cell.rawValue) as? TableViewCell {
            configureCell(cell, indexPath: indexPath, message: message)
            return cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize).height
        }
        
        return 50
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Today"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
}

final class Message {
    
    let text: String
    let date: NSDate
    let cell: Cell
    let name: String
    
    init(cell: Cell, date: NSDate, text: String, name: String) {
        self.text = text
        self.cell = cell
        self.date = date
        self.name = name
    }
    
}

