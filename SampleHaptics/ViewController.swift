//
//  ViewController.swift
//  SampleHaptics
//
//  Created by Dylan Sewell on 11/12/19.
//  Copyright © 2019 Dylan Sewell. All rights reserved.
//

import UIKit

enum FeedbackGeneratorType: Int {
    case notificationError
    case notificationSuccess
    case notificationWarning
    case impactLight
    case impactMedium
    case impactHeavy
    case selectionChanged
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    var hapticOptions: [FeedbackGeneratorType] = [.notificationError, .notificationSuccess, .notificationWarning, .impactLight, .impactMedium, .impactHeavy, .selectionChanged]
    var currentSelection: FeedbackGeneratorType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        currentSelection = hapticOptions.first
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        let feedbackType = hapticOptions[pickerView.selectedRow(inComponent: 0)]
        DispatchQueue.main.async {
            self.performHapticForSelectedFeedback(type: feedbackType)
        }
    }
    
    func performHapticForSelectedFeedback(type: FeedbackGeneratorType) {
        switch type {
        case .notificationError:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        case .notificationSuccess:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case .notificationWarning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        case .impactLight:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        case .impactMedium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        case .impactHeavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        case .selectionChanged:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hapticOptions.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let feedbackType = hapticOptions[row]
        return getStringForFeedback(type: feedbackType)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelection = hapticOptions[row]
    }
    
    func getStringForFeedback(type: FeedbackGeneratorType) -> String {
        switch type {
        case .notificationError:
            return "Notification Error"
        case .notificationSuccess:
            return "Notification Success"
        case .notificationWarning:
            return "Notification Warning"
        case .impactLight:
            return "Impact Light"
        case .impactMedium:
            return "Impact Medium"
        case .impactHeavy:
            return "Impact Heavy"
        case .selectionChanged:
            return "Selection Changed"
        }
    }
}

