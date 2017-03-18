//
//  UIView+Constraints.swift
//  TvTime
//
//  Created by Nofel Mahmood on 08/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func pin(toView view: UIView, top: Bool, bottom: Bool, leading: Bool, trailing: Bool) {
        
        if top {
            topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        
        if bottom {
            bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        if leading {
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        }
        
        if trailing {
            view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    }
    
    func pin(toView view: UIView, top: Bool, bottom: Bool, leading: Bool, trailing: Bool, padding: CGFloat) {
        
        if top {
            topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
        }
        
        if bottom {
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding).isActive = true
        }
        
        if leading {
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        }
        
        if trailing {
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding).isActive = true
        }
    }
    
    func pinEdges(toView view: UIView) {
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor).isActive = true
        superview!.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: superview!.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func pinEdgesToSuperview() {
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor).isActive = true
        superview!.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: superview!.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor).isActive = true
    }
    
    func pinEdgesToSuperview(margin: CGFloat) {
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: margin).isActive = true
        superview!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: margin).isActive = true
        topAnchor.constraint(equalTo: superview!.topAnchor, constant: margin).isActive = true
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -margin).isActive = true
    }
    
    func pinTopToSuperview() {
        topAnchor.constraint(equalTo: superview!.topAnchor).isActive = true
    }
    
    func pinTopToSuperview(margin: CGFloat) {
        topAnchor.constraint(equalTo: superview!.topAnchor, constant: margin).isActive = true
    }
    
    func pinBottomToSuperview(margin: CGFloat) {
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -margin).isActive = true
    }
    
    func pinLeadingToSuperview() {
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor).isActive = true
    }
    
    func pinLeadingToSuperview(margin: CGFloat) {
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: margin).isActive = true
    }
    
    func pinTrailingToSuperview(margin: CGFloat) {
        superview!.trailingAnchor.constraint(equalTo: trailingAnchor, constant: margin).isActive = true
    }
    
    func pinLeadingToTrailing(ofView view: UIView, margin: CGFloat) {
        leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: margin).isActive = true
    }
    
    func pinLeadingAndTopToSuperview(margin: CGFloat) {
        leadingAnchor.constraint(equalTo: superview!.leadingAnchor, constant: margin).isActive = true
        topAnchor.constraint(equalTo: superview!.topAnchor, constant: margin).isActive = true
    }
    
    func pinTopAndBottomToSuperview(margin: CGFloat) {
        topAnchor.constraint(equalTo: superview!.topAnchor, constant: margin).isActive = true
        bottomAnchor.constraint(equalTo: superview!.bottomAnchor, constant: -margin).isActive = true
    }
    
    func centerHorizontally() {
        centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
    }
    
    func centerVertically() {
        centerYAnchor.constraint(equalTo: superview!.centerYAnchor).isActive = true
    }
    
}
