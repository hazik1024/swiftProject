//
//  CycleView.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/22.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class CycleView: UIScrollView, UIScrollViewDelegate {
    private var _imageUrls:[String]
    private var _images:[UIImage]
    public var _interval = 5.0
    private var timer:DispatchSourceTimer?
    
    public init(_ frame: CGRect, _ imageUrls:[String]) {
        self._imageUrls = imageUrls
        self._images = [UIImage]()
        super.init(frame: frame)
        
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bounces = false
        
        self.initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self._imageUrls = []
        self._images = [UIImage]()
        super.init(coder: aDecoder)
    }
    // MARK: - 动态变更参数
    public var interval:Double {
        get {
            return _interval
        }
        set {
            _interval = newValue
            if _interval < 2.0 {
                _interval = 2.0
            }
            stop()
            run()
        }
    }
    public var imageUrls:[String] {
        get {
            return _imageUrls
        }
        set {
            stop()
            _imageUrls = newValue
            initSubView()
            run()
        }
    }
    
    // MARK: - 初始化View
    private var iv0:UIImageView?
    private var iv1:UIImageView?
    private var iv2:UIImageView?
    private func initSubView() {
        if _imageUrls.count < 1 {
            return
        }
        self._images.append(ImageUtil.makeImage(self.bounds.size, UIColor.red))
        self._images.append(ImageUtil.makeImage(self.bounds.size, UIColor.green))
        self._images.append(ImageUtil.makeImage(self.bounds.size, UIColor.blue))
        
        self.contentSize = self.frame.size
        iv0 = UIImageView(frame: self.bounds)
        iv0?.image = self._images[2]
        self.addSubview(iv0!)
        if _imageUrls.count > 1 {
            self.contentSize = CGSize(width: self.bounds.maxX * 3, height: self.bounds.maxY)
            iv1 = UIImageView(frame: CGRect(x: self.bounds.maxX, y: self.bounds.minY, width: self.bounds.maxX, height: self.bounds.maxY))
            iv2 = UIImageView(frame: CGRect(x: self.bounds.maxX * 2, y: self.bounds.minY, width: self.bounds.maxX, height: self.bounds.maxY))
            iv1?.image = self._images[0]
            iv2?.image = self._images[1]
            self.contentOffset = CGPoint(x: self.bounds.size.width, y: self.contentOffset.y)
            self.addSubview(iv1!)
            self.addSubview(iv2!)
        }
    }
    
    // MARK: - 运行
    public func run() {
        if _imageUrls.count <= 1 {
            return
        }
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer?.schedule(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(Int(_interval)), repeating: _interval)
        timer?.setEventHandler {
            self.changeIndex()
        }
        timer?.resume()
    }
    
    // MARK: - 暂停
    public func pause() {
        timer?.suspend()
    }
    
    // MARK: - 停止
    public func stop() {
        timer?.cancel()
    }
    
    
    // MARK: - 自动滚动设置
    private var _autoRun = true
    private var _currIndex = 0
    private func changeIndex(_ next: Bool = true) {
        let direction = next ? 1 : -1
        var index = (_currIndex + direction) % _imageUrls.count
        if index < 0 {
            index = _imageUrls.count - 1
        }
        if index >= _imageUrls.count {
            index = 0
        }
        _currIndex = index
        let offset = CGPoint(x: self.contentOffset.x + CGFloat(direction) * self.bounds.size.width, y: self.contentOffset.y)
        self.setContentOffset(offset, animated: true)
    }
    
    var _lastContentOffsetX:CGFloat = 0
    var _checkDirection:Bool = false
    // MARK: - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        logdebug()
        if _imageUrls.count < 1 {
            return
        }
        _autoRun = false
        _lastContentOffsetX = self.contentOffset.x
        _checkDirection = true
        stop()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if _imageUrls.count < 1 {
            return
        }
        let offsetX = self.contentOffset.x
        if _checkDirection {
            logdebug()
            var right = false
            
            if offsetX > _lastContentOffsetX {
                right = true
            }
            changeIndex(right)
            _checkDirection = false
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            logdebug()
            let offsetXRate = self.contentOffset.x / self.bounds.size.width
            let offsetRate = ceil(offsetXRate)
            logdebug(offsetRate, offsetXRate)
            if offsetXRate < offsetRate {
                self.setContentOffset(CGPoint(x: offsetRate * self.bounds.size.width, y: self.contentOffset.y), animated: true)
            }
            if !_autoRun {
                fixScrollView()
            }
            run()
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        logdebug()
        let offsetXRate = self.contentOffset.x / self.bounds.size.width
        let offsetRate = ceil(offsetXRate)
        logdebug(offsetRate, offsetXRate)
        if offsetXRate < offsetRate {
            self.setContentOffset(CGPoint(x: offsetRate * self.bounds.size.width, y: self.contentOffset.y), animated: true)
        }
        if !_autoRun {
            fixScrollView()
        }
        run()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        logdebug("自动滚动调用此方法")
        if _autoRun {
            fixScrollView()
        }
    }
    
    private func fixScrollView() {
        var _preIndex = _currIndex - 1
        var _nextIndex = _currIndex + 1
        if _preIndex < 0 {
            _preIndex = _imageUrls.count - 1
        }
        if _nextIndex >= _imageUrls.count {
            _nextIndex = 0
        }
        iv0?.image = _images[_preIndex]
        iv1?.image = _images[_currIndex]
        iv2?.image = _images[_nextIndex]
        logdebug(_currIndex)
        self.setContentOffset(CGPoint(x: self.bounds.size.width, y: self.contentOffset.y), animated: false)
    }
}
