//
//  VCProtocol.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/10/13.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

public protocol VCProtocol: NSObjectProtocol {
    func didLoad()
    func willAppear(_ animated:Bool)
    func didAppear(_ animated:Bool)
    func willDisappear(_ animated:Bool)
    func didDisappear(_ animated:Bool)
}
