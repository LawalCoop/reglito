defmodule Reglito.Questions.ServicesQuestions do
  alias Reglito.Questions.Question

  @all [
    %Question{
      chapter: :services,
      key: UUIDv7.generate(),
      question: "Áreas que tendrá la cooperativa",
      answer_type: :multiple,
      options: ["Administración", "Producción", "Control de Calidad"],
      nested_questions: [
        %Question{
          chapter: :cooperative,
          key: UUIDv7.generate(),
          question: "Cada área ¿tendrá una persona que coordine?",
          answer_type: :exclusive,
          options: ["SI", "NO"],
          nested_questions: nil,
          result_template:
            "cada una de ellas tendrá un/a coordinador/a designado/a por el Consejo de Administración por el tiempo que este determine"
        }
      ],
      result_template:
        "ARTICULO {NUMBER}: La cooperativa se distribuirá en las siguientes áreas, {OPTIONS}. El Consejo podrá a su vez, modificar las áreas de la cooperativa así como todo el articulado de esta sección sin necesidad de reforma del reglamento toda vez que son cuestiones de mera organización interna."
    },
    %Question{
      chapter: :services,
      key: UUIDv7.generate(),
      question: "Dias Laborables de la cooperativa",
      answer_type: :text,
      options: nil,
      nested_questions: [
        %Question{
          chapter: :services,
          key: UUIDv7.generate(),
          question: "Horario Laborable de la cooperativa",
          answer_type: :text,
          options: nil,
          nested_questions: nil,
          result_template:
            "En los siguientes horarios: {TEXT}. Este horario podrá extenderse entre 30 minutos o más según las particularidades del servicio y ser modificado por el Consejo de Administración sin necesidad de reforma del presente reglamento por ser de mera organización interna."
        }
      ],
      result_template:
        "ARTICULO {NUMBER}: Los días laborales se fijan, en principio salvo que la cooperativa requiera por tareas excepcionales otros, los días {TEXT}."
    }
  ]

  def all, do: @all
end
