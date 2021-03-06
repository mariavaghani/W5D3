require_relative "questions"
require_relative "question"

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

    def authored_questions
        Question.find_by_author_id(self.id)
    end

    def authored_replies
        Reply.find_by_user_id(self.id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(self.id)
    end

    def liked_questions
        QuestionLike.liked_questions_for_user_id(self.id)
    end

    def average_karma
        result = QuestionsDatabase.instance.execute(<<-SQL, self.id)
        SELECT
            COALESCE(
                COUNT(DISTINCT questions.id) / CAST (COUNT(question_likes.id) AS FLOAT),
                0.0
                )
        FROM
            questions
        LEFT JOIN
            question_likes ON questions.id = question_likes.question_id
        WHERE
            author_id = ?;
        SQL
        result = result.first.values.first
    end


end
