//
//  ScrollTableViewAdapter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/10/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

protocol ScrollTableViewAdapterDelegate: UIScrollViewDelegate {
    
}

class ScrollTableViewAdapter: UITableViewAdapter {
    weak var delegate: ScrollTableViewAdapterDelegate?
    
    init(delegate: ScrollTableViewAdapterDelegate? = nil) {
        self.delegate = delegate
        
        super.init()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll?(scrollView)
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidZoom?(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        delegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewWillBeginDecelerating?(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating?(scrollView)
    }
}
