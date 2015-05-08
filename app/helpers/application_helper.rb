module ApplicationHelper
  def modal_helper(header, modal, &block)
    modal_id = modal[:target]
    content_tag(:div, class: ['modal', 'fade'], id: modal_id) do
      content_tag(:div, class:['modal-dialog', 'modal-lg']) do
        content_tag(:div, class: 'modal-content') do
          concat show_header(header)
          concat capture(&block) if block_given?
        end
      end
    end
  end
end

def show_header(header)
  content_tag(:div, class: 'modal-header') do
    content_tag(:h4, header, class: 'modal-title')
  end
end

def owner(user)
  user.id == current_user.id
end

def error_messages(object, field)
  if !object.errors.full_messages_for(field).empty?
    content_tag(:div, object.errors.full_messages_for(field).join(', '), class: 'alert-danger')
  end
end
