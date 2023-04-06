//
//  ViewController.swift
//  WeatherNow
//
//

import UIKit
import CoreLocation
import SkeletonView
import Lottie

class ViewController: UIViewController {
    // MARK: UI Element
    private let citylabel: UILabel = {
        let citylabel = UILabel()
        citylabel.textColor = .white
        citylabel.textAlignment = NSTextAlignment.center
        citylabel.font = .systemFont(ofSize: 40)
        citylabel.translatesAutoresizingMaskIntoConstraints = false
        citylabel.isSkeletonable = true
        return citylabel
    }()
    
    private let dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.textAlignment = NSTextAlignment.center
        dayLabel.textColor = .white
        dayLabel.font = .systemFont(ofSize: 25)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        return dayLabel
    }()
    
    private let uiView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.isSkeletonable = true
        return uiView
    }()
    
    private let weatherLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.textAlignment = NSTextAlignment.center
        weatherLabel.textColor = .white
        weatherLabel.font = .systemFont(ofSize: 20)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.isSkeletonable = true
        return weatherLabel
    } ()
    
    private let temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.textAlignment = NSTextAlignment.center
        temperatureLabel.textColor = .white
        temperatureLabel.font = .systemFont(ofSize: 90)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.isSkeletonable = true
        return temperatureLabel
    }()
    
    private let humidityIcon: UIImageView = {
        let humidityIcon = UIImageView()
        humidityIcon.contentMode = .scaleAspectFit
        humidityIcon.image = UIImage(named: "humidity")
        humidityIcon.translatesAutoresizingMaskIntoConstraints = false
        return humidityIcon
    }()
    
    private let humidityLabel: UILabel = {
        let humidityLabel = UILabel()
        humidityLabel.textAlignment = NSTextAlignment.center
        humidityLabel.textColor = .white
        humidityLabel.font = .systemFont(ofSize: 25)
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.isSkeletonable = true
        return humidityLabel
    }()
    
    private let maxTempImage: UIImageView = {
        let maxTempImage = UIImageView()
        maxTempImage.contentMode = .scaleAspectFit
        maxTempImage.image = UIImage(named: "MaxTemp")
        maxTempImage.translatesAutoresizingMaskIntoConstraints = false
        return maxTempImage
    } ()
    
    private let maxTempLabel: UILabel = {
        let maxTempLabel = UILabel()
        maxTempLabel.textAlignment = NSTextAlignment.center
        maxTempLabel.textColor = .white
        maxTempLabel.font = .systemFont(ofSize: 25)
        maxTempLabel.adjustsFontSizeToFitWidth = true
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.isSkeletonable = true
        return maxTempLabel
    }()
    
    private lazy var minTempImage: UIImageView = {
        let minTempImage = UIImageView()
        minTempImage.contentMode = .scaleAspectFit
        minTempImage.image = UIImage(named: "MinTemp")
        minTempImage.translatesAutoresizingMaskIntoConstraints = false
        return minTempImage
    } ()
    
    private let minTempLabel: UILabel = {
        let minTempLabel = UILabel()
        minTempLabel.textAlignment = NSTextAlignment.center
        minTempLabel.textColor = .white
        minTempLabel.font = .systemFont(ofSize: 25)
        minTempLabel.adjustsFontSizeToFitWidth = true
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempLabel.isSkeletonable = true
        return minTempLabel
    }()
    
    private var weatherGif: LottieAnimationView = {
        var weatherGif = LottieAnimationView()
        return weatherGif
    }()
    
    func weatherGifAnimation(weatherIcon: String) {
        weatherGif.clearsContextBeforeDrawing = true
        weatherGif = .init(name: weatherIcon)
        weatherGif.center = view.center
        weatherGif.contentMode = .scaleAspectFit
        weatherGif.loopMode = .loop
        weatherGif.animationSpeed = 1.0
        weatherGif.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherGif)
        weatherGif.play()
        
        NSLayoutConstraint.activate([
            weatherGif.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 24),
            weatherGif.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherGif.widthAnchor.constraint(equalToConstant: 250),
            weatherGif.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    /// Open Weather Key
    let apiKey = Key.apiKey
    
    /// Get user location
    let locationManager = CLLocationManager()
    /// API call
    let service = Services()
    /// Background image
    let backgroundImage = BackgroundImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Display gradient layer on screen
        view.layer.addSublayer(backgroundImage.gradientLayer)
        view.addSubview(citylabel)
        view.addSubview(dayLabel)
        view.addSubview(uiView)
        view.addSubview(weatherLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(humidityIcon)
        view.addSubview(humidityLabel)
        view.addSubview(maxTempImage)
        view.addSubview(minTempLabel)
        view.addSubview(minTempImage)
        view.addSubview(maxTempLabel)
        
        setUpConstraints()
        initializeLocationServices()
        
        /// Get today's day
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        self.dayLabel.text = dateFormatter.string(from: currentDate)
    }
    
    /// Background color set up
    override func viewWillAppear(_ animated: Bool) {
        backgroundImage.setBuleGradientBackground()
    }
    
    // MARK: show skeleton animation
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        labelSkeletonAnimate(element: citylabel)
        viewSkeletonAnimate(element: uiView)
        labelSkeletonAnimate(element: weatherLabel)
        labelSkeletonAnimate(element: temperatureLabel)
        labelSkeletonAnimate(element: humidityLabel)
        labelSkeletonAnimate(element: minTempLabel)
        labelSkeletonAnimate(element: maxTempLabel)
    }
    
    // MARK: skeleton animation functions
    func labelSkeletonAnimate(element: UILabel) {
        element.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete),
                                             animation: nil,
                                             transition: .crossDissolve(0.2))
    }
    
    func viewSkeletonAnimate(element: UIView) {
        element.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .concrete),
                                             animation: nil,
                                             transition: .crossDissolve(0.2))
    }
    
    // MARK: - Constratins
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            citylabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            citylabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            citylabel.widthAnchor.constraint(equalToConstant: 400),
            citylabel.heightAnchor.constraint(equalToConstant: 50),
            
            dayLabel.topAnchor.constraint(equalTo: citylabel.bottomAnchor, constant: 24),
            dayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dayLabel.widthAnchor.constraint(equalToConstant: 300),
            dayLabel.heightAnchor.constraint(equalToConstant: 40),
            
            uiView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 24),
            uiView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiView.widthAnchor.constraint(equalToConstant: 250),
            uiView.heightAnchor.constraint(equalToConstant: 250),
            
            weatherLabel.topAnchor.constraint(equalTo: uiView.bottomAnchor, constant: 24),
            weatherLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherLabel.widthAnchor.constraint(equalToConstant: 250),
            weatherLabel.heightAnchor.constraint(equalToConstant: 40),
            
            temperatureLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 24),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 250),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 100),
            
            humidityIcon.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 24),
            humidityIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            humidityIcon.widthAnchor.constraint(equalToConstant: 30),
            humidityIcon.heightAnchor.constraint(equalToConstant: 30),

            humidityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 24),
            humidityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 30),
            humidityLabel.widthAnchor.constraint(equalToConstant: 100),
            
            maxTempImage.topAnchor.constraint(equalTo: humidityIcon.bottomAnchor, constant: 45),
            maxTempImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -110),
            maxTempImage.widthAnchor.constraint(equalToConstant: 35),
            maxTempImage.heightAnchor.constraint(equalToConstant: 35),
            
            maxTempLabel.topAnchor.constraint(equalTo: humidityIcon.bottomAnchor, constant: 47),
            maxTempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            maxTempLabel.widthAnchor.constraint(equalToConstant: 100),

            minTempImage.topAnchor.constraint(equalTo: humidityIcon.bottomAnchor, constant: 45),
            minTempImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 30),
            minTempImage.widthAnchor.constraint(equalToConstant: 35),
            minTempImage.heightAnchor.constraint(equalToConstant: 35),
            
            minTempLabel.topAnchor.constraint(equalTo: humidityIcon.bottomAnchor, constant: 47),
            minTempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            minTempLabel.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}

extension ViewController: CLLocationManagerDelegate {
    private func initializeLocationServices() {
        locationManager.delegate = self
        
        DispatchQueue.global().async {
            guard CLLocationManager.locationServicesEnabled() else {
                return
            }
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            Alert.showLocationRestrictedAlert(on: self)
        case .denied:
            Alert.showLocationDeniedAlert(on: self)
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            return
        }
    }
    
    // MARK: set current location, get API data and display on screen
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        // Get API Data from Open Weather
        service.getData(lat: latitude, lon: longitude, apiKey: apiKey) {
            (currentWeather) in
            
            DispatchQueue.main.async {
                let currentWeather = currentWeather
                
                guard let iconName = currentWeather.weather[0].weatherIcon,
                      let temperature = currentWeather.main.temp,
                      let humidity = currentWeather.main.humidity,
                      let minTemp = currentWeather.main.tempMin,
                      let maxTemp = currentWeather.main.tempMax else {
                    return
                }
                
                self.citylabel.stopSkeletonAnimation()
                self.citylabel.hideSkeleton()
                let cityName = currentWeather.name
                self.citylabel.text = "\(cityName.capitalized)"
                
                self.weatherLabel.stopSkeletonAnimation()
                self.weatherLabel.hideSkeleton()
                let weatherName = currentWeather.weather[0].weatherDescription ?? "--"
                self.weatherLabel.text = "\(weatherName.capitalized)"
                
                self.uiView.stopSkeletonAnimation()
                self.uiView.hideSkeleton()
                self.weatherGif.removeFromSuperview()
                self.weatherGifAnimation(weatherIcon: iconName)
                
                self.temperatureLabel.stopSkeletonAnimation()
                self.temperatureLabel.hideSkeleton()
                self.temperatureLabel.text = "\(Int(round(temperature))) ℃"
                
                self.humidityLabel.stopSkeletonAnimation()
                self.humidityLabel.hideSkeleton()
                self.humidityLabel.text = "\(Int(round(humidity))) ％"
                
                self.minTempLabel.stopSkeletonAnimation()
                self.minTempLabel.hideSkeleton()
                self.minTempLabel.text = " \(Int(round(minTemp))) ℃"
                
                self.maxTempLabel.stopSkeletonAnimation()
                self.maxTempLabel.hideSkeleton()
                self.maxTempLabel.text = "\(Int(round(maxTemp))) ℃"
                
                /// Set day and night background colour
                let dayNight = iconName.suffix(1)
                if dayNight == "n" {
                    self.backgroundImage.setGreyGradientBackground()
                } else {
                    self.backgroundImage.setBuleGradientBackground()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Alert.showLocationErrorAlert(on: self)
    }
}


