//
//  BackgroundImage.swift
//  WeatherNow
//
//

import Foundation
import UIKit

class BackgroundImage: UIViewController {
    
    let gradientLayer = CAGradientLayer()
    
    // Weather icon start with d
    func setDefaultGradientBackground() {
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    // Weather icon 01d, 02d
    func setSunRaiseGradientBackground() {
        let topColor = UIColor(red: 1.0, green: 165.0/255.0, blue: 69.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        /// Create a new point that is offset from the top left corner
        let startPoint = CGPoint(x: 0.6, y: -0.2)
        /// Set the endPoint to the bottom right corner (default)
        let endPoint = CGPoint(x: 1, y: 1)
        
        /// Set the startPoint and endPoint properties of the gradientLayer
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    // Weather icon 01d, 02d
    func setSunSetGradientBackground() {
        let topColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 1.0, green: 165.0/255.0, blue: 69.0/255.0, alpha: 1.0).cgColor
        /// Create a new point that is offset from the top left corner
        let startPoint = CGPoint(x: 0.8, y: 0.4)
        /// Set the endPoint to the bottom right corner (default)
        let endPoint = CGPoint(x: 1, y: 1)
        
        /// Set the startPoint and endPoint properties of the gradientLayer
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    // Weather icon end with n
    func setNightGradientBackground() {
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    // Weather icon 03d, 04d, 10d, 11d, 13d
    func setRainGradientBackground() {
        let topColor = UIColor(red: 180.8/255.0, green: 180.8/255.0, blue: 180.8/255.0, alpha: 1.0).cgColor
        let middleColor = UIColor(red: 166.5/255.0, green: 166.5/255.0, blue: 166.5/255.0, alpha: 0.8).cgColor
        let bottomColor = UIColor(red: 160.8/255.0, green: 160.8/255.0, blue: 160.8/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, middleColor, bottomColor]
    }
    
    // Weather icon 50d
    func setMistGradientBackground() {
        let topColor = UIColor(red: 226.0/255.0, green: 226.0/255.0, blue: 226.0/255.0, alpha: 1.0).cgColor
        let middleColor = UIColor(red: 149.85/255.0, green: 149.85/255.0, blue: 149.85/255.0, alpha: 0.8).cgColor
        let bottomColor = UIColor(red: 201.0/255.0, green: 201.0/255.0, blue: 201.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, middleColor, bottomColor]
    }
}
