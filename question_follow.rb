require_relative "questions"

class QuestionFollow

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
end