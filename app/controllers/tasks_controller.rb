class TasksController < InheritedResources::Base
  respond_to :html, :xml, :json
  layout :get_layout
  before_filter :authenticate_contributor!

  belongs_to :project

  def show
    show! do
      @project = @task.project
      @comment = Comment.new
      @ajax = request.xhr?
    end
  end

  def new
    new! { @categories = Category.where(:project_id => @project.id).order('NAME ASC') }
  end

  def edit
    edit! { @categories = Category.where(:project_id => @project.id).order('NAME ASC') }
  end

  def create
    params[:task][:author_id] = current_contributor.id
    create! { project_board_path }
  end

  def update
    update! { project_board_path }
  end

  def destroy
    destroy! { project_board_path }
  end

  def import
     file = params[:file]
     @xml = Nokogiri::XML(file)
     @xml.root.search('Task').each do |t|
       task = Task.new :title => t.search('ID').text.rjust(3, '0') + ' ' + t.search('Name').text,
                       :description => '',
                       :project_id => params[:project_id],
                       :position => Board::POSITIONS['backlog'],
                       :author_id => current_contributor.id
       if (t.search('PercentComplete').text == '100')
         task.position = Board::POSITIONS['done']
       end
       task.save
     end
     redirect_to '/projects/'+params[:project_id]+'/board'
  end

  def many_tasks
    tasks = params[:list]
    tasks_to_save = []
    tasks.each_line { |line|
      unless line.empty?
        if (line[0] != " ")
          task = Task.new :title => line,
                          :description => '',
                          :project_id => params[:project_id],
                          :category_id => params[:category][:category_id],
                          :position => Board::POSITIONS['backlog'],
                          :author_id => current_contributor.id
          tasks_to_save << task
        else
          tasks_to_save.last.description += line
        end
      end
    }
    tasks_to_save.each {|t| t.save}
    redirect_to '/projects/'+params[:project_id]+'/board'
  end

  def update_checkbox
    task = Task.find(params[:task_id])
    index = -1
    desc =  task.description.gsub(/\[[ x]*\]/) do |match|
      index += 1
      (index.to_s == params[:pos]) ? ((params[:checked] == 'true') ? '[x]' : '[ ]') : match
    end
    task.description = desc
    task.save
    render :text => task.to_json
  end

    def get_layout
      request.xhr? ? nil : 'application'
    end
end

