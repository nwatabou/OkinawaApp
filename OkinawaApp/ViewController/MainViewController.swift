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
import GoogleMapsUtils
import Material

class MainViewController: UIViewController {

    @IBOutlet weak var map: GMSMapView!
    @IBOutlet weak var listButton: UIBarButtonItem!

    private let viewModel = MapViewModel()
    private let disposeBag = DisposeBag()
    private let defaultPosition = CLLocationCoordinate2D(latitude: 26.2140964, longitude: 127.6824531)
    private var clusterManager: GMUClusterManager?
    private var islandList = [Island]()
    private var markers = [GMSMarker]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: map, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: map, algorithm: algorithm, renderer: renderer)

        listButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let vc = IslandsListViewController.instanceFromStoryBoard()
                self?.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)

        viewModel.fetchIslands()
            .asDriver(onErrorRecover: { error in
                // TODO: エラー時の処理
                return Driver.empty()
            }).drive(onNext: { [weak self] list in
                self?.islandList = list
                self?.reloadMap()
            }).disposed(by: disposeBag)
    }

    private func reloadMap() {
        var bounds = GMSCoordinateBounds()
        for island in islandList {
            let location = toLocation(latitude: island.latitude, longitude: island.longitude)
            bounds = bounds.includingCoordinate(location)

            let marker = POIItem(position: location, name: island.name)
            clusterManager?.add(marker)
        }
        clusterManager?.cluster()
        let cameraUpdate = GMSCameraUpdate.fit(bounds, withPadding: 16.0)
        map.moveCamera(cameraUpdate)
    }

    private func toLocation(latitude: Float, longitude: Float) -> CLLocationCoordinate2D {
        let lat = CLLocationDegrees(latitude)
        let long = CLLocationDegrees(longitude)
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
