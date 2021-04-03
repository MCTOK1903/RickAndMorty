//
//  FilterViewController.swift
//  RickAndMorty
//
//  Created by Celal Tok on 1.04.2021.
//

import UIKit

class FilterViewController: UIViewController {

    // MARK: View
    
    let modalview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.tintColor = UIColor.black
        return picker
    }()
    
    private let hStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        sv.spacing = 4
        sv.axis = .horizontal
        return sv
    }()
    
    let filterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Filter", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(filterTapped), for: .touchUpInside)
        return button
    }()
    
    let clearButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.setTitle("Clear", for: .normal)
        button.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: Properties
    
    private var hasSetPointOrigin = false
    private var pointOrigin: CGPoint?
    private let source: [CharacterStatus] = [.alive, .dead, .unknown]
    private var selectedStatus: CharacterStatus = .alive
    
    // MARK: init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismiss(animated: true, completion: nil)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        
        view.addGestureRecognizer(panGesture)
        view.addSubview(modalview)
        modalview.addSubview(picker)
        modalview.addSubview(hStack)
        
        hStack.addArrangedSubview(clearButton)
        hStack.addArrangedSubview(filterButton)
        
        picker.delegate = self
        picker.dataSource = self
        
        setContraint()
        setLayer()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    // MARK: Funcs
    
    func setContraint() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            modalview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            modalview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            modalview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            modalview.heightAnchor.constraint(equalToConstant: view.frame.height * 0.3),
            
            picker.leadingAnchor.constraint(equalTo: modalview.leadingAnchor, constant: padding * 4),
            picker.trailingAnchor.constraint(equalTo: modalview.trailingAnchor, constant: -padding * 4),
            picker.bottomAnchor.constraint(equalTo: modalview.bottomAnchor,constant: -view.frame.height * 0.01),
            
            hStack.topAnchor.constraint(equalTo: modalview.topAnchor, constant: padding * 2),
            hStack.leadingAnchor.constraint(equalTo: modalview.leadingAnchor, constant: padding * 2),
            hStack.trailingAnchor.constraint(equalTo: modalview.trailingAnchor, constant: -padding * 2),
            
            clearButton.topAnchor.constraint(equalTo: hStack.topAnchor),
            clearButton.leadingAnchor.constraint(equalTo: hStack.leadingAnchor),
            
            filterButton.leadingAnchor.constraint(equalTo: clearButton.trailingAnchor),
            filterButton.topAnchor.constraint(equalTo: hStack.topAnchor),
        ])
    }
    
    func setLayer() {
        modalview.layer.cornerRadius = 14
        modalview.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @objc func filterTapped() {
        self.dismiss(animated: true) {
            var dict: [String: Any] = [:]
            dict[Constant.UserSessionConstant.selectedStatus] = self.selectedStatus
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constant.NotificationCenterConsant.getFilteredCharacter),object: nil, userInfo: dict)
        }
    }
    
    @objc func clearTapped() {
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constant.NotificationCenterConsant.filterClear),object: nil)
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        guard translation.y >= 0 else { return }
        
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return source.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return source[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedStatus = source[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: source[row].rawValue, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
}
