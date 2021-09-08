require_relative "questions"
require_relative "user"

class Reply

    attr_accessor :id, :question_id, :parent_reply_id, :user_id, :body

    def self.all
        data = QuestionsDatabase.instance.execute('SELECT * FROM replies')
        data.map { |datum| Reply.new(datum) }
    end

    def self.find_by_id(id)
        options = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            replies
        WHERE
            id = ?;
        SQL
        options.map { |option| Reply.new(option) }
    end

    def self.find_by_user_id(user_id)
        options = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
            *
        FROM
            replies
        WHERE
            user_id = ?;
        SQL
        options.map { |option| Reply.new(option) }
    end

    def self.find_by_question_id(question_id)
        options = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            *
        FROM
            replies
        WHERE
            question_id = ?;
        SQL
        options.map { |option| Reply.new(option) }
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @user_id = options['user_id']
        @body = options['body']
    end


    def author
        User.find_by_id(self.user_id)
    end

    def question
        Question.find_by_id(self.question_id)
    end

    def parent_reply
        Reply.find_by_id(self.parent_reply_id)
    end

    def child_replies
        options = QuestionsDatabase.instance.execute(<<-SQL, self.id)
        SELECT
            *
        FROM
            replies
        WHERE
            parent_reply_id = ?;
        SQL
        options.map { |option| Reply.new(option) }
    end


end