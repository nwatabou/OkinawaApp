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
    private let defaultPosition = CLLocationCoordinate2D(latitude: 26.2140964, longitude: 127.6824531)

    private var map: GMSMapView!
    private var islandList = [Island]()
    private var markers = [GMSMarker]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard !islandList.isEmpty else { return }
        reloadMap()
    }

    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withTarget: defaultPosition, zoom: 12.0)
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
        var bounds = GMSCoordinateBounds()
        for island in islandList {
            let location = toLocation(latitude: island.latitude, longitude: island.longitude)
            bounds = bounds.includingCoordinate(location)
            let marker = GMSMarker(position: location)
            marker.title = island.name
            marker.map = map
        }
        let cameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 16.0)
        map.moveCamera(cameraUpdate)
    }

    private func toLocation(latitude: Float, longitude: Float) -> CLLocationCoordinate2D {
        let lat = CLLocationDegrees(latitude)
        let long = CLLocationDegrees(longitude)
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}

