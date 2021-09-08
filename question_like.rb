require_relative "questions"

class QuestionLike

    def self.find_by_id(id)
        QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            question_likes
        WHERE
            id = ?;
        SQL
    end
end