defmodule Reglito.Questions.LicensesQuestions do
  alias Reglito.Questions.Question

  @all [
    %Question{
      chapter: :licenses,
      key: UUIDv7.generate(),
      question: "Licencias pagas que otorgará la cooperativa a sus personas asociadas",
      answer_type: :multiple,
      options: [
        "Por fallecimiento de padre, madre, hermanos/as, cónyuge o hijos: tres (3) días",
        "Por fallecimiento de abuelos/as, nietos/as, tíos/as y padres, madres, hermanos/as, o hijos/as políticos: un (1) día",
        "Por fallecimiento de un familiar cuyo sepelio tenga lugar a una distancia superior a los 100 km. del lugar de residencia, un día adicional",
        "Por contraer matrimonio, catorce (14) días corridos",
        "Por exámenes de los que cursen estudios primarios, secundarios o universitarios, los días en que aquellos se realicen, con un tope de quince (15) días por año pagos y quince (15) días sin retribución (mesada). La persona asociada deberá solicitarlo con por lo menos 72 horas antes del examen y aportará luego el certificado expedido por las autoridades docentes, en el cual consten dichos días. También podrá solicitar reducción horaria previa autorización del/la encargado/a de sección",
        "Las asociadas en trance de maternidad: por noventa (90) días que serán tomados por la asociada antes y después del parto de acuerdo a su elección. Durante el período de lactancia gozará de dos (2) horas diarias durante seis (6) meses después del parto.  El Padre tendrá 30 días con opción de hasta 75 días aprobado por Consejo, si la situación económica financiera así lo permite. La persona asociada deberá solicitarlo con un plazo 10 días antes. En caso de adopción se computará igual a nacimiento",
        "Por violencia de género, el tiempo que determine el Consejo de Administración hasta por un plazo de 35 días continuos o alternados, se podrá prorrogar 35 días mas con un informe técnico profesional elaborado por un equipo interdisciplinario que la convalide. Esta licencia  podrá ser solicitada por la persona asociada o a través de otra persona mediante nota de solicitud con la firma de la persona solicitante. Esta licencia deberá ser tratada de manera tal que se garantice la confidencialidad de la información y de la documentación que se adjunte"
      ],
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: Los días de licencia que no sufrirán descuentos de las retribuciones (mesadas), serán los siguientes: {OPTIONS}. El Consejo de Administración podrá ampliar o reducir los días mencionados cuando razones lo justifiquen y sea solicitado por la persona asociada, estos días serán sin goce de retribución (mesada). En el caso de reducción no podrán ser tomados con posterioridad los días no gozados."
    },
    %Question{
      chapter: :licenses,
      key: UUIDv7.generate(),
      question: "Período de vacaciones",
      answer_type: :one_option,
      options: [
        {"Todas las personas asociadas la misma cantidad de días",
         "Todas las personas asociadas contarán con la misma cantidad de días en el año calendario, el que no podrá ser menor a 14 días ni mayor a 31 días."},
        {"Diferente según antigüedad con la misma escala que la ley de contrato de trabajo",
         "a) De catorce (14) días corridos cuando siendo la antigüedad mayor a seis (6) meses no exceda de cinco (5) años.
        b) De veintiún (21) días corridos cuando siendo la antigüedad mayor de cinco (5) años no exceda de diez (10).
        c) De veintiocho (28) días corridos cuando siendo la antigüedad mayor de diez (10) años no exceda de veinte (20).
        d) De treinta y cinco (35) días corridos cuando la antigüedad exceda de veinte (20) años.
        La antigüedad se medirá en función al tiempo en la cooperativa. En casos excepcionales el Consejo de Administración podrá computar como antigüedad el trabajo en otras instituciones del rubro."}
      ],
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: Gozarán de un Período Anual de Vacaciones que serán días corridos a saber: {OPTION}. Las vacaciones no gozadas se vencen en un plazo de dos años desde que debiera tomárselas y deberán ser abonadas por la Cooperativa.
        Los plazos vacacionales iniciarán cuando el Consejo de Administración lo determine previa consulta a el/la encargado/a del sector.
        Las vacaciones anuales sólo podrán ser fraccionadas una vez.
        Las licencias deberán ser solicitadas por escrito."
    },
    %Question{
      chapter: :licenses,
      key: UUIDv7.generate(),
      question:
        "Permitir que el Consejo de Administración programe y fraccione vacaciones. Casos de concubinos en la cooperativa",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: Debido al carácter estacional de la empresa, el Consejo de Administración podrá programar y fraccionar las licencias de acuerdo a las necesidades de la Cooperativa; la no observación de las determinaciones del Consejo respecto de la programación de las licencias será considerada como falta grave. Para los casos de concubinos/as o personas casadas que sean personas asociadas a la cooperativa y requieran tomarse la licencia anual simultáneamente, debe ser aceptado salvo que causare perjuicio en el funcionamiento de la cooperativa, en ese caso por resolución fundada el Consejo puede negarse."
    },
    %Question{
      chapter: :licenses,
      key: UUIDv7.generate(),
      question: "Normas referidas a personas en condiciones de jubilarse ¿Queremos regularlo?",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: Se fija la edad jubilatoria en sesenta y cinco (65) años para la mujer o el hombre, más un (1) año para gestionar el trámite jubilatorio y dar la baja en la AFIP. Cuando la persona asociada de la Cooperativa, reuniere los requisitos necesarios para jubilarse, el Consejo de Administración deberá intimarlo/a a que realice los trámites pertinentes, extendiéndoles los certificados de servicios prestados como asociado/a y demás documentación necesaria a esos fines. A partir de ese momento, el/la asociado/a mantendrá su condición de tal y seguirá prestando servicios, hasta el momento de la obtención definitiva de la jubilación y por un plazo máximo de un año si no obtiene el beneficio. Una vez obtenida la jubilación, tendrá derecho al reembolso del Capital Integrado de acuerdo a las disposiciones de este reglamento, el Estatuto de la Cooperativa y las disposiciones de la ley 20.337.
       ARTÍCULO {NUMBER}: En caso de que la persona asociada que haya cumplido la edad correspondiente a la jubilación manifieste de forma fehaciente al Consejo de Administración su voluntad de continuar trabajando en la Cooperativa, este podrá exigirle un dictamen médico que acredite la capacidad física y mental del mismo para continuar prestando su trabajo en la Cooperativa. El mismo deberá realizarse con un cuerpo médico el cual será determinado para cada caso por el Consejo de Administración. En caso de que el dictamen médico sea favorable, se pondrá a consideración de la Asamblea y se necesitará su aprobación para la continuidad de la persona asociada en la Cooperativa, en dicho caso se extenderá la asociación, como criterio máximo, por un período de cinco (5) años, momento en que deberá retirarse definitivamente. Todos los años debe repetirse el examen médico para evaluar la condición física y mental de la persona asociada para determinar su continuidad por el plazo restante.
       ARTÍCULO {NUMBER}: Cuando el Consejo de Administración tome conocimiento, o tengan indicios ciertos de que una persona asociada ha perdido la aptitud física o mental para desempeñar sus tareas, deberá iniciar el sumario correspondiente, dando traslado del mismo a la persona asociada para que esta realice el descargo y disponiendo que se realicen los estudios pertinentes, por profesionales idóneos. La persona asociada no puede negarse a concurrir a las juntas médicas o médicos que disponga el Consejo de Administración. En caso de que la persona asociada no se presente a dicha junta será considerada falta grave.
       Constatada la incapacidad por los/las profesionales, el Consejo de Administración, ad referendum de la Asamblea, conforme el artículo 16 del Estatuto, está facultado para excluir a la persona asociada por dicha causa, ello siempre que no hubiera otras tareas o funciones que pudiera cumplir esa persona de acuerdo a la incapacidad resultante.
       ARTÍCULO {NUMBER}: La persona asociada que fuere excluida por incapacidad, mantendrá la condición de tal hasta tanto obtenga por parte del estado su beneficio jubilatorio ordinario o su beneficio por incapacidad y por un plazo máximo de un año. La Cooperativa debe extender a la persona asociada la certificación de servicios como asociado/a de la cooperativa y demás documentación necesaria a esos fines."
    }
  ]

  @spec all :: [%Question{}]
  def all, do: @all
end
