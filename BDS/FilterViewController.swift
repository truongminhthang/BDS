//
//  ViewController.swift
//  BDS
//
//  Created by Trương Thắng on 3/2/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

class FilterViewController: BaseViewController {
    private let kBottomHeight                       : CGFloat          = 50
    private let kPinSize                            : CGSize           = CGSize(width: 50, height: 50)
    
    private let mapImage                            : UIImage!         = UIImage(named: "map")
    private let pinImage                            : UIImage!         = UIImage(named: "house")
    private let buildingImage                       : UIImage!         = UIImage(named: "building")
    
    private var housesAndLandsButton                : UIButton         = UIButton()
    private var apartmentButton                     : UIButton         = UIButton()
    private var realEstateButton                    : UIButton         = UIButton()
    private let mapScrollView                       : UIScrollView     = UIScrollView()
    private let mapImageView                        : UIImageView      = UIImageView()
    private let housePinButton                      : UIButton         = UIButton()
    private let buildingPinButton                   : UIButton         = UIButton()
    private let bottomContainer                                              = UIView()
    private let estatePopView                                          = EstatePopView()
    private var estateActionSheet                   : ActionSheet!
    
    private let myLocationImage                     : UIImage!         = UIImage(named: "my_location")
    private let addEstateImage                      : UIImage!         = UIImage(named: "add")
    
    private let myLocationButton                    : UIButton         = UIButton()
    private let addEstateButton                     : UIButton         = UIButton()
    private let priceLabel                          : UILabel         = UILabel()
    
    private let slider                              : UISlider         = {
        let slider = UISlider()
        slider.maximumValue         = 16
        slider.minimumValue         = 3
        slider.value = 1
        return slider
    }()
    
    
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        housesAndLandsButton    = mt_createDefaultButton("Nhà đất", target: "onClickHouseButton")
        apartmentButton         = mt_createDefaultButton("Chung cư", target: "onClickApartmentButton")
        realEstateButton        = mt_createDefaultButton("Cho thuê", target: "onClickRentButton")
        mapImageView.image      = mapImage
        
        estatePopView.frame = CGRect(origin: CGPointZero, size: CGSize(width: 320, height: 130))
        estatePopView.delegate = self
        estateActionSheet = ActionSheet(hasBackgroundButton: true, hasToolBar: false, pluginView: estatePopView, delegate: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge.None
        layoutComponent()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Handle onclick main button

extension FilterViewController {
    func onClickHouseButton() {
        housesAndLandsButton.selected = !housesAndLandsButton.selected
        layoutHousePin()
    }
    
    func onClickApartmentButton() {
        //TODO:
        apartmentButton.selected = !apartmentButton.selected
        layoutBuildingPin()
    }
    
    func onClickRentButton() {
        //TODO:
    }
    
    func onClickPinButton() {
        //TODO:
        estateActionSheet.show()
    }
    
    func onSliderValueChange() {
        let min = slider.value * 0.8
        let max = slider.value * 1.2
        let minPrice = min * min
        let maxPrice = max * max
        
        priceLabel.text = "Từ \(floor(minPrice/10)) tỷ đến \(floor(maxPrice/10)) tỷ"
        
    }
    
    private func removeAllPin() {
        
    }
}

// MARK: - LayoutComponent

extension FilterViewController {
    private func layoutComponent() {
        configAndLayoutScrollView()
        layoutBottomButtons()
        layoutUltiButtons()
    }
    
    private func layoutBottomButtons() {
        view.addSubview(bottomContainer)
        bottomContainer.backgroundColor = UIColor.colorFromHex(0x101010, alpha: 1)
        bottomContainer.mt_InnerAlign(PinPosition.LowCenter, space: 0, size: CGSize(width: view.frame.width, height: kBottomHeight))
        bottomContainer.mt_createVerticalMenu([housesAndLandsButton, apartmentButton, realEstateButton], edge: UIEdgeInsetsZero, gap: 4, seperateColor: UIColor.darkGrayColor())
        
    }
    
    private func layoutUltiButtons() {
        layoutMyLocationButton()
        layoutAddEstateButton()
        layoutSlider()
        layoutPriceLabel()
    }

    private func layoutPriceLabel() {
        view.addSubview(priceLabel)
        priceLabel.mt_InnerAlign(PinPosition.HighCenter, space: 22, size: CGSize(width: 200, height: 30))
        priceLabel.textAlignment = NSTextAlignment.Center
        priceLabel.font = UIFont.boldSystemFontOfSize(18)


    }

    private func layoutMyLocationButton() {
        myLocationButton.setBackgroundImage(myLocationImage, forState: UIControlState.Normal)
        view.addSubview(myLocationButton)
        myLocationButton.mt_OuterAlign(PinOuterPosition.LefterTop, toView: bottomContainer, space: 10, size: CGSize(width: 40, height: 40))
    }
    
    private func layoutAddEstateButton() {
        addEstateButton.setBackgroundImage(addEstateImage, forState: UIControlState.Normal)
        view.addSubview(addEstateButton)
        addEstateButton.mt_OuterAlign(PinOuterPosition.RighterTop, toView: bottomContainer, space: 10, size: CGSize(width: 40, height: 40))
    }
    
    private func configAndLayoutScrollView() {
        mapImageView.frame      = CGRect(origin: CGPointZero, size: mapImage.size)
        mapScrollView.addSubview(mapImageView)
        mapScrollView.contentSize   = mapImage.size
        view.addSubview(mapScrollView)
        mapScrollView.mt_innerAlign(left: 0, top: 0, right: 0, bottom: 0)
        
    }
    
    private func layoutHousePin() {
        if housesAndLandsButton.selected {
            housePinButton.setImage(pinImage, forState: UIControlState.Normal)
            housePinButton.addTarget(self, action: "onClickPinButton", forControlEvents: .TouchUpInside)
            housePinButton.frame      = CGRect(origin: view.center, size: kPinSize)
            mapScrollView.addSubview(housePinButton)
        } else {
            housePinButton.removeFromSuperview()
        }
        
    }
    
    private func layoutBuildingPin() {
        if apartmentButton.selected {
            
            buildingPinButton.setImage(buildingImage, forState: UIControlState.Normal)
            buildingPinButton.addTarget(self, action: "onClickPinButton", forControlEvents: .TouchUpInside)
            buildingPinButton.frame      = CGRect(origin: CGPoint(x: 50, y: 150), size: kPinSize)
            mapScrollView.addSubview(buildingPinButton)
            
        } else {
            buildingPinButton.removeFromSuperview()
        }
    }
    
    private func layoutSlider() {
        
        view.addSubview(slider)
        slider.mt_OuterAlign(PinOuterPosition.Top, toView: bottomContainer, space: 10, size: CGSize(width: 200, height: 32))
        slider.addTarget(self, action: "onSliderValueChange", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    
    
    
}

// MARK: - EstatePopViewDelegate

extension FilterViewController: EstatePopViewDelegate {
    func didSelect() {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        estateActionSheet.hide()
    }
    
}