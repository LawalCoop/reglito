defmodule Reglito.Questions do
  alias Reglito.Questions.Question
  alias Reglito.Questions.LicensesQuestions
  alias Reglito.Questions.PenaltiesQuestions
  alias Reglito.Questions.BalanceRetributionsQuestions
  alias Reglito.Questions.RetributionsQuestions
  alias Reglito.Questions.PowerAndDutiesQuestions
  alias Reglito.Questions.ServicesQuestions
  alias UUIDv7
  alias Reglito.Questions.CooperativeQuestions

  @spec selected_chapters_questions([atom()]) :: [%Question{}]
  def selected_chapters_questions(selected_chapters) do
    questions_by_chapter = %{
      cooperative: CooperativeQuestions.all(),
      services: ServicesQuestions.all(),
      power_and_duties: PowerAndDutiesQuestions.all(),
      retributions: RetributionsQuestions.all(),
      balance_retributions: BalanceRetributionsQuestions.all(),
      penalties: PenaltiesQuestions.all(),
      licenses: LicensesQuestions.all()
    }

    Enum.reduce(selected_chapters, [], fn chapter, acc ->
      acc ++ questions_by_chapter[chapter]
    end)
  end
end
