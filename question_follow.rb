require_relative "questions"

class QuestionFollow

    attr_accessor :id, :question_id, :user_id

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

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end

    def self.followers_for_question_id(question_id)
        options = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            user_id as id, fname, lname
        FROM
            users
        JOIN
            question_follows ON users.id = question_follows.user_id
        WHERE
            question_follows.question_id = ?;
        SQL
        options.map { |option| User.new(option)}
    end

    def self.followed_questions_for_user_id(user_id)
        options = QuestionsDatabase.instance.execute(<<-SQL, user_id)

        SELECT
            question_id AS id, body, title, author_id
        FROM
            questions
        JOIN
            question_follows ON questions.id = question_follows.question_id
        WHERE
            question_follows.user_id = ?;
        SQL
        options.map { |option| Question.new(option) }
    end

    def self.most_followed_questions(n)
        options = QuestionsDatabase.instance.execute(<<-SQL, n)

        SELECT
            *
        FROM
            questions
        WHERE
            id IN (
                SELECT
                    question_id
                FROM
                    question_follows
                GROUP BY
                    question_id
                ORDER BY
                    COUNT(*) DESC
                LIMIT
                    ?
                );
        SQL
        options.map { |option| Question.new(option) }
    end

    
end

