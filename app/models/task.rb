class Task < ActiveRecord::Base
  belongs_to :project, :touch => true # TODO: Test the touch
  belongs_to :category
  has_and_belongs_to_many :contributors, :join_table => :contributors_tasks
  has_many :comments, :dependent => :delete_all

  attr_accessible :description, :title, :points, :category_id, :position, :contributor_ids, :author_id, :project_id

  POINTS = [0, 1, 2, 3, 4, 5, 8, 13]

  validates_presence_of :title, :project_id

  def author
    Contributor.find(author_id) if author_id
  end

  private
  def author=(contributor)
    self.author_id = contributor.id
    self.save
  end
end

