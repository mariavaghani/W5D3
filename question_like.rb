require_relative "questions"

class QuestionLike

    attr_accessor :id, :user_id, :question_id

    def self.find_by_id(id)
        options = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            question_likes
        WHERE
            id = ?;
        SQL
        options.map { |option| QuestionLike.new(option) }
    end

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end
end