require_relative '../views/session_view.rb'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionView.new
  end

  def sign_in
    username = @view.ask_for("username")
    password = @view.ask_for("password")

    employee = @employee_repository.find_by_username(username)

    if employee && employee.password == password
      @view.greet_user(employee.username)
      employee
    else
      @view.wrong_credientials_message
      sign_in
    end
  end

  def logout(username)
    @view.logout_message(username)
  end
end
