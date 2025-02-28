defmodule Reglito.Chapters do
  def read_chapters_description() do
    Jason.decode!("""
    [
      {
        "name": "De la cooperativa",
        "code": "COOPERATIVE",
        "description": "Aquí pondremos cuestiones generales relacionadas a la normativa a la que está sujeta el reglamento, desde cuando comienza a regir y los principios y valores del trabajo en tu entidad"
      },
      {
        "name": "De la prestación de servicio",
        "code": "SERVICES",
        "description": "Aquí pondremos cuestiones relacionadas a como se organizará internamente la cooperativa, que áreas tendrá, si existirán coordinadores, días y horarios laborables, son cuestiones relacionadas al orden interno de la cooperativa. Según la ley de cooperativas al ser meras cuestiones de organización interna no es necesario inscribirlas en el reglamento interno, pero nosotros sugerimos ponerlas y luego darle la potestad al Consejo de Administración de modificar estos aspectos sin inscribir dichas reformas por no ser obligatorias"
      }
    ]
    """)
  end

  def read_chapters_data() do
    Jason.decode!("""
    {
      "COOPERATIVE": {
        "sections": [
          {
            "field_name": "a",
            "question": "¿Bajo qué principios desarrollarán sus actividades?",
            "answer_type": "multiple",
            "options": [
              "Ley 20.337",
              "Estatuto social",
              "Presente reglamento",
              "Normas y principios cooperativos",
              "Principios de la ACI",
              "Principios CICOPA"
            ],
            "nested_questions": null,
            "result_template": "ARTÍCULO {NUMBER}: La Cooperativa de trabajo {COOPERATIVE} Ltda. desarrollará sus actividades de acuerdo a {OPTIONS}."
          },
          {
            "field_name": "b",
            "question": "¿Bajo que principios procurará el Consejo de Administración hacer su trabajo?",
            "answer_type": "multiple",
            "options": [
              "alentar y promover el espíritu de trabajo mancomunado",
              "el respeto común y la convivencia solidaria entre las personas asociadas",
              "con el fin de crear el medio ideal que permita alcanzar la máxima productividad",
              "la ocupación continua de las personas asociadas",
              "el mantenimiento de la mejor relación con quienes contraten o se relacionen con la cooperativa",
              "la constante educación y capacitación de las personas asociadas"
            ],
            "nested_questions": null,
            "result_template": "ARTICULO {NUMBER}: El consejo de administración procurará el crecimiento de la entidad, sobre la base de {OPTIONS}. Este reglamento establecerá la manera de organización y funcionamiento de la cooperativa y establecerá la forma de disciplina y control requerido para ésta."
          },
          {
            "field_name": "c",
            "question": "¿Se permite que se realicen reuniones de consejo abiertas a todas las personas asociadas que no sean asambleas?",
            "answer_type": "exclusive",
            "options": [
              "SI",
              "NO"
            ],
            "nested_questions": null,
            "result_template": "ARTICULO {NUMBER}: Las personas integrantes del Consejo de Administración y la sindicatura deberán ser elegidos en Asambleas General, Ordinaria o Extraordinaria por voto de las personas asociadas presentes por mayoría simple, que de acuerdo al Estatuto Social y a la Ley 20.337 o a la que la modifique y este reglamento estén en condiciones de hacerlo. Para ser candidato/a a consejero/a o síndico/a de la cooperativa la personas asociada deberá ser mayor de 18 años de edad. El consejo deberá reunirse como mínimo una vez al mes y podrá reunirse en cualquier momento que la circunstancia lo exija.",
            "additionalText": "Cuando el consejo de administración lo considere conveniente, o cuando la trascendencia de los temas a resolver lo aconseje, se podrá convocar a Reunión de consejo abierta. Esta podrá ser convocada por cualquier integrante del consejo, por el síndico o por las personas asociadas que representen un 25% del total."
          },
          {
            "field_name": "d",
            "question": "¿Las personas asociadas deben prestar su colaboración cuando sea requerida a pesar que el consejo es el encargado de la gestión económica y contable?",
            "answer_type": "exclusive",
            "options": [
              "SI",
              "NO"
            ],
            "nested_questions": null,
            "result_template": "ARTICULO {NUMBER}: La gestión económica y contable dependerá del consejo de Administración, que lo hace a través de la estructura de la Cooperativa sin embargo todas las personas asociadas deberán prestar su colaboración en caso de ser requerida. En el desarrollo de las actividades se deberá cumplir con las disposiciones legales, estatutarias y las resoluciones de asambleas."
          },
          {
            "field_name": "e",
            "question": "¿Se autoriza a la cooperativa a subir imagenes, videos u otros soportes para difusión?",
            "answer_type": "exclusive",
            "options": [
              "SI",
              "NO"
            ],
            "nested_questions": null,
            "result_template": "ARTICULO {NUMBER}: Las personas asociadas autorizan a la cooperativa a utilizar sus imágenes, ya sea en fotografías, vídeos u otros medios audiovisuales, en el marco de las actividades promocionales, publicitarias y de difusión de la Cooperativa sin necesidad de que se genere ningún tipo de derecho a percibir contraprestación económica alguna por parte de las personas asociadas."
          }
        ]
      }
    }
    """)
  end

  def sections() do
    Enum.flat_map(read_chapters_data(), fn {_chapter_key, %{"sections" => sections}} ->
      sections
    end)
  end
end
