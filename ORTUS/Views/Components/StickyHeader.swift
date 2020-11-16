//
//  StickyHeader.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct StickyHeader: Carbon.Component {
    var title: String
    
    func renderContent() -> StickyHeaderView {
        return StickyHeaderView()
    }
    
    func render(in content: StickyHeaderView) {
        content.titleLabel.text = title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 30)
    }
}

class StickyHeaderView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray5
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
