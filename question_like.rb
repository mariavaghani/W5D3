require_relative "questions"

class QuestionLike

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
end