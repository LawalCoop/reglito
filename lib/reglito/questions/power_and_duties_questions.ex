defmodule Reglito.Questions.PowerAndDutiesQuestions do
  alias Reglito.Questions.Question

  @all [
    %Question{
      chapter: :power_and_duties,
      key: UUIDv7.generate(),
      question:
        "Obligaciones al ingresar respecto a que debe cumplir y sobre el capital social a aportar",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTICULO {NUMBER}: Toda persona mayor de dieciocho (18) años que quiera asociarse, junto con la solicitud de adhesión por escrito, presentada al Consejo de Administración, deberá comprometerse a cumplir las disposiciones de la Ley de Cooperativas 20.337, el Estatuto Social, el presente Reglamento, las Resoluciones Asamblearias y del Consejo de Administración, y a suscribir e integrar el equivalente a un salario mínimo vital y móvil vigente a la fecha de ingreso, integrando como mínimo el 5% del capital suscripto al momento de la asociación y el resto en un tiempo no superior a 5 años."
    }
  ]

  def all, do: @all
end
