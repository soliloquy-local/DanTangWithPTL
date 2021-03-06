//
//  PTLClassCell.swift
//  DanTangWithPTL
//
//  Created by pengtanglong on 16/8/30.
//  Copyright © 2016年 pengtanglong. All rights reserved.
//

import UIKit

protocol PTLClassCellDelegate {
    func classCell(_ classCell: PTLClassCell, selectCellDidAt itemId: Int)
}

class PTLClassCell: UITableViewCell {

    lazy var dataArray:NSMutableArray = { [] }()
    var delegate: PTLClassCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
}

// MARK: - 创建button
extension PTLClassCell {
    
    @objc func didClick(_ btn: UIButton) {
       let group = dataArray[btn.tag] as! PTLGroup
        delegate?.classCell(self, selectCellDidAt: group.id!)
        
    }
    
    func rankWithTotalColumnsButtonWOrButtonH(_ totalColumns:Int, buttonW:CGFloat, buttonH:CGFloat){
        //总列数
        let _totalColumns: Int = totalColumns
        
        //横向间隙 (控制器view的宽度 － 列数＊应用宽度)/(列数 ＋ 1)
        let  margin: CGFloat = (kScreenWidth - CGFloat(_totalColumns) * buttonW) / (CGFloat(_totalColumns)*2);
        
        if dataArray.count > 0 {
            
            for index in 0 ..< dataArray.count{

                let buttonView = UIButton(type: .custom);
                buttonView.tag = index
                buttonView.addTarget(self, action: #selector(didClick(_:)),  for: .touchUpInside)
                //行号
                let row : Int = index / totalColumns;
                //列号
                let col : Int = index % totalColumns;
                // 每个框框靠左边的宽度为 (平均间隔＋框框自己的宽度）
                let buttonX : CGFloat = margin + CGFloat(col) * (buttonW + 2*margin);
                // 每个框框靠上面的高度为 平均间隔＋框框自己的高度
                let buttonY : CGFloat = 40 + CGFloat(row) * (buttonH + 30);
                
                buttonView.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH);
                
                addSubview(buttonView)
                
                let url = (dataArray[index]as! PTLGroup).icon_url
                buttonView.sd_setImage(with: URL(string:url!), for: UIControlState())
                
                // 创建label
                let label = UILabel()
                let labelX : CGFloat = buttonX
                let labelY : CGFloat = buttonView.frame.maxY
                let w:CGFloat = buttonW
                let h:CGFloat = 30
                label.frame = CGRect(x: labelX, y: labelY, width: w, height: h)
                addSubview(label)
                label.text = (dataArray[index]as! PTLGroup).name
                label.textColor = RGBAColor(97, g: 97, b: 97, a: 1)
                label.textAlignment = .center
            }
        }
    }
}

extension PTLClassCell {
    func getData(_ array: [PTLGroup]) {
        dataArray.removeAllObjects()
        dataArray.addObjects(from: array)

        let buttonW:CGFloat = (kScreenWidth-(4+1)*20)/4
        let buttonH:CGFloat = buttonW
        rankWithTotalColumnsButtonWOrButtonH(4, buttonW: buttonW, buttonH: buttonH)
    }
}

extension PTLClassCell{
    
    // 类方法 重用标识符
    class func cellID () -> String {
        return "PTLClassCell"
    }
}
