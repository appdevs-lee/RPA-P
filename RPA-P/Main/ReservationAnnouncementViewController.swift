//
//  ReservationAnnouncementViewController.swift
//  RPA-P
//
//  Created by 이주성 on 7/18/24.
//

import UIKit

final class ReservationAnnouncementViewController: UIViewController {
    
    lazy var reservationConfirmationLabel: UILabel = {
        let label = UILabel()
        label.text = "예약이 확정되었습니다"
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var timerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var priceAnnouncementBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 255, green: 248, blue: 248)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.deposit.withCommaString ?? "0") 원"
        label.textColor = .useRGB(red: 184, green: 0, blue: 0)
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.asFontColor(targetString: "원", font: .useFont(ofSize: 14, weight: .Regular), color: .useRGB(red: 184, green: 0, blue: 0))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var announcementLabel: UILabel = {
        let label = UILabel()
        label.text = "계약금은 전체 금액의 8%입니다.\n제한 시간 내 입금되어야 운행이 가능합니다."
        label.textColor = .useRGB(red: 115, green: 115, blue: 115)
        label.font = .useFont(ofSize: 11, weight: .Medium)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.asFontColor(targetString: "제한 시간 내 입금되어야 운행이 가능합니다.", font: .useFont(ofSize: 11, weight: .Regular), color: .useRGB(red: 184, green: 0, blue: 0))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var accountView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 238, green: 238, blue: 238)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var accountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "성화투어 계좌번호"
        label.textColor = .useRGB(red: 138, green: 138, blue: 138)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "기업은행 331-011771-01-011"
        label.textColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var accountLabelBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.87)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인했습니다.", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(checkButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var circularProgress: CircularProgress = {
        let view = CircularProgress()
        view.backgroundColor = .clear
        view.progressLineWidth = 5
        view.progressLineColor = .useRGB(red: 255, green: 115, blue: 115)
        view.trackLineWidth = 5
        view.trackColor = .white
        view.setProgress(value: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var timerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("timerImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var leftTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "72:00:00"
        label.textColor = .black
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init(deposit: Double) {
        self.deposit = Int(deposit)
        
        super.init(nibName: nil , bundle: nil)
        
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var deposit: Int
    var timer: Timer?
    var timerNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
        self.startTimer()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- ReservationAnnouncementViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension ReservationAnnouncementViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .white
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        let accountGesture = UITapGestureRecognizer(target: self, action: #selector(copyAccount(_:)))
        self.accountLabel.addGestureRecognizer(accountGesture)
        self.accountLabel.isUserInteractionEnabled = true
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.reservationConfirmationLabel,
            self.timerView,
            self.priceAnnouncementBaseView,
            self.checkButton,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.circularProgress,
            self.timerImageView,
            self.leftTimeLabel,
        ], to: self.timerView)
        
        SupportingMethods.shared.addSubviews([
            self.priceLabel,
            self.announcementLabel,
            self.accountView,
        ], to: self.priceAnnouncementBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.accountTitleLabel,
            self.accountLabel,
            self.accountLabelBorderView,
        ], to: self.accountView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // reservationConfirmationLabel
        NSLayoutConstraint.activate([
            self.reservationConfirmationLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.reservationConfirmationLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 26),
        ])
        
        // timerView
        NSLayoutConstraint.activate([
            self.timerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.timerView.topAnchor.constraint(equalTo: self.reservationConfirmationLabel.bottomAnchor, constant: 34),
            self.timerView.widthAnchor.constraint(equalToConstant: 112),
            self.timerView.heightAnchor.constraint(equalToConstant: 140),
        ])
        
        // circularProgress
        NSLayoutConstraint.activate([
            self.circularProgress.widthAnchor.constraint(equalToConstant: 102),
            self.circularProgress.heightAnchor.constraint(equalToConstant: 102),
            self.circularProgress.centerXAnchor.constraint(equalTo: self.timerView.centerXAnchor),
            self.circularProgress.centerYAnchor.constraint(equalTo: self.timerView.centerYAnchor),
        ])
        
        // timerImageView
        NSLayoutConstraint.activate([
            self.timerImageView.centerXAnchor.constraint(equalTo: self.circularProgress.centerXAnchor),
            self.timerImageView.centerYAnchor.constraint(equalTo: self.circularProgress.centerYAnchor),
            self.timerImageView.widthAnchor.constraint(equalToConstant: 63),
            self.timerImageView.heightAnchor.constraint(equalToConstant: 63),
        ])
        
        // leftTimeLabel
        NSLayoutConstraint.activate([
            self.leftTimeLabel.topAnchor.constraint(equalTo: self.circularProgress.bottomAnchor, constant: 5),
            self.leftTimeLabel.centerXAnchor.constraint(equalTo: self.timerView.centerXAnchor),
            self.leftTimeLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // priceAnnouncementBaseView
        NSLayoutConstraint.activate([
            self.priceAnnouncementBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 17),
            self.priceAnnouncementBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -17),
            self.priceAnnouncementBaseView.topAnchor.constraint(equalTo: self.timerView.bottomAnchor, constant: 34),
        ])
        
        // priceLabel
        NSLayoutConstraint.activate([
            self.priceLabel.topAnchor.constraint(equalTo: self.priceAnnouncementBaseView.topAnchor, constant: 33),
            self.priceLabel.centerXAnchor.constraint(equalTo: self.priceAnnouncementBaseView.centerXAnchor),
        ])
        
        // announcementLabel
        NSLayoutConstraint.activate([
            self.announcementLabel.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 5),
            self.announcementLabel.centerXAnchor.constraint(equalTo: self.priceAnnouncementBaseView.centerXAnchor),
        ])
        
        // accountView
        NSLayoutConstraint.activate([
            self.accountView.leadingAnchor.constraint(equalTo: self.priceAnnouncementBaseView.leadingAnchor, constant: 15),
            self.accountView.trailingAnchor.constraint(equalTo: self.priceAnnouncementBaseView.trailingAnchor, constant: -15),
            self.accountView.topAnchor.constraint(equalTo: self.announcementLabel.bottomAnchor, constant: 27),
            self.accountView.bottomAnchor.constraint(equalTo: self.priceAnnouncementBaseView.bottomAnchor, constant: -15),
        ])
        
        // accountTitleLabel
        NSLayoutConstraint.activate([
            self.accountTitleLabel.topAnchor.constraint(equalTo: self.accountView.topAnchor, constant: 17),
            self.accountTitleLabel.centerXAnchor.constraint(equalTo: self.accountView.centerXAnchor),
        ])
        
        // accountLabel
        NSLayoutConstraint.activate([
            self.accountLabel.topAnchor.constraint(equalTo: self.accountTitleLabel.bottomAnchor, constant: 8),
            self.accountLabel.centerXAnchor.constraint(equalTo: self.accountTitleLabel.centerXAnchor),
            self.accountLabel.bottomAnchor.constraint(equalTo: self.accountView.bottomAnchor, constant: -16),
        ])
        
        // accountLabelBorderView
        NSLayoutConstraint.activate([
            self.accountLabelBorderView.leadingAnchor.constraint(equalTo: self.accountLabel.leadingAnchor),
            self.accountLabelBorderView.trailingAnchor.constraint(equalTo: self.accountLabel.trailingAnchor),
            self.accountLabelBorderView.topAnchor.constraint(equalTo: self.accountLabel.bottomAnchor, constant: 1.0),
            self.accountLabelBorderView.heightAnchor.constraint(equalToConstant: 1)
            
        ])
        
        // checkButton
        NSLayoutConstraint.activate([
            self.checkButton.widthAnchor.constraint(equalToConstant: 200),
            self.checkButton.heightAnchor.constraint(equalToConstant: 48),
            self.checkButton.topAnchor.constraint(equalTo: self.priceAnnouncementBaseView.bottomAnchor, constant: 50),
            self.checkButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension ReservationAnnouncementViewController {
    func setTimer() {
        
    }
    
    func startTimer() {
        //기존에 타이머 동작중이면 중지 처리
        if timer != nil && timer!.isValid {
            timer!.invalidate()
        }
     
        //타이머 사용값 초기화
        timerNum = 259200
        //1초 간격 타이머 시작
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
        self.circularProgress.setProgressWithAnimation(duration: 259200, fromValue: 1.0, toVlaue: 0.0)
    }
}

// MARK: - Extension for selector methods
extension ReservationAnnouncementViewController {
    @objc func checkButton(_ sender: UIButton) {
        self.dismiss(animated: true) {
            if self.timer != nil && self.timer!.isValid {
                self.timer!.invalidate()
                
            }
            
        }
        
    }
    
    @objc func copyAccount(_ gesture: UITapGestureRecognizer) {
        UIPasteboard.general.string = self.accountLabel.text
        guard let storedString = UIPasteboard.general.string else { return }
        SupportingMethods.shared.showAlertNoti(title: "\(storedString) 복사되었습니다.")
    }
    
    //타이머 동작 func
    @objc func timerCallback() {
        let hour = self.timerNum / 3600
        let minute = self.timerNum % 3600 / 60
        let second = self.timerNum % 3600 % 60 % 60
        self.leftTimeLabel.text = "\(hour < 10 ? "0\(hour)" : "\(hour)"):\(minute < 10 ? "0\(minute)" : "\(minute)"):\(second < 10 ? "0\(second)" : "\(second)")"
     
        //timerNum이 0이면(60초 경과) 타이머 종료
        if(self.timerNum == 0) {
            self.timer?.invalidate()
            self.timer = nil
            
            //타이머 종료 후 처리...
        }
     
        //timerNum -1 감소시키기
        self.timerNum -= 1
    }
}
