//
//  Budgeted.swift
//  iOSBudgetManager
//
//  Created by Kopparthi,Satya Sandeep on 11/18/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class Budgeted: UIView {
    
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    var total : Double = 0
    var budgeted : [NSString] = []
    var categories : [String] = []
    var colour : [UIColor] = [ UIColor.redColor(), UIColor.purpleColor(),  UIColor.orangeColor(), UIColor.greenColor(),UIColor.grayColor(),  UIColor.cyanColor(),  UIColor.brownColor(),  UIColor.blueColor(),  UIColor.blackColor(), UIColor.lightGrayColor(),  UIColor.magentaColor(), UIColor.redColor(), UIColor.yellowColor()]
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)!
        var error: NSError?
        var jsonArray: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        //println(data)
        return jsonArray;
    }
    
    override func drawRect(rect: CGRect)
    {
        
        share.currentBudget = dataOfJson("http://198.209.246.96/budgetmanager/currentBudget.php?email=\(share.userEmail)&accountType=\(share.accountType)&month=\(share.tmonth)&year=\(share.tyear)");
        
        for(var i = 0 ; i < share.currentBudget.count; i++)
        {
            var budget : NSString = share.currentBudget[i]["amountAlotted"] as! NSString
            var catName : String = share.currentBudget[i]["catName"] as! String
            budgeted += [budget]
            categories += [catName]
            
        }
        
        for(var i = 0 ; i < budgeted.count; i++)
        {
            total += budgeted[i].doubleValue
        }
        
        
        for(var i = 0 ; i < share.currentBudget.count; i++)
        {
            
            println("\(categories[i]) percentage is :\((budgeted[i].doubleValue/total))%")
        }
        
        let pi : CGFloat = 3.14159
        var center =  CGPoint(x: 188, y: 280)
        
        var path1 = UIBezierPath()
        var startangle : CGFloat = CGFloat(0)
        var endangle : CGFloat =  CGFloat(0)
        
        var rand : CGFloat = CGFloat(0);
        
        //path.addLineToPoint(CGPoint(x: 366, y: 280))
        //        path.moveToPoint(center)
        //                path.addArcWithCenter(center, radius: 180, startAngle: 2*pi*startangle , endAngle: 2*pi*endangle , clockwise: false)
        //                    endangle += 0
        //                    startangle = 1/16
        //        path.moveToPoint(center)
        //        path.addArcWithCenter(center, radius: 180, startAngle: 2*pi*startangle , endAngle: 2*pi*endangle , clockwise: false)
        //path.closePath()
        //        path.stroke()
        //        endangle += startangle
        //        startangle = 1/8
        //        path.moveToPoint(center)
        //        path.addArcWithCenter(center, radius: 180, startAngle: 2*pi*startangle , endAngle: 2*pi*endangle , clockwise: false)
        //        path.closePath()
        //        path.stroke()
        println()
        println()
        for(var i = 0 ; i < budgeted.count; i++)
        {
            
            var path =  UIBezierPath()
            path.lineWidth = 2
            startangle += CGFloat((budgeted[i].doubleValue)/total)
            println("The Start angle is \(startangle) and the end angle  is \(endangle)")
            
            path.moveToPoint(center)
            path.addArcWithCenter(center, radius: 140, startAngle: 2*pi*startangle , endAngle: 2*pi*endangle , clockwise: false)
            path.closePath()
            colour[i].setFill()
            path.fill()
            
            endangle = startangle
            
            
            // path.closePath()
            colour[i].setFill()
            path.fill()
            path.stroke()
            
            
            
            //            if(i == budgets.count-1)
            //            {
            //                path.moveToPoint(center)
            //                path.addArcWithCenter(center, radius: 180, startAngle: 2*pi , endAngle: 2*pi*endangle , clockwise: false)
            //                endangle += startangle
            //                startangle += CGFloat((budgets[i].budget.doubleValue)/total)
            //                path.stroke()
            //
            //            }
        }
        
        
        var y = CGFloat(450)
        var x = CGFloat(40)
        for(var i = 0 ; i < budgeted.count; i++)
        {
            
            var rect = UIBezierPath(rect: CGRect(x: x , y: y, width: 20, height: 20))
            colour[i].setFill()
            rect.fill()
            rect.stroke()
            y += CGFloat(30)
            
            if(i == 6)
            {
                x = CGFloat(220)
                y = CGFloat(450)
                
            }
            
        }
        
        
        if(budgeted.count == 5)
        {
            var label = UILabel()
            label.text = categories[0]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 460))
            
            label = UILabel()
            label.text = categories[1]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 490))
            
            label = UILabel()
            label.text = categories[2]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 520))
            
            label = UILabel()
            label.text = categories[3]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 550))
            
            label = UILabel()
            label.text = categories[4]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 580))
            
            
            
        }
        else if(budgeted.count == 6)
        {
            var label = UILabel()
            label.text = categories[0]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 460))
            
            label = UILabel()
            label.text = categories[1]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 490))
            
            label = UILabel()
            label.text = categories[2]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 520))
            
            label = UILabel()
            label.text = categories[3]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 550))
            
            label = UILabel()
            label.text = categories[4]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 580))
            
            
            
            label = UILabel()
            label.text = categories[5]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 610))
            
        }
        else if(budgeted.count == 7)
        {
            var label = UILabel()
            label.text = categories[0]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 460))
            
            label = UILabel()
            label.text = categories[1]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 490))
            
            label = UILabel()
            label.text = categories[2]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 520))
            
            label = UILabel()
            label.text = categories[3]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 550))
            
            label = UILabel()
            label.text = categories[4]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 580))
            
            
            
            label = UILabel()
            label.text = categories[5]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 610))
            
            label = UILabel()
            label.text = categories[6]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 640))
            
            
            
        }
        else if(budgeted.count == 10)
        {
            var label = UILabel()
            label.text = categories[0]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 460))
            
            label = UILabel()
            label.text = categories[1]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 490))
            
            label = UILabel()
            label.text = categories[2]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 520))
            
            label = UILabel()
            label.text = categories[3]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 550))
            
            label = UILabel()
            label.text = categories[4]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 580))
            
            
            
            label = UILabel()
            label.text = categories[5]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 610))
            
            label = UILabel()
            label.text = categories[6]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 640))
            
            
            label = UILabel()
            label.text = categories[7]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 280))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 460))
            
            label = UILabel()
            label.text = categories[8]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 280))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 490))
            
            label = UILabel()
            label.text = categories[9]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 280))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 520))
            
        }
        else if(budgeted.count == 9)
        {
            var label = UILabel()
            label.text = categories[0]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 460))
            
            label = UILabel()
            label.text = categories[1]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 490))
            
            label = UILabel()
            label.text = categories[2]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 520))
            
            label = UILabel()
            label.text = categories[3]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 550))
            
            label = UILabel()
            label.text = categories[4]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 580))
            
            
            
            label = UILabel()
            label.text = categories[5]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 610))
            
            label = UILabel()
            label.text = categories[6]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 640))
            
            
            label = UILabel()
            label.text = categories[7]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 280))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 460))
            
            label = UILabel()
            label.text = categories[8]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 280))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 490))
            
        }
            
        else if(budgeted.count == 8)
        {
            var label = UILabel()
            label.text = categories[0]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 460))
            
            label = UILabel()
            label.text = categories[1]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 490))
            
            label = UILabel()
            label.text = categories[2]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 520))
            
            label = UILabel()
            label.text = categories[3]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 550))
            
            label = UILabel()
            label.text = categories[4]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 580))
            
            
            
            label = UILabel()
            label.text = categories[5]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 610))
            
            label = UILabel()
            label.text = categories[6]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 640))
            
            
            label = UILabel()
            label.text = categories[7]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 280))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 460))
            
            
        }
            
        else if(budgeted.count == 4)
        {
            var label = UILabel()
            label.text = categories[0]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 460))
            
            label = UILabel()
            label.text = categories[1]
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 490))
            
            label = UILabel()
            label.text = categories[2] as String
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 520))
            
            label = UILabel()
            label.text = categories[3] as String
            label.font = UIFont(name: "Helvetica", size: 12.0)
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            addSubview(label)
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 110))
            
            
            addConstraint(NSLayoutConstraint(
                item: label,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 550))
            
        }
        
        
        
        
        
    }
}







