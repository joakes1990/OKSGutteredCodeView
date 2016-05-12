//
//  OKSGutteredCodeView.swift
//  OKSGutteredCodeView
//
//  Created by Justin Oakes on 5/12/16.
//  Copyright © 2016 J.B. Hunt. All rights reserved.
//

import UIKit

class OKSGutteredCodeView: UIView, UITextViewDelegate {

    @IBOutlet weak var gutterView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    var view: UIView!
    var font: UIFont?
    private var numberOfLines = 1
    private var gutterSubViews: [UILabel] = []
    
    func xibSetUp() {
        view = loadFromXib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
    }
    
    func loadFromXib() -> UIView {
        let bundle: NSBundle = NSBundle(forClass: self.dynamicType)
        let xib: UINib = UINib(nibName: "OKSGutteredCodeView", bundle: bundle)
        let view: UIView = xib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    override init(frame: CGRect) {
        //setup properties later
        
        super.init(frame: frame)
        xibSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //set up properties later
        
        super.init(coder: aDecoder)
        xibSetUp()
    }
    
    func setGutterBackgroundColor(color: UIColor) {
        self.gutterView.backgroundColor = color
    }
    
    func setGutterFont(font: UIFont) {
        //implement this later
    }
    
    func setTextViewFont(font: UIFont) {
        self.textView.font = font
    }
    
    //MARK UITextView Delegate Methods
    
    func textViewDidChange(textView: UITextView) {
        for label in self.gutterSubViews {
            label.removeFromSuperview()
        }
        self.numberOfLines = self.countNumberOfLines()
        self.addNumberToGutter()
    }
    
    //MARK sorting out number and location of lines
    
    func countNumberOfLines() -> Int {
        let text = self.textView.text
        let seperatedLines = text.componentsSeparatedByString("\n")
        return seperatedLines.count - 1
    }
    
    func addNumberToGutter() {
        let text = self.textView.text
        let seperatedLines = text.componentsSeparatedByString("\n")
        var numberInsertionPoint: CGFloat = 0
        var counter: Int = 1
        for line in seperatedLines {
            let label: UILabel = UILabel(frame: CGRectMake(0, numberInsertionPoint, 30, self.textView.font!.lineHeight))
            label.text = "\(counter)"
            self.gutterView.addSubview(label)
            self.gutterSubViews.append(label)
            counter += 1
            numberInsertionPoint = numberInsertionPoint + heightOfLine(line)
        }
    }
    
    func heightOfLine(line: String) -> CGFloat {
        let font: UIFont = self.textView.font!
        let textViewWidth: CGFloat = self.textView.bounds.width
        let lineHeight = line.boundingRectWithSize(CGSizeMake(textViewWidth, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil).height
        return lineHeight
    }
}