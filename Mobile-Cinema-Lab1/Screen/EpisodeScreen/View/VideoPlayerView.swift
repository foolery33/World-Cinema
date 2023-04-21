//
//  VideoPlayerView.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 12.04.2023.
//

import UIKit
import AVKit
import AVFoundation
import SnapKit

class VideoPlayerView: UIView {
    
    var filePath: String
    var startValue: Int
    var duration: Int
    var hideControlsTimer: Timer?
    
    init(filePath: String, startValue: Int, duration: Int, frame: CGRect) {
        self.filePath = filePath
        self.startValue = startValue
        self.duration = duration
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        setupVideoPlayerView()
    }
    
    // MARK: - VideoPlayer setup
    
    private lazy var videoPlayerView: UIView = {
        let myView = UIView(frame: self.frame)
        myView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(videoPlayerTapped)))
        myView.backgroundColor = .black
        return myView
    }()
    private func setupVideoPlayerView() {
        addSubview(videoPlayerView)
        setupVideoPlayer()
        videoPlayerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    lazy var videoPlayer: AVPlayer = {
        let asset = AVAsset(url: URL(string: self.filePath)!)
        let playerItem = AVPlayerItem(asset: asset)
        playerItem.addObserver(self, forKeyPath: #keyPath(AVPlayer.status), options: [.old, .new], context: nil)
        let player = AVPlayer(playerItem: playerItem)
        player.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), context: nil)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoPlayerView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        
        videoPlayerView.layer.addSublayer(playerLayer)
        return player
    }()
    private func setupVideoPlayer() {
        play()
        setupVideoPlayerControlsView()
    }
    // Обработка изменения состояния плеера
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status

            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }

            switch status {
            case .readyToPlay:
                print("Ready to play")
                
                // Контент готов к воспроизведению
            case .failed:
                print("Failed")
                // Произошла ошибка загрузки контента
            case .unknown:
                print("Unknown")
                // Состояние плеера неизвестно
            @unknown default:
                print("default")
//                fatalError()
                break
            }
        }
    }
    
    // MARK: - VideoPlayerControlsView setup
    
    private lazy var videoPlayerControlsView: UIView = {
        let myView = UIView()
        myView.backgroundColor = .clear
        return myView
    }()
    private func setupVideoPlayerControlsView() {
        videoPlayerView.addSubview(videoPlayerControlsView)
        setupPauseButton()
        setupTimeInfoStack()
        videoPlayerControlsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - PauseButton setup
    
    private lazy var pauseButton: UIButton = {
        let myButton = UIButton()
        myButton.setImage(R.image.pause()?.resizeImage(newWidth: 45, newHeight: 45), for: .normal)
        myButton.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        return myButton
    }()
    private func setupPauseButton() {
        videoPlayerControlsView.addSubview(pauseButton)
        pauseButton.addImagePressedEffect()
        pauseButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        // add observer for AVPlayerItemDidPlayToEndTime notification
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayer.currentItem)
    }
    
    @objc func playerDidFinishPlaying() {
        self.pauseButton.isHidden = false
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        if videoPlayer.timeControlStatus == .playing {
            pause()
        }
        else {
            play()
        }
    }
    @objc func videoPlayerTapped() {
        hideControlsTimer?.invalidate()
        hideControlsTimer = nil
        // Показываем кнопку паузы при нажатии на видеоплеер
        if(videoPlayer.timeControlStatus == .playing) {
            self.videoPlayerControlsView.isHidden.toggle()
            hideControlsTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { [weak self] _ in
                guard let self = self else { return }
                self.videoPlayerControlsView.isHidden = true
            })
        }
        else {
            print(self.videoPlayerControlsView.isHidden)
            self.videoPlayerControlsView.isHidden = !self.videoPlayerControlsView.isHidden
            hideControlsTimer?.invalidate()
            hideControlsTimer = nil
        }
    }
    
    func pause() {
        videoPlayer.pause()
        pauseButton.setImage(R.image.play(), for: .normal)
        // invalidate timer if exists
        hideControlsTimer?.invalidate()
        hideControlsTimer = nil
    }
    func play() {
        hideControlsTimer?.invalidate()
        videoPlayer.play()
        startTimer()
        pauseButton.setImage(R.image.pause()?.resizeImage(newWidth: 45, newHeight: 45), for: .normal)
        
        hideControls()
    }
    func hideControls() {
        // create timer to hide button after 5 seconds
        hideControlsTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { [weak self] _ in
            guard let self = self else { return }
            self.videoPlayerControlsView.isHidden = true
        })
    }
    
    // MARK: - TimeInfoStack setup
    
    private lazy var timeInfoStack: UIStackView = {
        let myStackView = UIStackView()
        myStackView.axis = .horizontal
        myStackView.spacing = 8
        return myStackView
    }()
    private func setupTimeInfoStack() {
        videoPlayerControlsView.addSubview(timeInfoStack)
        setupCurrentTimeLabel()
        setupVideoSlider()
        setupVideoTimeLabel()
        setupVolumeButton()
        timeInfoStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
    }
    
    // MARK: CurrentTimeLabel setup
    
    private lazy var currentTimeLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 1
        myLabel.text = "00:00"
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 10, weight: .regular)
        return myLabel
    }()
    private func setupCurrentTimeLabel() {
        timeInfoStack.addArrangedSubview(currentTimeLabel)
    }
    
    // MARK:  VideoTimer setup
    
    lazy var videoSlider: UISlider = {
        let mySlider = UISlider()
        mySlider.minimumValue = 0
        mySlider.maximumValue = Float(duration)
        mySlider.value = 0
        mySlider.tintColor = .redColor
        mySlider.setThumbImage(R.image.thumbImage(), for: .normal)
        mySlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        return mySlider
    }()
    private func setupVideoSlider() {
        timeInfoStack.addArrangedSubview(videoSlider)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        videoPlayer.seek(to: CMTime(seconds: Double(sender.value), preferredTimescale: 1000))
        self.currentTimeLabel.text = self.getTimeString(from: self.videoPlayer.currentTime().seconds)
    }
    
    // MARK: VideoTimeLabel setup
    
    private lazy var videoTimeLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.numberOfLines = 1
        myLabel.text = self.getTimeString(from: Double(self.duration))
        myLabel.textColor = .white
        myLabel.font = .systemFont(ofSize: 10, weight: .regular)
        return myLabel
    }()
    private func setupVideoTimeLabel() {
        timeInfoStack.addArrangedSubview(videoTimeLabel)
    }
    
    // MARK: VolumeButton setup
    
    private lazy var volumeButton: UIButton = {
        let myButton = UIButton()
        myButton.setImage(R.image.unmutedVolume(), for: .normal)
        myButton.setImage(R.image.mutedVolume(), for: .selected)
        myButton.addTarget(self, action: #selector(onVolumeButtonTapped), for: .touchUpInside)
        return myButton
    }()
    private func setupVolumeButton() {
        volumeButton.addImagePressedEffect()
        timeInfoStack.addArrangedSubview(volumeButton)
    }
    @objc private func onVolumeButtonTapped(_ sender: UIButton) {
        videoPlayer.isMuted.toggle()
        sender.isSelected.toggle()
    }
    
    var videoTimer: Timer?
    
    func startTimer() {
        videoTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            let currentTime = Float(self.videoPlayer.currentTime().seconds)
            self.currentTimeLabel.text = self.getTimeString(from: self.videoPlayer.currentTime().seconds)
            self.videoSlider.value = currentTime
            if(Int(currentTime) == self.duration) {
                self.pauseButton.setImage(R.image.play(), for: .normal)
            }
        }
    }
        
    func stopTimer() {
        videoTimer?.invalidate()
        videoTimer = nil
    }
    
    func getTimeString(from time: Double) -> String {
        var minutes = String(Int((time) / 60))
        if(minutes.count == 1) {
            minutes.insert("0", at: minutes.startIndex)
        }
        var seconds = String(Int(time) % 60)
        if (seconds.count == 1) {
            seconds.insert("0", at: seconds.startIndex)
        }
        return "\(minutes):\(seconds)"
    }
    
    func getCurrentVideoPlayerTime() -> Double {
        return videoPlayer.currentTime().seconds
    }
    
    deinit {
        print("observer removed")
        self.videoPlayer.currentItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        self.videoPlayer.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        NotificationCenter.default.removeObserver(self)
    }
    
}
