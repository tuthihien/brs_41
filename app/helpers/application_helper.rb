module ApplicationHelper
  def index_continue object_param, index, per_page
    (object_param.to_i - 1) * per_page.to_i + index + 1
  end
end
