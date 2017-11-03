require 'io/console'

class SessionView
  def ask_for(value)
    puts "#{value}?"
    print "> "
    value == "password" ? hide_password : gets.chomp
  end

  def wrong_credientials_message
    puts ""
    puts "Wrong credentials... Try again!"
    puts ""
  end

  def greet_user(username)
    puts ""
    puts "Welcome #{username.capitalize} !"
  end

  def logout_message(username)
    puts ""
    puts "Goodbye #{username.capitalize} ! See you soon.."
  end

  private

  def hide_password
    STDIN.noecho(&:gets).chomp
  end
end
