//
//  TaskCell.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//

import UIKit
import SnapKit

class TaskCell: UITableViewCell {
    
    var presenter: TaskPresenterProtocol?
    let swipeGesture = UISwipeGestureRecognizer()
    let tapGesture = UITapGestureRecognizer()
    var model: TaskModel?
    
    private var conteinerCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "customGray")
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    private var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(named: "yellowCustom")
        view.font = .systemFont(ofSize: 20,
                                weight: .bold)
        view.textAlignment = .left
        return view
     }()
    private var descriptionTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .white
        view.font = .systemFont(ofSize: 14,
                                weight: .semibold)
        view.textAlignment = .left
        view.numberOfLines = 0
        return view
     }()
    private var dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 16,
                                weight: .semibold)
        view.textAlignment = .left
        return view
     }()
    private var statusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 24/2
        return view
    }()
    var removeButton: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "customGray")
        view.layer.cornerRadius = 12
        return view
    }()
    private var removeImage: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.image = UIImage(systemName: "trash.fill")
        view.tintColor = .lightText
        return view
    }()
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .lightGray
        backgroundColor = .lightGray
        addSubview()
        сreatedConstraints()
        removeButton.addTarget(self,
                               action: #selector(removeCell),
                               for: .touchUpInside)
        conteinerCell.addGestureRecognizer(swipeGesture)
        swipeGesture.addTarget(self,
                               action: #selector(show))
        swipeGesture.direction = .left
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureData(_ model: TaskModel) {
        if model.completed == true {
            statusView.backgroundColor = .systemGreen
        } else {
            statusView.backgroundColor = .systemRed
        }
        nameLabel.text = model.todoName
        dateLabel.text = model.dateOfCreation
        descriptionTitle.text = model.todoDescription
    }
    @objc func removeCell() {
        presenter?.remove(Int(model?.id ?? 0))
        hide()
    }
    @objc func show(_ swipe: UISwipeGestureRecognizer) {
        removeButton.isHidden = false
        conteinerCell.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self,
                             action: #selector(hide))
        conteinerCell.snp.updateConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(-60)
            make.height.equalTo(100)
        }
    }
    @objc func hide() {
        removeButton.isHidden = true
        conteinerCell.removeGestureRecognizer(tapGesture)
        conteinerCell.snp.updateConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(100)
        }
    }
}
private extension TaskCell {
    func addSubview() {
        contentView.addSubview(conteinerCell)
        conteinerCell.addSubview(nameLabel)
        conteinerCell.addSubview(dateLabel)
        conteinerCell.addSubview(statusView)
        conteinerCell.addSubview(descriptionTitle)
        contentView.addSubview(removeButton)
        removeButton.addSubview(removeImage)
        removeButton.isHidden = true
    }
    func сreatedConstraints() {
        conteinerCell.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.height.equalTo(100)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.left.equalTo(15)
            make.width.equalToSuperview().inset(30)
            make.height.equalTo(20)
        }
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.right.equalTo(-15)
            make.width.greaterThanOrEqualTo(80)
            make.height.equalTo(16)
        }
        descriptionTitle.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(15)
            make.right.equalTo(dateLabel.snp.left).inset(-15)
            make.bottom.equalToSuperview().inset(10)
        }
        statusView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.right.equalTo(-15)
            make.width.height.equalTo(24)
        }
        removeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(100)
            make.left.equalTo(conteinerCell.snp.right).inset(-15)
        }
        removeImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
}
