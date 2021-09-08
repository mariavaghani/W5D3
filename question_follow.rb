require_relative "questions"

class QuestionFollow

    def self.find_by_id(id)
        QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            question_follows
        WHERE
            id = ?;
        SQL
    end
end