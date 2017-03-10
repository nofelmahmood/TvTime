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
        
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func pinEdgesToSuperview() {
        
        guard let view = superview else {
            return
        }
        
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func pinEdgesToSuperview(margin: CGFloat) {
        
        guard let view = superview else {
            return
        }
        
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: margin).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: margin).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin).isActive = true
    }
    
    func pinTopToSuperview() {
        
        guard let view = superview else {
            return
        }
        
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func pinTopToSuperview(margin: CGFloat) {
        
        guard let view = superview else {
            return
        }
        
        topAnchor.constraint(equalTo: view.topAnchor, constant: margin).isActive = true
    }
    
    func pinLeadingToSuperview() {
        
        guard let view = superview else {
            return
        }
        
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    func pinLeadingToSuperview(margin: CGFloat) {
        
        guard let view = superview else {
            return
        }
        
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
    }
    
    func pinLeadingToTrailing(ofView view: UIView, margin: CGFloat) {
        
        leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: margin).isActive = true
    }
    
    func pinLeadingAndTopToSuperview(margin: CGFloat) {
        
        guard let view = superview else {
            return
        }
        
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin).isActive = true
        topAnchor.constraint(equalTo: view.topAnchor, constant: margin).isActive = true
    }
    
    func pinTopAndBottomToSuperview(margin: CGFloat) {
        
        guard let view = superview else {
            return
        }
        
        topAnchor.constraint(equalTo: view.topAnchor, constant: margin).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margin).isActive = true
    }
    
    func centerHorizontally() {
        
        guard let view = superview else {
            return
        }
        
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerVertically() {
        
        guard let view = superview else {
            return
        }
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
