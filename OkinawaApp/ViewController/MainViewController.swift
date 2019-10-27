//
//  ViewController.swift
//  OkinawaApp
//
//  Created by nancy on 2019/07/06.
//  Copyright © 2019 nwatabou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMaps

class MainViewController: UIViewController {

    private let viewModel = MapViewModel()
    private let disposeBag = DisposeBag()

    private var map: GMSMapView!
    private var islandList = [Island]() {
        didSet {
            reloadMap()
        }
    }
    private var markers = [GMSMarker]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 26.2140964, longitude: 127.6824531, zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        map = mapView
    }

    private func configView() {
        viewModel.fetchIslands()
            .asDriver(onErrorRecover: { error in
                // TODO: エラー時の処理
                return Driver.empty()
            }).drive(onNext: { [weak self] list in
                self?.islandList = list
            }).disposed(by: disposeBag)
    }

    private func reloadMap() {
        for island in islandList {
            let location = toLocation(latitude: island.latitude, longitude: island.longitude)
            let marker = GMSMarker(position: location)
            marker.title = island.name
            marker.map = map
        }
    }

    private func toLocation(latitude: Float, longitude: Float) -> CLLocationCoordinate2D {
        let lat = CLLocationDegrees(latitude)
        let long = CLLocationDegrees(longitude)
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}

