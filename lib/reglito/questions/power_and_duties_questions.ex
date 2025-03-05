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
    },
    %Question{
      chapter: :power_and_duties,
      key: UUIDv7.generate(),
      question: "Meses en período de prueba",
      answer_type: :number,
      options: nil,
      nested_questions: [
        %Question{
          chapter: :power_and_duties,
          key: UUIDv7.generate(),
          question: "¿Le exigimos aprobar un curso de concientización cooperativa?",
          answer_type: :exclusive,
          options: ["SI", "NO"],
          nested_questions: nil,
          result_template:
            "Deberá realizar y aprobar un curso de concientización cooperativa e introducción a la empresa de la economía social."
        }
      ],
      result_template:
        "ARTICULO {NUMBER}: Todo persona aspirante a ingresar como asociado/a deberá cumplir con un período de prueba no mayor a {NUMBER} meses. Acreditada su idoneidad laboral y espíritu cooperativista, el Consejo de Administración procederá a considerar y aprobar en su caso, el ingreso como persona asociada a la Cooperativa. El plazo de referencia quedará sujeto a cualquier modificación legislativa que establezca un plazo diferente."
    },
    %Question{
      chapter: :power_and_duties,
      key: UUIDv7.generate(),
      question:
        "Compromiso de personas asociadas con la cooperativa respecto a prestar su trabajo personal",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTICULO {NUMBER}: Las personas asociadas se comprometen a prestar su trabajo personal y su esfuerzo propio dentro de una empresa social, que se enmarca en la doctrina cooperativista, para desarrollar su objeto de la mejor manera posible, en términos de productividad, cumplimiento y eficiencia. Entendiendo y aceptando la responsabilidad conjunta, la participación activa y el compromiso para gestionar la empresa cooperativa."
    },
    %Question{
      chapter: :power_and_duties,
      key: UUIDv7.generate(),
      question:
        "Compromiso de personas asociadas con la cooperativa respecto a buscar la continuidad en el tiempo y absteniéndose de actitudes y opiniones contrarias",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTICULO {NUMBER}: Las personas asociadas entienden el carácter asociativo y se comprometen a respetar la Organización, buscando su continuidad en el tiempo, absteniéndose en actitudes y opiniones siempre que exista un interés contrario al de la Cooperativa. Primando de esta forma en todos los aspectos el interés general por encima del interés particular."
    },
    %Question{
      chapter: :power_and_duties,
      key: UUIDv7.generate(),
      question: "Derechos de las personas asociadas",
      answer_type: :multiple,
      options: [
        "Ser elector/a y elegido/a para el desempeño de los diferentes cargos en los marcos que establece el Estatuto Social y el presente Reglamento Interno.",
        "Con la firma del cincuenta por ciento (50%) del total de las personas asociadas, se podrá solicitar la realización de asambleas extraordinarias. Esta convocatoria deberá expresar concretamente los puntos del Orden del Día y deberá ser enviada al Consejo de Administración. La misma deberá realizarse dentro de los treinta (30) días de solicitada en concordancia con lo que marca el Estatuto Social. Si la asamblea ordinaria se realizará dentro de los noventa (90) días de realizado el pedido, el Consejo de Administración podrá denegarla, debiendo incluir los puntos solicitados dentro del orden del día de la Asamblea Ordinaria.",
        "Solicitar a la Sindicatura información sobre la marcha de la Cooperativa y la verificación de los Estados Contables.",
        "Gozar de un período anual de licencias (vacaciones) acorde a su antigüedad.",
        "Como monotributistas, o en otro régimen previsional, contarán con aportes al sistema jubilatorio, obra social. Mantendrán un seguro de accidentes personales, un seguro de vida o el que lo reemplace según el sistema previsional elegido.",
        "Podrán retirarse voluntariamente de la Cooperativa, dando aviso por escrito con treinta (30) días de antelación por lo menos. Al retirarse se le reintegrarán los aportes efectivamente realizados en cuotas sociales durante su permanencia como persona asociada. En el caso que la persona asociada renunciante tuviera deudas pendientes con la Cooperativa, a la suma de referencia se le deducirá el importe que corresponda."
      ],
      nested_questions: nil,
      result_template: "ARTICULO {NUMBER}: Son derechos de las personas asociadas: {OPTIONS}"
    },
    %Question{
      chapter: :power_and_duties,
      key: UUIDv7.generate(),
      question: "Obligaciones de las personas asociadas",
      answer_type: :multiple,
      options: [
        "Acatar y hacer respetar el Estatuto Social, el Reglamento Interno, las resoluciones del Consejo de Administración y las resoluciones emanadas de las Asambleas",
        "Preservar el orden, la armonía y la disciplina dentro de la Cooperativa, evitando incurrir en riñas o discusiones entre personas asociadas o respecto a clientes o terceras personas vinculadas a la empresa, de modo de no afectar la producción en horario de trabajo y de preservar la imagen cooperativista",
        "Cumplir con el horario establecido, debiendo registrar entrada y salida. Podrá retirarse transitoriamente del lugar de trabajo con justificación de causa, previa autorización del Consejo de Administración y/o encargado de sector y/o gerente y deberá cumplir con el requisito de registrar el horario de salida y de regreso",
        "Observar asistencia y puntualidad perfecta, realizando a satisfacción la tarea que se le asigne, ajustando su desempeño a los principios de solidaridad, compañerismo y mutua cooperación. Como así también es obligación respetar los índices de productividad y metas fijadas por la Cooperativa",
        "Concurrir y participar activamente en la discusión de los problemas que afecten a la Cooperativa, tratando de aportar ideas y/o sugerencias que hagan posible encontrar soluciones adecuadas a cada cuestión planteada",
        "Comunicar con la debida antelación la ausencia al trabajo y la fecha estimada de reingreso de manera fehaciente, o en su defecto dentro de las 3 (tres) primeras horas del día en que la ausencia se produzca, debiendo posteriormente justificar ante el Consejo de Administración, el/la encargado/a o gerente/a el motivo de la falta. Si el motivo aludido no es a criterio del Consejo de Administración suficiente para haber motivado la ausencia al trabajo la misma podrá ser injustificada",
        "En caso de que la ausencia al trabajo se deba por causa de una fiesta, trámites, un viaje u otra situación planeable con anticipación, se debe comunicar y solicitar la anuencia del Consejo, cuatro (4) días hábiles antes del evento a fin de que el mismo pueda determinar la suplencia correspondiente. Sólo procederá la ausencia en estos casos siempre que no se afectare el normal desenvolvimiento de la cooperativa y de los procesos productivos, debiendo en estos casos el Consejo de Administración fundar la negativa",
        "Abstenerse de consumir bebidas alcohólicas, drogas y energizantes en los horarios de trabajo, dentro y fuera de la Cooperativa",
        "Prestar tareas más allá del horario habitual y aún en días feriados, cuando necesidades urgentes o extraordinarias en la Cooperativa así lo requieran sin necesidad de pago extra aun siendo días feriados incluso para el sector administrativo. Dicho esfuerzo extraordinario podrá ser requerido por el Consejo de Administración, por encargados/as o gerentes/as sobre la base del plan de servicio establecido o quien se encuentre a cargo de la producción en ese momento",
        "Aportar su colaboración permanente con el objeto de asegurar la continuidad del trabajo en los distintos sectores de la Cooperativa, lo cual implica que finalizada una tarea dentro del horario habitual se preste apoyo a otras personas asociadas que aún no han finalizado las suyas siempre que lo pida el Consejo de Administración, los/las encargados/as o gerentes/as",
        "Someterse periódicamente a exámenes médicos cuando así lo disponga el Consejo de Administración de acuerdo a lo que establece la legislación vigente con el objeto de preservar su salud física y psíquica. Este requisito podrá ser exigido a los/las aspirantes a ingresar como personas asociadas de la Cooperativa, incluyendo los exámenes preocupacionales de las personas candidatas a ingresar",
        "Recibir todas las notificaciones de cualquier tipo que emanen de jerarquía o de autoridad institucional y dar el comprendido firmando copia de éstas lo cual no implica aceptación del contenido. Toda persona asociada que no se notificare de ésta forma será considerado de falta grave. Se podrá notificar además al correo electrónico declarado con la misma validez",
        "Abstenerse de fumar en los lugares que determine el Consejo de Administración de acuerdo a las normas de calidad, y las normas de bioseguridad e higiene",
        "Usar todos los elementos de trabajo y/o protección que indican las leyes de seguridad e higiene y disposiciones legales de protección del medio ambiente",
        "Denunciar al Consejo de Administración cualquier cambio de domicilio bajo apercibimiento de tenerse por notificadas todas las decisiones y resoluciones cursadas en el obrante en el legajo de la cooperativa de no mediar dicha denuncia",
        "Realizará los cambios de trabajo de un plantel a otro dentro de la Cooperativa sin poder retirarse de su puesto hasta que la persona asociada que debe reemplazarlo llegue a relevarlo",
        "Denunciar ante el Consejo de Administración, cualesquiera hechos que cometidos por personas asociadas o no, que pongan en peligro los intereses y funcionamiento de la cooperativa como así los intereses de las personas asociadas en particular",
        "Realizar los cursos sobre cooperativismo que el Consejo de Administración destine a las personas asociadas para un mejor conocimiento y progreso de la empresa cooperativa. Esto incluyen además formaciones en general vinculadas a la actividad de la cooperativa actual u a otras que pueda llegar a explorar realizar",
        "Serán responsables por la calidad del servicio, debiendo obtener la máxima eficiencia de los elementos a su cargo, procurando y promoviendo el cuidado y esmerada atención de éstos",
        "Mantendrán el orden, la disciplina y acatarán las órdenes de sus superiores en lo referente a las tareas propias, sin que ello implique menoscabo alguno de sus derechos",
        "Toda persona asociada está obligada a vigilar constantemente la marcha de la Cooperativa y la conducta de sus representantes legales"
      ],
      nested_questions: nil,
      result_template: "ARTICULO {NUMBER}: Son obligaciones de las personas asociadas: {OPTIONS}"
    }
  ]

  @spec all :: [%Question{}]
  def all, do: @all
end
