module BoardsHelper

  def to_postit task
    "<li id='#{task.id}' class='postit#{category_class(task)}'>
      <p class='postit_top'>
        <span class='show_points'>#{points(task)}</span>
        #{select_for_points(task)}
        #{comments(task)}
      </p>
      #{title(task)}
      #{description(task)}
      <div class='assignees_block'>
        #{assignees(task)}
        <div class='assignees_form'>#{form_for_assignees(task)}</div>
      </div>
      <div class='postit_bottom'>
        #{options(task)}
      </div>
    </li>"
  end

  def options task
    string = "<div class='postit_options_block'>"
    string += "<a class='postit_options icon-cog' href='javascript:;'></a>"
    string += "<ul class='postit_options_list'>"
    string += '<li>' + link_to(t(:show), project_task_path(task.project, task)) + '</li>'
    string += '<li>' + link_to(t(:edit), edit_project_task_path(task.project, task)) + '</li>'
    string += '<li>' + link_to(t(:destroy), project_task_path(task.project, task),
                                          :confirm => t(:are_you_sure),
                                          :method => :delete) + '</li>'
    string += '</ul></div>'
  end

  def select_for_points task
    string = "<select class='points_select'>"
    string += "<option value='-'>-</option>"
    Task::POINTS.each do |point|
      selected = task.points == point ? " selected='selected'" : ''
      string += "<option#{selected} value='#{point}'>#{point}</option>"
    end
    string += "</select>"
  end

  def form_for_assignees task
    string = "<select multiple='multiple' size='5'>"
    string += "<option value='-'>-</option>"
    task.project.all_contributors.each do |contributor|
      selected = task.contributors.include?(contributor) ? " selected='selected'" : ''
      string += "<option#{selected} value='#{contributor.id}'>#{contributor.initials}</option>"
    end
    string += "</select>"
    string += "<input type='submit' value='ok' />"
  end

  def category_class task
    category_class = task.category.nil? ? '' : " #{task.category.name_as_css_class}"
  end

  def points task
    task.points.nil? ? '-' : task.points
  end

  def description task
    unless task.description.blank?
      #uname = ('a'..'z').to_a.shuffle[0,8].join
      "<div class='postit-content'>" +
      task.description
        .gsub(/\r\n/, '<br />')
        .gsub(/\[[^x]?\]/, '<input type="checkbox" />')
        .gsub(/\[x\]/, '<input type="checkbox" checked />') +
      "</div>"
    end
  end

  def comments task
    number = task.comments.count
    return "<span class ='comments_number'>#{number} comment</span>" if number == 1
    "<span class ='comments_number'>#{number} comments</span>"
  end

  def title task
    uid = ''
    if task.title =~ /^\d{3}/
      uid = task.title[0..2]
      uid = "<span class='uid'>"+uid+"</span>"
      task.title.gsub! /(\d{3})/, ''
    end
    if task.title.length > 45
      uid + link_to(truncate(task.title, :length => 45),
        project_task_path(task.project, task),
        :class => 'title help_cursor', :title => task.title)
    else
      uid + link_to(task.title, project_task_path(task.project, task), :class => :title)
    end
  end

  def assignees task
    return "<p class='show_assignees icon-user'>&nbsp;</p>" if task.contributors.empty?

    assignees_sentence = task.contributors.collect(&:username).to_sentence

    if assignees_sentence.length > 25
      p = "p class='show_assignees' title='#{assignees_sentence}'"
    else
      p = "p class='show_assignees'"
    end

    assignees_picts = ''
    task.contributors.each do |c|
      assignees_picts += image_tag(c.avatar.thumb) if c.avatar?
    end
    unless assignees_picts.blank?
      return "<#{p}>
      #{assignees_picts}
    </p>"
    end
    return "<#{p}>
      #{truncate(assignees_sentence, :length => 25)}
    </p>"
  end

end

