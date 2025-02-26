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
            "nested_questions": [
              {
                "field_name": "b",
                "question": "¿Porque?",
                "answer_type": "text",
                "nested_questions": null,
                "result_template": "ARTÍCULO {NUMBER}: zarlanga {OPTIONS}."
              }
            ],
            "result_template": "ARTÍCULO {NUMBER}: La Cooperativa de trabajo {COOPERATIVE} Ltda. desarrollará sus actividades de acuerdo a {OPTIONS}."
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
