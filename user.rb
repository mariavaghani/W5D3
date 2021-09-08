require_relative "questions"

class User

    def self.all
        data = QuestionsDatabase.instance.execute('SELECT * FROM users')
        data.map { |datum| User.new(datum) }
    end

    def self.find_by_name(fname, lname)
        QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ? AND lname = ?;
        SQL
    end

    def initialize(options)

        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']

    end

    def self.find_by_id(id)
        QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            users
        WHERE
            id = ?;
        SQL
    end

end