module JobsHelper
  def list_field
    list = []
    if logged_in?
      current_user.curriculum_vitaes.each do |cv|
        list << cv.field_id
      end
    end
    list.map(&:inspect).join(", ")
  end
end