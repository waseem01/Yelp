//
//  SwitchCell.swift
//  YelpSearch
//
//  Created by Waseem Mohd on 4/6/17.
//  Copyright © 2017 Mohammed. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(switchCell: SwitchCell, didChange active: Bool) -> Void
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!

    var filterType: FilterType?
    var active: Bool = false
    weak var delegate: SwitchCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        switchControl.addTarget(self, action: #selector(switchTapped), for: .valueChanged)
    }

    func updateCell(filterType: FilterType, switchTitle: String, isActive: Bool) {
        switchLabel.text = switchTitle
        switchControl.isOn = isActive
        self.filterType = filterType
    }

    @objc private func switchTapped() {
        delegate?.switchCell!(switchCell: self, didChange: switchControl.isOn)
    }
}
