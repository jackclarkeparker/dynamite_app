module ApplicationHelper
  def display_boolean(value)
    case value
    when true  then '✅'
    when false then '❌'
    end
  end
end
