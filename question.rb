require_relative "questions"


class Question

    def self.find_by_id(id)
        QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            questions
        WHERE
            id = ?;
        SQL
    end
end