module ApplicationHelper
  def exchange_money money
    return 0 unless money
    return (money / 23_040).round(2) if I18n.locale == :en

    money
  end

  def current_class? *controller
    return "active" if controller.include?(params[:controller])

    ""
  end
end
