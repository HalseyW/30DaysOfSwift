//
//  AppDelegate.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/7/9.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            if shortcutItem.type == "com.wushhhhhh.ios.OtherWith30DaysOfSwift.weighting" {
                handleAction()
            }
            return false
        }
        startTwitterLaunchAnimation()
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "com.wushhhhhh.ios.OtherWith30DaysOfSwift.weighting" {
            handleAction()
        }
    }
    
    func handleAction() {
        
    }
    
    /// 仿制 Twitter 启动动画
    func startTwitterLaunchAnimation() {
        let view = window!.rootViewController!.view!
        //logo图层
        let logoLayer = CALayer()
        logoLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        logoLayer.position = view.center
        logoLayer.contents = UIImage(named: "launch_logo")?.cgImage
        // An optional layer whose alpha channel is used to mask the layer’s content.
        view.layer.mask = logoLayer
        //在view上增加一层，遮盖view本身
        let shelterView = UIView(frame: view.frame)
        shelterView.backgroundColor = .white
        view.addSubview(shelterView)
        //为window设置背景色
        window!.backgroundColor = UIColor(red: 29 / 255.0, green: 161 / 255.0, blue: 242 / 255.0, alpha: 1)
        //logo放大并消失的动画
        let logoAnimation = CAKeyframeAnimation(keyPath: "bounds")
        logoAnimation.beginTime = CACurrentMediaTime() + 1
        logoAnimation.duration = 1
        logoAnimation.keyTimes = [0, 0.5, 1]
        logoAnimation.values = [NSValue(cgRect: CGRect(x: 0, y: 0, width: 100, height: 100)),
                                NSValue(cgRect: CGRect(x: 0, y: 0, width: 85, height: 85)),
                                NSValue(cgRect: CGRect(x: 0, y: 0, width: 4500, height: 4500))]
        logoAnimation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut),
                                         CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)]
        logoAnimation.isRemovedOnCompletion = false
        logoAnimation.fillMode = CAMediaTimingFillMode.forwards
        logoLayer.add(logoAnimation, forKey: "zoomAnimation")
        //使logo变透明的动画
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            shelterView.alpha = 0
        }
        animator.addCompletion { (_) in
            shelterView.removeFromSuperview()
            view.layer.mask = nil
        }
        animator.startAnimation(afterDelay: 1.5)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

