//
//  TaskBaseController.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//

import UIKit
import SnapKit

class TaskBaseController: UIViewController {
    
    var presenter: TaskPresenterProtocol?
    private let viewRecognizer = UITapGestureRecognizer()
    private let swipeRecognizer = UISwipeGestureRecognizer()
    private var indicator = UIActivityIndicatorView()
    var markedDates: Set<Date> = []
    private var defaults = UserDefaults.standard
    var today = String()
    var views: [UIView] = []
    var model: [TaskModel]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var headerTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 30,
                                 weight: .bold)
        view.textColor = .white
        view.textAlignment = .left
        return view
    }()
    private var emptyTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 24,
                                 weight: .bold)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    private var calendarLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16,
                                weight: .bold)
        view.textColor = .white
        view.textAlignment = .right
        return view
    }()
    private var calendarButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = UIColor(named: "yellowCustom")
        return view
    }()
    private var firstStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        return view
    }()
    private var secondStakView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "customGray")
        view.axis = .vertical
        view.layer.cornerRadius = 20
        return view
    }()
   private var calendarView: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       view.layer.cornerRadius = 10
       view.backgroundColor = UIColor(named: "customGray")
        return view
    }()
    private lazy var calendar: UICalendarView = {
       let view = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "customGray")
        view.isUserInteractionEnabled = true
        view.tintColor = UIColor(named: "yellowCustom")
        view.layer.cornerRadius = 20
        return view
    }()
    private var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        view.rowHeight = 110
        view.separatorColor = .clear
        view.showsVerticalScrollIndicator = false
        view.register(TaskCell.self,
                           forCellReuseIdentifier: "task")
        return view
    }()
    private var addButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "yellowCustom")
        view.titleLabel?.font = .systemFont(ofSize: 14,
                                            weight: .bold)
        view.setTitleColor(UIColor(named: "customGray"),
                           for: .normal)
        view.setTitle("New",
                      for: .normal)
        view.layer.cornerRadius = 70/2
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: "customGray")?.cgColor
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: "customGray")
        setupeSubview()
        addConstraints()
        setupeButton()
        setupeData()
        presenter?.viewDidLoad()
    }
    private func setupeData() {
        indicator.startAnimating()
        emptyTitle.text = "Сreate your first task"
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendar.calendar = gregorianCalendar
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendar.selectionBehavior = dateSelection
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        headerTitle.text = "My task"
        calendarLabel.text = formatter.string(from: Date())
        formatter.dateFormat = "dd.MM.yyyy"
        today = formatter.string(from: Date())
        calendar.isHidden = true
        calendarButton.setBackgroundImage(UIImage(systemName: "arrowtriangle.down.fill"),
                                          for: .normal)
        if defaults.bool(forKey: "firstLaunch") == false {
            presenter?.fetchData()
            calendar.isHidden = false
            defaults.setValue(true,
                              forKey: "firstLaunch")
            calendarButton.setBackgroundImage(UIImage(systemName: "arrowtriangle.up.fill"),
                                              for: .normal)
        }
    }
    private func setupeSubview() {
        view.addSubview(tableView)
        tableView.addSubview(indicator)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(emptyTitle)
        
        view.addSubview(firstStackView)
        firstStackView.addArrangedSubview(secondStakView)
        secondStakView.addArrangedSubview(calendarView)
        calendarView.addSubview(calendarButton)
        calendarView.addSubview(calendarLabel)
        secondStakView.addArrangedSubview(calendar)
        views.append(calendar)
        calendar.delegate = self
        calendarView.addSubview(headerTitle)
        
        view.addSubview(addButton)
    }
    private func setupeButton() {
        calendarView.addGestureRecognizer(viewRecognizer)
        viewRecognizer.addTarget(self,
                                 action: #selector(showAndhide))
        calendar.addGestureRecognizer(swipeRecognizer)
        swipeRecognizer.addTarget(self,
                                  action: #selector(showAndhide))
        swipeRecognizer.direction = .up
        addButton.addTarget(self,
                            action: #selector(addNewTask),
                            for: .touchUpInside)
    }
    @objc func addNewTask() {
        presenter?.clickToAnimate(view: addButton)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) {
            self.presenter?.openAddTaskController(date: self.today)
        }
    }
    @objc func showAndhide() {
        views.forEach { buttom in
            UIView.animate(withDuration: 0.1) {
                buttom.isHidden = !buttom.isHidden
                self.view.layoutIfNeeded()
                if buttom.isHidden == false {
                    self.calendarButton.setBackgroundImage(UIImage(systemName: "arrowtriangle.up.fill"),
                                                           for: .normal)
                } else {
                    self.calendarButton.setBackgroundImage(UIImage(systemName: "arrowtriangle.down.fill"),
                                                           for: .normal)
                }
            }
        }
    }
    private func addConstraints() {
        headerTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
            make.height.equalTo(35)
            make.width.greaterThanOrEqualTo(70)
        }
        firstStackView.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview().inset(70)
            make.width.equalToSuperview()
        }
        secondStakView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        calendarView.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        calendarButton.snp.makeConstraints { make in
            make.centerY.equalTo(headerTitle.snp.centerY)
            make.width.height.equalTo(15)
            make.right.equalTo(-20)
        }
        calendarLabel.snp.makeConstraints { make in
            make.centerY.equalTo(headerTitle.snp.centerY)
            make.width.lessThanOrEqualTo(150)
            make.height.lessThanOrEqualTo(30)
            make.right.equalTo(calendarButton.snp.left).inset(-10)
        }
        calendar.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(460)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottomMargin.equalToSuperview()
        }
        indicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(emptyTitle.snp.top).inset(-20)
        }
        emptyTitle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        addButton.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.width.height.equalTo(70)
            make.bottomMargin.equalToSuperview().inset(10)
        }
    }
}
extension TaskBaseController: UICalendarSelectionSingleDateDelegate,
                              UICalendarViewDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate,
                       didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else { return }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        today = formatter.string(from: date)
        presenter?.showTasksToday(date: today)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) {
            formatter.dateFormat = "d MMMM"
            self.calendarLabel.text = formatter.string(from: date)
            self.showAndhide()
        }
    }
    func calendarView(_ calendarView: UICalendarView,
                      decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        for test in markedDates {
            if test == dateComponents.date  {
                return UICalendarView.Decoration.default(color: .systemYellow)
            }
        }
        return nil
    }
}
extension TaskBaseController: UITableViewDataSource,
                                    UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                             numberOfRowsInSection section: Int) -> Int {
        model?.count ?? 0
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "task",
                                                 for: indexPath) as? TaskCell,
              let model = model?[indexPath.row] else { return UITableViewCell() }
        emptyTitle.isHidden = true
        cell.configureData(model)
        cell.model = model
        cell.presenter = presenter
        return cell
    }
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.tableView.cellForRow(at: indexPath) else { return }
        let model = model?[indexPath.item]
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            cell.transform = CGAffineTransform(scaleX: 0.95,
                                               y: 0.95)
        }, completion: { finished in
            self.presenter?.showDetailViewController(model: model)
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                cell.transform = CGAffineTransform(scaleX: 1,
                                                   y: 1)
            })
        })
    }
}
extension TaskBaseController: BaseViewProtocol {
    func getData(_ data: [TaskModel]?) {
        indicator.stopAnimating()
        model = data
        guard let data = model else { return }
        for data in data {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            markedDates.insert(formatter.date(from: data.dateOfCreation ?? "") ?? Date())
        }
    }
}
