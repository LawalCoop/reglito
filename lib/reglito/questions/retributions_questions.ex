defmodule Reglito.Questions.RetributionsQuestions do
  alias Reglito.Questions.Question

  @all [
    %Question{
      chapter: :retributions,
      key: UUIDv7.generate(),
      question: "Categorías dentro de la Cooperativa",
      answer_type: :text,
      options: nil,
      nested_questions: [
        %Question{
          chapter: :retributions,
          key: UUIDv7.generate(),
          question:
            "¿Se remunerará con un plus a las personas que ocupen el Consejo de Administración?",
          answer_type: :exclusive,
          options: ["SI", "NO"],
          nested_questions: nil,
          result_template:
            "Retirarán un porcentaje más del Retiro normal previo a la asunción de las funciones de Consejero durante el tiempo que ejerza el cargo."
        },
        %Question{
          chapter: :retributions,
          key: UUIDv7.generate(),
          question: "Porcentaje Extra",
          answer_type: :number,
          options: nil,
          nested_questions: nil,
          result_template: "El porcentaje será un {NUMBER}% extra."
        }
      ],
      result_template:
        "ARTICULO {NUMBER}: Se fijan las siguientes categorías y jerarquías, atentas a las necesidades de la Cooperativa, cada persona pertenecerá a la categoría que designe el Consejo de Administración: {TEXT}"
    },
    %Question{
      chapter: :retributions,
      key: UUIDv7.generate(),
      question: "¿Se abonará antigüedad?",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTICULO {NUMBER}: Antigüedad: a partir de su ingreso a la Cooperativa, las personas asociadas percibirán un adicional por antigüedad, equivalente al 1% por año sobre los retiros básicos de cada persona asociada, por jornada laboral de 9 horas, con un tope máximo de 30 años."
    },
    %Question{
      chapter: :retributions,
      key: UUIDv7.generate(),
      question:
        "Formación de las personas asociadas en la cooperativa. ¿Se faculta al Consejo a realizar planes en este sentido?",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTICULO {NUMBER}: Formación: La formación técnica y cooperativa de las personas asociadas es un aspecto estratégico al desarrollo de la Empresa. En el marco de los planes de trabajo y de desenvolvimiento de la misma se faculta al Consejo de Administración a elaborar diversos planes de formación técnico empresarial, ya sea a través de iniciativas propias o en el marco de las asociaciones empresarias o del movimiento cooperativo o de convenios con escuelas, universidades o cualquier otro medio idóneo para tal fin."
    },
    %Question{
      chapter: :retributions,
      key: UUIDv7.generate(),
      question:
        "Formación de las personas aspirantes, pago o compensación de las horas destinadas",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTICULO {NUMBER}: Es facultad del Consejo de Administración elaborar cursos de capacitación de la especialidad para aspirantes a ingresar al período de prueba para poder asociarse a la Cooperativa.
        Las horas de capacitación se pagarán o se compensarán previa aprobación por el Consejo de Administración."
    },
    %Question{
      chapter: :retributions,
      key: UUIDv7.generate(),
      question: "¿Las retribuciones pueden modificarse si así sucede en el sector?",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTICULO {NUMBER}: Los montos de las retribuciones fijadas podrán ser modificados por el Consejo de Administración, siguiendo la tendencia y proporcionalidad que se advierta en la plaza respecto de los aumentos de retribuciones , así como por propio criterio y/o acuerdos internos a los mismos fines."
    },
    %Question{
      chapter: :retributions,
      key: UUIDv7.generate(),
      question:
        "Si los días por enfermedad han sido comprobados, no se descontarán de la retribución",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTICULO {NUMBER}: A los efectos del cálculo de las retribuciones , no se descontarán los días de ausencia por enfermedad, siempre que la misma sea comprobada, para lo cual servirá como única acreditación un certificado médico. Cuando el Consejo de Administración lo estime necesario podrá designar un médico para realizar una segunda consulta."
    },
    %Question{
      chapter: :retributions,
      key: UUIDv7.generate(),
      question: "Enfermedad inculpable",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTICULO {NUMBER}: En caso de enfermedad inculpable, la persona asociada tendrá derecho a las retribuciones (mesadas) básicas correspondientes a su categoría o cargo en el cual se desempeña, por un lapso de doce (12) meses al cien por ciento (100%). Durante los siguientes doce (12) meses será la Asamblea la que determinará el derecho a retribuciones (mesadas) y el Consejo de Administración, de acuerdo a los dictámenes médicos, determinará la continuidad como persona asociada pudiendo atenderse al artículo 13 inciso d) del Estatuto. Quedan exceptuados de esta norma aquellas personas asociadas que sufrieran accidentes de trabajo, en cuyo caso el plazo se extenderá hasta las conclusiones médicas finales, pudiendo de acuerdo a las mismas, el Consejo de Administración tomar las resoluciones que pudieran corresponder sobre la base del art. 13 precedentemente mencionado, debiendo previamente intimar a la persona asociada a tramitar la jubilación por incapacidad."
    },
    %Question{
      chapter: :retributions,
      key: UUIDv7.generate(),
      question: "Retribuciones para personas con enfermedad inculpable e intimación a jubilarse",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: [
        %Question{
          chapter: :retributions,
          key: UUIDv7.generate(),
          question:
            "¿Puede habilitar el consejo el pago de retribuciones extraordinarias en otro período de tiempo?",
          answer_type: :exclusive,
          options: ["SI", "NO"],
          nested_questions: nil,
          result_template:
            "El Consejo de administración podrá abonar retribuciones extraordinarias a todas las personas asociadas en períodos menores de tiempo (bimensuales, trimestrales, cuatrimestrales) cuando la situación económico financiera de la entidad así lo permita."
        }
      ],
      result_template:
        "ARTICULO {NUMBER}: Se determina que las retribuciones semestrales extraordinarias que se distribuyen entre las personas asociadas no superarán el cincuenta por ciento (50%) de la mayor retribución básica habitualmente percibida. El Consejo de Administración lo pondrá a disposición de acuerdo a las posibilidades económicas de la Cooperativa."
    }
  ]

  def all, do: @all
end
