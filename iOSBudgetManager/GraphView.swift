import UIKit

class GraphView: UIView {
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    var share = UIApplication.sharedApplication().delegate as! AppDelegate
    override func drawRect(rect: CGRect)
{
    
    super.drawRect(rect)
    var path = UIBezierPath()
    var yscale : Double = 1
    var time : [Double] = [Double]()
    var categorydiv : Double = 0
    var record : RecordExpenses!
    var categories : [String] = []
    var GraphArray : [RecordExpenses] = []
    var xaxisdiv : Double = 0.0
    var mainpathxaxis : Double = 0
    var mainpathyaxis : Double = 0
    // axis
    path.moveToPoint(CGPoint(x: 40, y: 560))
    path.addLineToPoint(CGPoint(x: 360, y: 560))
    path.moveToPoint(CGPoint(x: 40, y: 560))
    path.addLineToPoint(CGPoint(x: 40, y: 60))
    path.lineWidth = 4
    
    
    
    path.stroke()
    path.moveToPoint(CGPoint(x: 45, y: 560))
    // lines horizontally
    var hline = UIBezierPath()
    
    hline.lineWidth = 0.1
    // UIColor.darkGrayColor().setStroke()
    for( var i = 50; i < 360 ; i = i + 10)
{
    hline.moveToPoint(CGPoint(x: i, y: 560))
    hline.addLineToPoint(CGPoint(x: i, y: 60))
    
    
    }
    hline.stroke()
    
    
    
    // lines Vertical
    var vline = UIBezierPath()
    
    vline.lineWidth = 0.1
    //var hy : Int = 800
    // UIColor.darkGrayColor().setStroke()
    for( var i = 70; i < 560 ; i = i + 10)
{
    vline.moveToPoint(CGPoint(x: 40, y: i))
    vline.addLineToPoint(CGPoint(x: 360, y: i))
    
    
    }
    vline.stroke()
    
    
//    
//    for var i = 0 ; i < share.budget.count ; i++
//{
//    if(share.timeFrame == share.budget[i].period)
//{
//    share.budgetIndex = i
//    println("Index for the copy is \(i)")
//    share.budgetCopy = share.budget[i].list
//    
//    }
//    
//    }
    share.currentBudget = dataOfJson("http://198.209.246.96/budgetmanager/currentBudget.php?email=\(share.userEmail)&accountType=\(share.accountType)&month=\(share.tmonth)&year=\(share.tyear)");
    println("\(share.currentBudget)")
    xaxisdiv = (Double)(320 / share.currentBudget.count)
    // main graph
    var Bargraphpath = UIBezierPath() // for the left bar graph
    var BargraphpathBudget = UIBezierPath() // for the budgeted bar graph
    Bargraphpath.moveToPoint(CGPoint(x: 40, y: 560))
    mainpathxaxis = 40
    for var i = 0 ; i < share.currentBudget.count ; i++
{
    
   // record = share.currentBudget[i]
    var budgeted : NSString = share.currentBudget[i]["amountAlotted"] as! NSString
    var spent : NSString = share.currentBudget[i]["amountSpent"] as! NSString
    categories += [share.currentBudget[i]["catName"] as! String]
    categorydiv = xaxisdiv/6
    if(560-(yscale*(spent.doubleValue)) > 130)
    {
    mainpathxaxis += categorydiv
    Bargraphpath.moveToPoint(CGPoint(x: mainpathxaxis, y: 560))
    Bargraphpath.addLineToPoint(CGPoint(x: mainpathxaxis , y: 560-(yscale*((spent.doubleValue)))))
    mainpathxaxis += 2*(categorydiv)
    Bargraphpath.addLineToPoint(CGPoint(x: mainpathxaxis , y: 560-(yscale*((spent.doubleValue)))))
    Bargraphpath.addLineToPoint(CGPoint(x: mainpathxaxis , y: 560))
    Bargraphpath.addLineToPoint(CGPoint(x: mainpathxaxis - (2*categorydiv) , y: 560))
    UIColor.greenColor().setFill()
    }
    else
    {
        mainpathxaxis += categorydiv
        Bargraphpath.moveToPoint(CGPoint(x: mainpathxaxis, y: 560))
        Bargraphpath.addLineToPoint(CGPoint(x: mainpathxaxis , y: 130))
        mainpathxaxis += 2*(categorydiv)
        Bargraphpath.addLineToPoint(CGPoint(x: mainpathxaxis , y: 130))
        Bargraphpath.addLineToPoint(CGPoint(x: mainpathxaxis , y: 560))
        Bargraphpath.addLineToPoint(CGPoint(x: mainpathxaxis - (2*categorydiv) , y: 560))
        UIColor.greenColor().setFill()
    }
    Bargraphpath.fill()
    Bargraphpath.stroke()
    if(560-(yscale*(budgeted.doubleValue)) > 130)
    {

    BargraphpathBudget.moveToPoint(CGPoint(x: mainpathxaxis , y: 560))
    
    BargraphpathBudget.addLineToPoint(CGPoint(x: mainpathxaxis , y: 560-(yscale*(budgeted.doubleValue))))
    mainpathxaxis += 2*(categorydiv)
    BargraphpathBudget.addLineToPoint(CGPoint(x: mainpathxaxis , y: 560-(yscale*(budgeted.doubleValue))))
    BargraphpathBudget.addLineToPoint(CGPoint(x: mainpathxaxis , y: 560))
    UIColor.redColor().setFill()
    BargraphpathBudget.addLineToPoint(CGPoint(x: mainpathxaxis - (2*categorydiv) , y: 560))
    BargraphpathBudget.moveToPoint(CGPoint(x: mainpathxaxis , y: 560))
    }
    
    else
    {
        BargraphpathBudget.moveToPoint(CGPoint(x: mainpathxaxis , y: 560))
        
        BargraphpathBudget.addLineToPoint(CGPoint(x: mainpathxaxis , y: 130))
        mainpathxaxis += 2*(categorydiv)
        BargraphpathBudget.addLineToPoint(CGPoint(x: mainpathxaxis , y: 130))
        BargraphpathBudget.addLineToPoint(CGPoint(x: mainpathxaxis , y: 560))
        UIColor.redColor().setFill()
        BargraphpathBudget.addLineToPoint(CGPoint(x: mainpathxaxis - (2*categorydiv) , y: 560))
        BargraphpathBudget.moveToPoint(CGPoint(x: mainpathxaxis , y: 560))
    }
    BargraphpathBudget.fill()
    BargraphpathBudget.stroke()
    mainpathxaxis += categorydiv
    
    
    // day1
    
    
    
    
    
    }
    
    // Y - axis labels
    
    // 50 laabel
    var consumption = UILabel()
    consumption.text = "$ 50"
    consumption.font = UIFont(name: "Helvetica", size: 12.0)
    consumption.setTranslatesAutoresizingMaskIntoConstraints(false)
    addSubview(consumption)
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterX,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 20))
    
    
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterY,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 510))
    
    // 100 laabel
    consumption = UILabel()
    consumption.text = "$ 100"
    consumption.font = UIFont(name: "Helvetica", size: 12.0)
    consumption.setTranslatesAutoresizingMaskIntoConstraints(false)
    addSubview(consumption)
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterX,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 20))
    
    
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterY,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 460))
    
    // 150 laabel
    consumption = UILabel()
    consumption.text = "$ 150"
    consumption.font = UIFont(name: "Helvetica", size: 12.0)
    consumption.setTranslatesAutoresizingMaskIntoConstraints(false)
    addSubview(consumption)
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterX,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 20))
    
    
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterY,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 410))
    
    // 200 laabel
    consumption = UILabel()
    consumption.text = "$ 200"
    consumption.font = UIFont(name: "Helvetica", size: 12.0)
    consumption.setTranslatesAutoresizingMaskIntoConstraints(false)
    addSubview(consumption)
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterX,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 20))
    
    
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterY,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 360))
    
    // 250 laabel
    consumption = UILabel()
    consumption.text = "$ 250"
    consumption.font = UIFont(name: "Helvetica", size: 12.0)
    consumption.setTranslatesAutoresizingMaskIntoConstraints(false)
    addSubview(consumption)
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterX,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 20))
    
    
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterY,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 310))
    
    
    // 300 laabel
    consumption = UILabel()
    consumption.text = "$ 300"
    consumption.font = UIFont(name: "Helvetica", size: 12.0)
    consumption.setTranslatesAutoresizingMaskIntoConstraints(false)
    addSubview(consumption)
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterX,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 20))
    
    
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterY,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 260))
    
    // 350 laabel
    consumption = UILabel()
    consumption.text = "$ 350"
    consumption.font = UIFont(name: "Helvetica", size: 12.0)
    consumption.setTranslatesAutoresizingMaskIntoConstraints(false)
    addSubview(consumption)
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterX,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 20))
    
    
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterY,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 210))
    
    // 400 laabel
    consumption = UILabel()
    consumption.text = "$ 400"
    consumption.font = UIFont(name: "Helvetica", size: 12.0)
    consumption.setTranslatesAutoresizingMaskIntoConstraints(false)
    addSubview(consumption)
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterX,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 20))
    
    
    addConstraint(NSLayoutConstraint(
    item: consumption,
    attribute: NSLayoutAttribute.CenterY,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 160))
    
    // 450 laabel
//    consumption = UILabel()
//    consumption.text = "$ 450"
//    consumption.font = UIFont(name: "Helvetica", size: 12.0)
//    consumption.setTranslatesAutoresizingMaskIntoConstraints(false)
//    addSubview(consumption)
//    addConstraint(NSLayoutConstraint(
//    item: consumption,
//    attribute: NSLayoutAttribute.CenterX,
//    relatedBy: NSLayoutRelation.Equal,
//    toItem: self,
//    attribute: NSLayoutAttribute.Top,
//    multiplier: 1.0,
//    constant: 20))
//    
//    
//    addConstraint(NSLayoutConstraint(
//    item: consumption,
//    attribute: NSLayoutAttribute.CenterY,
//    relatedBy: NSLayoutRelation.Equal,
//    toItem: self,
//    attribute: NSLayoutAttribute.Top,
//    multiplier: 1.0,
//    constant: 110))
    
    if(categories.count == 5)
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
    constant: 70))
    
    
    addConstraint(NSLayoutConstraint(
    item: label,
    attribute: NSLayoutAttribute.CenterY,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 580))
    
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
    constant: 140))
    
    
    addConstraint(NSLayoutConstraint(
    item: label,
    attribute: NSLayoutAttribute.CenterY,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 580))
    
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
    constant: 200))
    
    
    addConstraint(NSLayoutConstraint(
    item: label,
    attribute: NSLayoutAttribute.CenterY,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 580))
    
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
    constant: 270))
    
    
    addConstraint(NSLayoutConstraint(
    item: label,
    attribute: NSLayoutAttribute.CenterY,
    relatedBy: NSLayoutRelation.Equal,
    toItem: self,
    attribute: NSLayoutAttribute.Top,
    multiplier: 1.0,
    constant: 580))

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
        constant: 340))
    
    
    addConstraint(NSLayoutConstraint(
        item: label,
        attribute: NSLayoutAttribute.CenterY,
        relatedBy: NSLayoutRelation.Equal,
        toItem: self,
        attribute: NSLayoutAttribute.Top,
        multiplier: 1.0,
        constant: 580))
        
    }
    else if(categories.count == 6)
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
            constant: 60))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
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
            constant: 130))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
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
            constant: 180))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
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
            constant: 240))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
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
            constant: 285))
        
        
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
            constant: 340))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
    }
    else if(categories.count == 7)
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
            constant: 70))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
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
            constant: 120))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
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
            constant: 155))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
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
            constant: 200))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
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
            constant: 250))
        
        
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
            constant: 290))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
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
            constant: 340))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))

        
    }


    else if(categories.count == 4)
    {
        var label = UILabel()
        label.text = categories[0]
        label.font = UIFont(name: "Helvetica", size: 15.0)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(label)
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 70))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
        label = UILabel()
        label.text = categories[1]
        label.font = UIFont(name: "Helvetica", size: 15.0)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(label)
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 150))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
        label = UILabel()
        label.text = categories[2]
        label.font = UIFont(name: "Helvetica", size: 15.0)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(label)
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 240))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
        label = UILabel()
        label.text = categories[3]
        label.font = UIFont(name: "Helvetica", size: 15.0)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(label)
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 330))
        
        
        addConstraint(NSLayoutConstraint(
            item: label,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 580))
        
               
    }

    
    }
    
   
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)!
        var error: NSError?
        var jsonArray: NSArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSArray
        //println(data)
        return jsonArray;
    }

}

