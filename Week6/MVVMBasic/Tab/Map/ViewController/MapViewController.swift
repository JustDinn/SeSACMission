//
//  MapViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import UIKit
import MapKit
import SnapKit

class MapViewController: UIViewController {
    
    // MARK: - Property
    
    private let restaurantList = RestaurantList.restaurantArray
     
    private let mapView = MKMapView()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMapView()
        addSeoulStationAnnotation()
        addRestaurantListAnnotation()
    }
     
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "지도"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "메뉴",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
         
        view.addSubview(mapView)
         
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
    }
    
    private func addSeoulStationAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.5547, longitude: 126.9706)
        annotation.title = "서울역"
        annotation.subtitle = "대한민국 서울특별시"
        mapView.addAnnotation(annotation)
    }
    
    private func addRestaurantListAnnotation() {
        var annotations: [MKPointAnnotation] = []
        
        restaurantList.forEach {
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: $0.latitude,
                longitude: $0.longitude
            )
            annotation.title = $0.name
            annotation.subtitle = "\($0.category) | \($0.price)원"
            
            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
        mapView.showAnnotations(annotations, animated: true)
    }
     
    @objc private func rightBarButtonTapped() {
        let alertController = UIAlertController(
            title: "메뉴 선택",
            message: "원하는 옵션을 선택하세요",
            preferredStyle: .actionSheet
        )
        
        let alert1Action = UIAlertAction(title: "한식", style: .default) { _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            var annotations: [MKPointAnnotation] = []
            
            self.restaurantList.filter { $0.category == "한식" }.forEach {
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = CLLocationCoordinate2D(
                    latitude: $0.latitude,
                    longitude: $0.longitude
                )
                annotation.title = $0.name
                annotation.subtitle = "\($0.category) | \($0.price)원"
                
                annotations.append(annotation)
            }
            self.mapView.addAnnotations(annotations)
            self.mapView.showAnnotations(annotations, animated: true)
        }
        
        let alert2Action = UIAlertAction(title: "카페", style: .default) { _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            var annotations: [MKPointAnnotation] = []
            
            self.restaurantList.filter { $0.category == "카페" }.forEach {
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = CLLocationCoordinate2D(
                    latitude: $0.latitude,
                    longitude: $0.longitude
                )
                annotation.title = $0.name
                annotation.subtitle = "\($0.category) | \($0.price)원"
                
                annotations.append(annotation)
            }
            self.mapView.addAnnotations(annotations)
            self.mapView.showAnnotations(annotations, animated: true)
        }
        
        let alert3Action = UIAlertAction(title: "중식", style: .default) { _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            var annotations: [MKPointAnnotation] = []
            
            self.restaurantList.filter { $0.category == "중식" }.forEach {
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = CLLocationCoordinate2D(
                    latitude: $0.latitude,
                    longitude: $0.longitude
                )
                annotation.title = $0.name
                annotation.subtitle = "\($0.category) | \($0.price)원"
                
                annotations.append(annotation)
            }
            self.mapView.addAnnotations(annotations)
            self.mapView.showAnnotations(annotations, animated: true)
        }
        
        let alert4Action = UIAlertAction(title: "분식", style: .default) { _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            var annotations: [MKPointAnnotation] = []
            
            self.restaurantList.filter { $0.category == "분식" }.forEach {
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = CLLocationCoordinate2D(
                    latitude: $0.latitude,
                    longitude: $0.longitude
                )
                annotation.title = $0.name
                annotation.subtitle = "\($0.category) | \($0.price)원"
                
                annotations.append(annotation)
            }
            self.mapView.addAnnotations(annotations)
            self.mapView.showAnnotations(annotations, animated: true)
        }
        
        let alert5Action = UIAlertAction(title: "일식", style: .default) { _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            var annotations: [MKPointAnnotation] = []
            
            self.restaurantList.filter { $0.category == "일식" }.forEach {
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = CLLocationCoordinate2D(
                    latitude: $0.latitude,
                    longitude: $0.longitude
                )
                annotation.title = $0.name
                annotation.subtitle = "\($0.category) | \($0.price)원"
                
                annotations.append(annotation)
            }
            self.mapView.addAnnotations(annotations)
            self.mapView.showAnnotations(annotations, animated: true)
        }
        
        let alert6Action = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            var annotations: [MKPointAnnotation] = []
            
            self.restaurantList.forEach {
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = CLLocationCoordinate2D(
                    latitude: $0.latitude,
                    longitude: $0.longitude
                )
                annotation.title = $0.name
                annotation.subtitle = "\($0.category) | \($0.price)원"
                
                annotations.append(annotation)
            }
            self.mapView.addAnnotations(annotations)
            self.mapView.showAnnotations(annotations, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소가 선택되었습니다.")
        }
        
        [
            alert1Action,
            alert2Action,
            alert3Action,
            alert4Action,
            alert5Action,
            alert6Action,
            cancelAction
        ].forEach(alertController.addAction)
         
        present(alertController, animated: true, completion: nil)
    }
}
 
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        print("어노테이션이 선택되었습니다.")
        print("제목: \(annotation.title ?? "제목 없음")")
        print("부제목: \(annotation.subtitle ?? "부제목 없음")")
        print("좌표: \(annotation.coordinate.latitude), \(annotation.coordinate.longitude)")
        
        // 선택된 어노테이션으로 지도 중심 이동
        let region = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("어노테이션 선택이 해제되었습니다.")
    }
}
