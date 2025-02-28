defmodule Reglito.Questions.Question do
  defstruct key: :string,
            question: :string,
            answer_type: :string,
            options: nil,
            nested_questions: nil,
            result_template: :string,
            chapter: :atom
end
