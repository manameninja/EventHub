//
//  OnboardingViewController.swift
//  EventHub
//
//  Created by Даниил Павленко on 17.11.2024.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    //    MARK: - UI Elements
    private let bottomView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(hexString: "#5669FF", alpha: 1)
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.cornerRadius = 48
        return $0
    }(UIView())
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { _ in
            self.nextPage(button)
        }   , for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addAction(UIAction { _ in
            self.nextPage(button)
        }   , for: .touchUpInside)
        return button
    }()
    
    private var stackViewH: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private var mainTitle: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.text = "Explore Upcoming and Nearby Events"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private var subTitle: UILabel = {
        $0.text = "In publishing and graphic design, Lorem is a placeholder text commonly"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private var stackViewV: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private let pageControl: UIPageControl = {
        $0.isUserInteractionEnabled = false
        return $0
    }(UIPageControl())
    
    //    MARK: - Variables
    var helperArray = [OnboardingHelper()]
    var pages = [UIViewController]()
    let initialPage = 0
    
    //    MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        dataSource = self
        delegate = self
        setupUI()
    }
    
    //    MARK: - Setup UI
    private func setupUI() {
        setup()
        view.addSubview(bottomView)
        bottomView.addSubview(stackViewV)
        stackViewV.addArrangedSubview(mainTitle)
        stackViewV.addArrangedSubview(subTitle)
        stackViewV.addArrangedSubview(stackViewH)
        stackViewH.addArrangedSubview(skipButton)
        stackViewH.addArrangedSubview(pageControl)
        stackViewH.addArrangedSubview(nextButton)
        SetupConstraints()
        style()
        animateBottomViewAppearance()
    }
    
    //    MARK: - SetupConstraints
    private func SetupConstraints() {
        
        bottomView.transform = CGAffineTransform(translationX: 0, y: 200)
        NSLayoutConstraint.activate([
            
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            stackViewV.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20),
            stackViewV.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20),
            stackViewV.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.85),
            stackViewV.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor)
        ])
    }
    
    //    MARK: - Methods
    
    private func animateBottomViewAppearance() {
        UIView.animate(withDuration: 1) {
            self.bottomView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    private func nextPage(_ sender: UIButton) {
        if sender == skipButton {
            navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        
        guard let currentVC = viewControllers?.first,
              let currentIndex = pages.firstIndex(of: currentVC) else { return }
        
        let nextIndex = currentIndex + 1
        
        if nextIndex < pages.count {
            setViewControllers([pages[nextIndex]], direction: .forward, animated: true)
            pageControl.currentPage = nextIndex
            mainTitle.text = helperArray[nextIndex].mainTitle
            subTitle.text = helperArray[nextIndex].subTitle
        } else {
            navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }
}

//MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func setup() {
        let firstScreen = OnboardingHelper(
            image: UIImage(
                resource: .onbordingFirst
            ),
            mainTitle: "Explore Upcoming and Nearby Events",
            subTitle: "Use the search, categories and filters to clarify the events you need"
        )
        let secondScreen = OnboardingHelper(
            image: UIImage(
                resource: .onbordingSecond
            ),
            mainTitle: "Web Have Modern Events Calendar Feature",
            subTitle: "Use the calendar to see upcoming or past events"
        )
        let thirdScreen = OnboardingHelper(
            image: UIImage(
                resource: .onbordingThird
            ),
            mainTitle: "To Look Up More Events or Activities Nearby By Map",
            subTitle: "Use the map to find events in the location you need"
        )
        helperArray = [firstScreen, secondScreen, thirdScreen]
        
        helperArray.forEach { helper in
            pages.append(ScreenViewController(with: helper))
        }
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
    
    func style() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewsControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewsControllers[0]) else { return }
        pageControl.currentPage = currentIndex
        mainTitle.text = helperArray[currentIndex].mainTitle
        subTitle.text = helperArray[currentIndex].subTitle
    }
}
