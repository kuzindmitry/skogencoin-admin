//
//  LoadingView.swift
//  SkogenCoin
//
//  Created by Dmitry Kuzin on 20/11/2018.
//  Copyright © 2018 Stanislau Sakharchuk. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    static let shared = LoadingView()
    
    private var loadingImageView: UIImageView!
    private var label: UILabel!
    private var isPresented: Bool = false
    private let size: CGSize = CGSize(width: 51, height: 51)
    
    private init() {
        super.init(frame: UIScreen.main.bounds)
        
        loadingImageView = UIImageView(frame: CGRect(x: frame.width/2 - size.width/2, y: frame.height/2 - size.height, width: size.width, height: size.height))
        loadingImageView.contentMode = .scaleAspectFit
        loadingImageView.image = #imageLiteral(resourceName: "Loading")
        addSubview(loadingImageView)
        
        label = UILabel(frame: CGRect(x: 0, y: loadingImageView.frame.maxY + 24, width: frame.width, height: 24))
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textAlignment = .center
        label.textColor = UIColor.brandOrangeColor
        label.text = "Laster…"
        addSubview(label)
        
        backgroundColor = .white
        alpha = 0
    }
    
    override private convenience init(frame: CGRect) {
        self.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(_ duration: Double = 0) {
        guard !isPresented else { return }
        isPresented = true
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = CGFloat.pi * 2 * 0.05
        rotation.duration = 0.05
        rotation.isCumulative = true
        rotation.repeatCount = .infinity
        loadingImageView.layer.add(rotation, forKey: "rotationAnimation")
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.alpha = 1
        }) { [unowned self] _ in
            if duration > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: { [unowned self] in
                    self.dismiss()
                })
            }
        }
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.alpha = 1
        }
    }
    
    func dismiss() {
        guard isPresented else { return }
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.alpha = 0
        }) { [unowned self] _ in
            if self.isPresented {
                self.loadingImageView.layer.removeAnimation(forKey: "rotationAnimation")
                self.removeFromSuperview()
                self.isPresented = false
            }
        }
    }
    
}
