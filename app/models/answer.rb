class Answer < ActiveRecord::Base

	belongs_to :question

	validates :body, length: { in: 10..1000 }

end
