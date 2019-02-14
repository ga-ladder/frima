# frozen_string_literal: true

module ApplicationHelper
  def parent(category)
    Category.find(category.parent_id)
  end

  def grand_parent(category)
    parent(parent(category))
  end
end
