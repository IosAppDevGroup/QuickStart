//
//  RatingControl.swift
//  QuickStart
//
//  Created by Flonly on 7/24/16.
//  Copyright © 2016 FlonlyIos. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: Properties
    var rating = 0 {
        didSet{
            setNeedsLayout()
        }
    }
    var ratingButtions = [UIButton]()
    
    let spacing = 5
    let starCount = 5
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let emptyImage = UIImage(named: "emptyStar")
        let filledImage = UIImage(named: "filledStar")
        
        for _ in 0 ..< starCount {
            let button = UIButton()
            button.setImage(emptyImage, forState: UIControlState.Normal)
            button.setImage(filledImage, forState: UIControlState.Selected)
            button.setImage(filledImage, forState: [UIControlState.Selected, UIControlState.Highlighted])
            button.adjustsImageWhenHighlighted = false
//            button.backgroundColor = UIColor.redColor()
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped), forControlEvents: .TouchDown)
            ratingButtions += [button]
            addSubview(button)
        }
    }
    
    func updateButtonSelectionStates(){
        for(index, button) in ratingButtions.enumerate(){
            button.selected = index < rating
        }
    }
    
    // MARK: Actions
    
    func ratingButtonTapped(button : UIButton){
        rating = ratingButtions.indexOf(button)! + 1
        updateButtonSelectionStates()
        print(" rating button tapped, rating = \(rating)\n")
    }
    
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for(index, button) in ratingButtions.enumerate(){
            buttonFrame.origin.x =  CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        return CGSize(width: width, height: buttonSize)
    }
}
