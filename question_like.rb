require_relative "questions"

class QuestionLike

    attr_accessor :id, :user_id, :question_id

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

    def self.likers_for_question_id(question_id)
        options = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            user_id AS id, fname, lname
        FROM
            users
        JOIN
            question_likes ON users.id = question_likes.user_id
        WHERE
            question_id = ?
        SQL
        options.map { |option| User.new(option) }
    end

    def self.num_likes_for_question_id(question_id)
        result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            COUNT(*)
        FROM
            question_likes
        WHERE
            question_id = ?
        SQL
        result.first.values.first
    end

    def self.liked_questions_for_user_id(user_id)
        options = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
            *
        FROM
            questions
        WHERE
            id in (
                SELECT
                    question_id
                FROM
                    question_likes
                WHERE
                    user_id = ?
            )
        
        SQL
        options.map { |option| Question.new(option) }
    end

    def self.most_liked_questions(n)
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
                    question_likes
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

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end


end
