//
//  HomeViewModel.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/7/31.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit

class HomeViewModel: BaseViewModel, LocationDelegate {
    private let viewController: HomeVC
    public init(_ viewController: HomeVC) {
        self.viewController = viewController
        super.init()
        LocationUtil.INSTANCE.start(self)
    }
    
    func doTest() {
        FileUtil.deleteAll()
        LocalCacheUtil.saveImage("redImage", ImageUtil.makeImage(CGSize(width: 100, height: 100), Color.up))
        var image = LocalCacheUtil.getImage("redImage")
        logdebug(image ?? "no image")
        LocalCacheUtil.deleteImage("redImage")
        image = LocalCacheUtil.getImage("redImage")
        logdebug(image ?? "no image")
        
        let dict = ["aaa": "111", "bbb": "222"]
        LocalCacheUtil.saveDictionary("testDict", dict)
        var dic = LocalCacheUtil.getDictionary("testDict")
        logdebug(dic ?? "no dictionary")
        LocalCacheUtil.deleteDictionary("testDict")
        dic = LocalCacheUtil.getDictionary("testDict")
        logdebug(dic ?? "no dictionary")
//        addNotificationObserver("aaa")
//        addNotificationObserver("bbb", object: nil)
//        addNotificationObserver("ccc")
//        logdebug()
//        postNotification("aaa")
//        postNotification("bbb", nil, nil)
//        postNotification("ccc", ["333":"333"])
    }
    
    func getImage(_ url: String, _ callback: (_ image: UIImage?)->Void) -> Void {
        callback(LocalCacheUtil.getImage(url))
    }
    
    let timer = DispatchSource.makeTimerSource()
    func queryQuotationList() -> Void {
        timer.schedule(deadline: DispatchTime.now(), repeating: 10, leeway: DispatchTimeInterval.seconds(5))
        timer.setEventHandler {
            ActionService.request(QuotationListAction(self))
        }
        timer.resume()
    }
    
    override func receiveNotification(_ notify: Notification) {
        logdebug(notify)
    }
    
    // MARK: - LocationDelegate
    func locationDidSuccessResult(_ longitude: Double, _ latitude: Double, _ country: String, _ state: String, _ city: String, _ countryCode: String) {
        logdebug(country, state, city, longitude, latitude, countryCode)
        DeviceInfo.INSTANCE.longitude = String(longitude)
        DeviceInfo.INSTANCE.latitude = String(latitude)
        DeviceInfo.INSTANCE.country = country
        DeviceInfo.INSTANCE.state = state
        DeviceInfo.INSTANCE.city = city
        DeviceInfo.INSTANCE.gpsCountryCode = countryCode
    }
    func locationDidError(_ error: Error) {
        logdebug(error)
    }
    
    override func requestDidCompleted(_ action: BaseAction) {
        logdebug(action.topid)
    }
    override func responseDidFailed(_ action: BaseAction, _ code: NetworkStatus) {
        logdebug(action.topid)
    }
    override func responseDidSuccess(_ action: BaseAction) {
        let data = action.response?.data
        logdebug(data ?? "")
    }
}
