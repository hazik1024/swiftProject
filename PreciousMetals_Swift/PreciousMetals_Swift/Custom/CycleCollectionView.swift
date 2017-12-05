//
//  CycleCollectionView.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/7/5.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class CycleCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let _cellId = "cycleCollectionViewCell"
    private var _imageUrls:[String]
    private var _images:[UIImage]
    private var _timer:DispatchSourceTimer?
    
    public var _interval = 5.0
    
    public init(_ frame: CGRect, _ imageUrls:[String]) {
        self._imageUrls = imageUrls
        self._images = [UIImage]()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: frame.size.width, height: frame.size.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets.zero
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        self._images.append(ImageUtil.makeImage(self.bounds.size, UIColor.red))
        self._images.append(ImageUtil.makeImage(self.bounds.size, UIColor.green))
        self._images.append(ImageUtil.makeImage(self.bounds.size, UIColor.blue))
        
        self.backgroundColor = Color.bg
        self.isScrollEnabled = true
        self.isPagingEnabled = true
        self.dataSource = self
        self.delegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bounces = true
        self.alwaysBounceHorizontal = true
        self.register(CycleCollectionViewCell.self, forCellWithReuseIdentifier: _cellId)
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
            self.reloadData()
            run()
        }
    }
    
    // MARK: - 运行
    public func run() {
        if _imageUrls.count <= 1 {
            return
        }
        _autoRun = true
        _timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        _timer?.schedule(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(Int(_interval)), repeating: _interval)
        _timer?.setEventHandler {
            self.autoTimerTask()
        }
        _timer?.resume()
        logdebug()
    }
    
    // MARK: - 暂停
    public func pause() {
        _autoRun = false
        _timer?.suspend()
        logdebug()
    }
    
    // MARK: - 停止
    public func stop() {
        _autoRun = false
        _timer?.cancel()
        logdebug()
    }
    
//    /// 即将显示的item
//    private var _currItem = 1
    private var _nextItem = 0
    // MARK: - 自动滚动设置
    private var _autoRun = true
    private var _didEndDisplay = true
    
    /// 当前显示的图片序号
    private func autoTimerTask() {
        logdebug()
        _didEndDisplay = false
        if _nextItem == _imageUrls.count - 1 {
            self.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
        else {
            self.scrollToItem(at: IndexPath(item: _nextItem + 1, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if _imageUrls.count < 2 {
            return 1
        }
        return _images.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CycleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: _cellId, for: indexPath) as! CycleCollectionViewCell
        cell.imageUrl = _imageUrls[indexPath.item]
        cell.imageView?.image = _images[indexPath.item].copy() as? UIImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        _nextItem = indexPath.item
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !_didEndDisplay {
            _didEndDisplay = true
            if _autoRun && self._nextItem == self._imageUrls.count - 1 {
                stop()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(_interval * 1000)), execute: {
                    logdebug(indexPath.item)
                    self.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
                })
            }
        }
        else {
            run()
        }
    }
    
    // MARK: - UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        logdebug()
        _autoRun = false
        stop()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        logdebug()
        run()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        logdebug()
        run()
    }
}

public class CycleCollectionViewCell : UICollectionViewCell {
    private var _imageUrl: String = ""
    var imageUrl: String {
        get {
            return _imageUrl
        }
        set {
            _imageUrl = newValue
//            self.imageView?.loadImage(_imageUrl)
        }
    }
    var imageView:UIImageView?
    var indexPath:NSIndexPath?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView!)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
