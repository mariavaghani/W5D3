require_relative "questions"

class Reply

    def self.find_by_id(id)
        QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            replies
        WHERE
            id = ?;
        SQL
    end
end