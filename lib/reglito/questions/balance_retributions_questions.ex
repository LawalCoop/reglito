defmodule Reglito.Questions.BalanceRetributionsQuestions do
  alias Reglito.Questions.Question

  @all [
    %Question{
      chapter: :balance_retributions,
      key: UUIDv7.generate(),
      question: "¿Cómo se distribuyen el resultado anual?",
      answer_type: :one_option,
      options: [
        {"No me importa la categoría, a todas las personas le distribuimos lo mismo en función a hora trabajada",
         "Considerando las horas de trabajo efectivamente realizadas por cada persona en el año, valiéndo todas las horas el mismo monto con independencia de la categoría. El Consejo de Administración deberá realizar un registro mensual de horas trabajadas que permita hacer esta distribución."},
        {"Distribuimos en función a la masa de retiros que cobró cada persona en el año sobre el total de retribuciones (cobre mas durante el año, cobro mas con el balance)",
         "En proporción a lo efectivamente cobrado periódicamente por sobre el total de la masa de retribuciones abonadas."}
      ],
      nested_questions: nil,
      result_template:
        "ARTICULO {NUMBER}: Para la distribución de los excedentes de fin de ejercicio y una vez afectados los porcentajes para la constitución de reservas y fondos determinados por la Ley de Cooperativas 20.337, artículo 42, el remanente se distribuirá en efectivo o en capital social entre las personas asociadas. {OPTION}"
    }
  ]

  @spec all :: [%Question{}]
  def all, do: @all
end
