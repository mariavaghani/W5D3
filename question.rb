require_relative "questions"
require_relative "user"
require_relative "reply"


class Question

    attr_accessor :id, :title, :body, :author_id

    def self.all
        data = QuestionsDatabase.instance.execute('SELECT * FROM questions')
        data.map { |datum| Question.new(datum) }
    end

    def self.find_by_id(id)
        options = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
            *
        FROM
            questions
        WHERE
            id = ?;
        SQL
        options.map { |option| Question.new(option) }
    end

    def self.find_by_author_id(author_id)
        options = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT
            *
        FROM
            questions
        WHERE
            author_id = ?;
        SQL
        options.map { |option| Question.new(option) }
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def self.most_followed(n)
        QuestionFollow.most_followed_questions(n)
    end

    def author
        User.find_by_id(self.author_id)
    end

    def replies
        Reply.find_by_question_id(self.id)
    end


    def followers
        QuestionFollow.followers_for_question_id(self.id)
    end



end