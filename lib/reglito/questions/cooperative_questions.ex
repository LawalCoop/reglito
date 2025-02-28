defmodule Reglito.Questions.CooperativeQuestions do
  alias Reglito.Questions.Question

  @all [
    %Question{
      chapter: :cooperative,
      key: UUIDv7.generate(),
      question: "¿Bajo qué principios desarrollarán sus actividades?",
      answer_type: :multiple,
      options: [
        "Ley 20.337",
        "Estatuto social",
        "Presente reglamento",
        "Normas y principios cooperativos",
        "Principios de la ACI",
        "Principios CICOPA"
      ],
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: La Cooperativa de trabajo {COOPERATIVE} Ltda. desarrollará sus actividades de acuerdo a {OPTIONS}."
    },
    %Question{
      chapter: :cooperative,
      key: UUIDv7.generate(),
      question: "¿Bajo que principios procurará el Consejo de Administración hacer su trabajo?",
      answer_type: :multiple,
      options: [
        "alentar y promover el espíritu de trabajo mancomunado",
        "el respeto común y la convivencia solidaria entre las personas asociadas",
        "con el fin de crear el medio ideal que permita alcanzar la máxima productividad",
        "la ocupación continua de las personas asociadas",
        "el mantenimiento de la mejor relación con quienes contraten o se relacionen con la cooperativa",
        "la constante educación y capacitación de las personas asociadas"
      ],
      nested_questions: nil,
      result_template:
        "ARTICULO {NUMBER}: El consejo de administración procurará el crecimiento de la entidad, sobre la base de {OPTIONS}. Este reglamento establecerá la manera de organización y funcionamiento de la cooperativa y establecerá la forma de disciplina y control requerido para ésta."
    }
  ]

  def all, do: @all
end
