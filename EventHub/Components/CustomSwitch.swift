//
//  CustomSwitcher.swift
//  EventHub
//
//  Created by nikita on 28.11.24.
//

import UIKit

protocol CustomSwitchDelegate: AnyObject {
    func switchDidToggle()
}

final class CustomSwitch: UIControl {
    private let leftText: String
    private let selectedSideColor: UIColor
    private let rightText: String
    private let unselectedSideColor: UIColor
    private let colorForBackground: UIColor
    private let colorForThumb: UIColor
    private let thumbShadowColor: UIColor
    
    private let thumbView: UIView = {
        let thumbView = UIView()
        return thumbView
    }()
    
    private let leftLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let rightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    private(set) var isLeft = true
    
    weak var delegate: CustomSwitchDelegate?
    
    init(
        frame: CGRect,
        leftText: String,
        rightText: String,
        selectedSideColor: UIColor,
        unselectedSideColor: UIColor,
        colorForBackground: UIColor,
        colorForThumb: UIColor,
        thumbShadowColor: UIColor
    ) {
        self.leftText = leftText
        self.rightText = rightText
        self.colorForBackground = colorForBackground
        self.colorForThumb = colorForThumb
        self.thumbShadowColor = thumbShadowColor
        self.selectedSideColor = selectedSideColor
        self.unselectedSideColor = unselectedSideColor
        
        super.init(frame: frame)
        
        setupUI()
        setupConstrainst()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
        thumbView.layer.cornerRadius = self.frame.height / 2 - 5
    }
    
    @objc func toggleSwitch() {
        isLeft.toggle()
        
        delegate?.switchDidToggle()
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            thumbView.frame.origin.x = isLeft ? 5 : thumbView.frame.width + 5
            leftLabel.textColor = isLeft ? selectedSideColor : unselectedSideColor
            rightLabel.textColor = isLeft ? unselectedSideColor : selectedSideColor
        }
    }
}

private extension CustomSwitch {
    func setupUI() {
        leftLabel.text = leftText
        rightLabel.text = rightText
        backgroundColor = colorForBackground
        thumbView.backgroundColor = colorForThumb
        
        [
            thumbView,
            leftLabel,
            rightLabel
        ].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subView)
        }
        
        thumbView.layer.shadowColor = thumbShadowColor.cgColor
        thumbView.layer.shadowOffset = CGSize(width: 0, height: 5)
        thumbView.layer.shadowRadius = 20
        thumbView.layer.shadowOpacity = 1
        thumbView.layer.masksToBounds = false
        
        leftLabel.textColor = selectedSideColor
        rightLabel.textColor = unselectedSideColor
    }
    
    func setupConstrainst() {
        NSLayoutConstraint.activate([
            leftLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            leftLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -10),
            
            rightLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 10),
            rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            thumbView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            thumbView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            thumbView.trailingAnchor.constraint(equalTo: centerXAnchor),
            thumbView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    func setupTargets() {
        self.addTarget(self, action: #selector(toggleSwitch), for: .touchUpInside)
    }
}
