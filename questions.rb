require "sqlite3"
require 'singleton'


class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super("questions_db.db")
        self.type_translation = true
        self.results_as_hash = true
    end

end

class User

    def self.all
        data = QuestionsDatabase.instance.execute('SELECT * FROM users')
        data.map { |datum| User.new(datum) }
    end

    def self.find_by_name(name)
        QuestionsDatabase.instance.execute(<<-SQL, name)
            SELECT
                *
            FROM
                users
            WHERE
                name = ?;
        SQL
    end

    def initialize(options)

        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']

    end

end

class Question
end

class QuestionFollow
end

class Reply
end

class QuestionLike
end
