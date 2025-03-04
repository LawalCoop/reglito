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
    },
    %Question{
      chapter: :cooperative,
      key: UUIDv7.generate(),
      question:
        "¿Se permite que se realicen reuniones de consejo abiertas a todas las personas asociadas que no sean asambleas?",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: [
        %Question{
          chapter: :cooperative,
          key: UUIDv7.generate(),
          question: "¿Cualquier integrante puede convocar una reunión de consejo abierta?",
          answer_type: :exclusive,
          options: ["SI", "NO"],
          nested_questions: nil,
          result_template:
            "Cuando el consejo de administración lo considere conveniente, o cuando la trascendencia de los temas a resolver lo aconseje, se podrá convocar a Reunión de consejo abierta. Esta podrá ser convocada por cualquier integrante del consejo, por el síndico o por las personas asociadas que representen un 25% del total."
        }
      ],
      result_template:
        "ARTICULO {NUMBER}: Las personas integrantes del Consejo de Administración y la sindicatura deberán ser elegidos en Asambleas General, Ordinaria o Extraordinaria por voto de las personas asociadas presentes por mayoría simple, que de acuerdo al Estatuto Social y a la Ley 20.337 o a la que la modifique y este reglamento estén en condiciones de hacerlo.
        Para ser candidato/a a consejero/a o síndico/a de la cooperativa la personas asociada deberá ser mayor de 18 años de edad.
        El consejo deberá reunirse como mínimo una vez al mes y podrá reunirse en cualquier  momento que la circunstancia lo exija."
    },
    %Question{
      chapter: :cooperative,
      key: UUIDv7.generate(),
      question:
        "¿Las personas asociadas deben prestar su colaboración cuando sea requerida a pesar que el consejo es el encargado de la gestión económica y contable?",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTICULO {NUMBER}: La gestión económica y contable dependerá del consejo de Administración, que lo hace a través de la estructura de la Cooperativa sin embargo todas las personas asociadas deberán prestar su colaboración en caso de ser requerida. En el desarrollo de las actividades se deberá cumplir con las disposiciones legales, estatutarias y las resoluciones de asambleas."
    },
    %Question{
      chapter: :cooperative,
      key: UUIDv7.generate(),
      question:
        "¿Se autoriza a la cooperativa a subir imagenes, videos u otros soportes para difusión?",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTICULO {NUMBER}: Las personas asociadas autorizan a la cooperativa a utilizar sus imágenes, ya sea en fotografías, vídeos u otros medios audiovisuales, en el marco de las actividades promocionales, publicitarias y de difusión de la Cooperativa sin necesidad de que se genere ningún tipo de derecho a percibir contraprestación económica alguna por parte de las personas asociadas."
    },
    %Question{
      chapter: :cooperative,
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
    }
  ]

  def all, do: @all
end
