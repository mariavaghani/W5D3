require_relative "questions"

class QuestionFollow

    attr_accessor :id, :question_id, :user_id

    def self.find_by_id(id)
        options = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            question_follows
        WHERE
            id = ?;
        SQL
        options.map { |option| QuestionFollow.new(option) }
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end