require_relative "questions"

class User

    attr_accessor :id, :fname, :lname

    def self.all
        data = QuestionsDatabase.instance.execute('SELECT * FROM users')
        data.map { |datum| User.new(datum) }
    end

    def self.find_by_name(fname, lname)
        options = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ? AND lname = ?;
        SQL
        options.map { |option| User.new(option) }
    end

    def initialize(options)

        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']

    end

    def self.find_by_id(id)
        options = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            users
        WHERE
            id = ?;
        SQL
        options.map { |option| User.new(option) }
    end

end