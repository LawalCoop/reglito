defmodule Reglito.Questions.PenaltiesQuestions do
  alias Reglito.Questions.Question

  @all [
    %Question{
      chapter: :penalties,
      key: UUIDv7.generate(),
      question:
        "Las sanciones se miden en función a la gravedad e importancia, valorada por el Consejo (se sugiere colocar este artículo)",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: El incumplimiento de los deberes y obligaciones dará lugar a la aplicación de sanciones que se medirán de acuerdo a su gravedad e importancia, conforme a actuaciones por escrito que tratará y resolverá el Consejo de Administración."
    },
    %Question{
      chapter: :penalties,
      key: UUIDv7.generate(),
      question: "Tipos de sanciones (se sugiere colocar este artículo)",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: Las sanciones serán notificadas por escrito y graduadas en el siguiente orden:
        a) Llamado de atención
        b) Apercibimiento
        c) Suspensión de hasta 30 días, los que pueden ser corridos o salteados
        d) Exclusión
        La persona asociada deberá firmar como constancia la recepción de las notificaciones sin que ello implique conformidad. También podrán ser enviadas por correo electrónico."
    },
    %Question{
      chapter: :penalties,
      key: UUIDv7.generate(),
      question: "Que faltas serán llamados de atención",
      answer_type: :multiple,
      options: [
        "Falta de cumplimiento de órdenes de superior jerárquico, siempre que esté referida a las tareas específicas de la persona asociada",
        "Reducción de producción debidamente comprobada o mal servicio",
        "Falta de atención en el cuidado de las máquinas, herramientas, útiles y materia prima",
        "Incumplimientos reiterados o permanentes de horario, sin justificación expresa",
        "La falta con o sin aviso, no justificada por escrito",
        "Rebaja de la calidad de la producción por negligencia comprobada diferenciando conducta de error",
        "No utilización de elementos de seguridad que sean necesarios para la actividad realizada",
        "Realizar publicaciones en redes sociales que puedan afectar la imagen de la cooperativa y su explotación",
        "No utilizar uniforme de manera reiterada en horario laboral",
        "No guardar el debido deber de confidencialidad de lo que ocurre en la cooperativa y la explotación"
      ],
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: Será objeto de llamadas de atención quienes incurrieran en: {OPTIONS}"
    },
    %Question{
      chapter: :penalties,
      key: UUIDv7.generate(),
      question: "Que faltas serán apercibimiento",
      answer_type: :text,
      options: nil,
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: Serán objeto de apercibimiento aquellas personas asociadas que {TEXT}. Éstas prescribirán pasados los dos (2) años calendarios."
    },
    %Question{
      chapter: :penalties,
      key: UUIDv7.generate(),
      question: "Que cosas implican la suspensión de la persona asociada",
      answer_type: :multiple,
      options: [
        {"Acumular en 2 años, 2 apercibimientos",
         "acumulen dentro de los dos (2) años calendarios, dos (2) apercibimientos"},
        {"Presentarse a trabajar con los sentidos perturbados",
         "así como presentarse a trabajar con los sentidos perturbados siendo un peligro para sí y/o para terceros"}
      ],
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: Serán objeto de suspensión aquellas personas asociadas que {OPTIONS}. Las suspensiones se graduarán de 1 a 30 días de acuerdo con la gravedad de la falta, los que podrán ser continuos o discontinuos."
    },
    %Question{
      chapter: :penalties,
      key: UUIDv7.generate(),
      question: "En qué casos se puede excluir a una persona asociada",
      answer_type: :multiple,
      options: [
        "Haber acumulado una tercera suspensión",
        "Robo, hurto y/o participación en ellos, debidamente comprobados, incluída la propina.",
        "Mala utilización y/o aplicación, así como la no conservación de los bienes patrimoniales de la Cooperativa, con una actitud dolosa, debidamente comprobada",
        "Desobediencias graves y reiteradas a las resoluciones y disposiciones del Consejo de Administración debidamente comprobadas",
        "Recibir comisiones o cualquier otra utilidad en las compras o ventas que realice la Cooperativa, comprobadas como prebendas de usufructo personal",
        "Promover escándalos o riñas dentro del establecimiento de la cooperativa",
        "Agresión física o verbal a otra persona asociada cualquiera sea su jerarquía",
        "Iniciar juicios, acciones legales o cualquier acción de otra índole en contra de la Cooperativa, salvo sus derechos de recursos"
      ],
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: Serán objeto de exclusión las personas asociadas que incurran en alguna de las causas siguientes: {OPTIONS}. En caso de exclusión, la persona asociada tiene derecho a seguir el proceso de apelación ante la Asamblea, según lo establece el Estatuto."
    },
    %Question{
      chapter: :penalties,
      key: UUIDv7.generate(),
      question:
        "Procedimiento del sumario interno (juicio que debemos hacer para las sanciones mas graves, suspensión y exclusión) ¿Regulamos el procedimiento?",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: En todos los casos de inconducta de la persona asociada, que dé lugar a la aplicación de las sanciones de suspensión o exclusión, obligatoriamente se instruirá un sumario que asegure a la persona asociada su legítimo derecho de defensa.
       Es obligación de las personas asociadas, de los/as encargados/as de sector y/o gerentes denunciar ante el Consejo de Administración, cualquier conducta de una persona asociada que fuere pasible de sanción; el no hacerlo hará pasible al omitente de la sanción que correspondía a la conducta que no denunció.
       ARTÍCULO {NUMBER}: Conocida en forma directa por el Consejo de Administración o por denuncia de las personas asociadas o de terceros, una de las conductas pasibles de sanción, el/la Presidente o quien reglamentariamente lo reemplace, ordenará la instrucción del Sumario en un plazo no mayor a cuarenta y ocho (48) horas hábiles de denunciada la conducta, designando al consejero que asumirá las funciones de instructor, podrá ser designado instructor el/la asesor/a legal de la cooperativa en su caso.
       ARTÍCULO {NUMBER}: En caso de que la gravedad de la falta lo aconseje, el/la Presidente, el/la Consejero/a de mayor jerarquía presente en la sede o establecimiento de la cooperativa o el/la encargado/a del sector en el que ocurriera el hecho, podrá ordenar “ad- referendum” del Consejo, la suspensión preventiva de la persona asociada imputada y su retiro del establecimiento por el tiempo que estime conveniente o hasta la finalización del sumario.
       ARTÍCULO {NUMBER}: En el caso contemplado en el artículo precedente, el Consejo en cualquier momento, podrá dejar sin efecto dicha medida.
       ARTÍCULO {NUMBER}: La suspensión será de 30 días corridos, salvo que el Consejo de Administración por resolución debidamente fundada considere razonable extender la medida hasta la finalización del sumario.
       En este marco se intentará que el sumario no se extienda más allá de treinta (30) días hábiles.
       ARTÍCULO {NUMBER}: El/la instructor/a abrirá el sumario y le fijará un plazo de setenta y dos (72) horas a la persona asociada para que realice su descargo y ofrezca la prueba que haga a su defensa; el descargo deberá ser realizado por escrito y presentado al instructor.
       La apertura del sumario y el plazo para hacer el descargo serán notificados personalmente, por carta documento o mediante el envío de un correo electrónico.
       ARTÍCULO {NUMBER}: El/la instructor/a procederá a requerir los informes que considere necesarios, podrá citar a las personas que pudieran aportar elementos de interés y producirá toda otra prueba que estimare relevante para el debido esclarecimiento de los hechos denunciados.
       ARTÍCULO {NUMBER}: El/la instructor/a podrá decretar el secreto de sumario cuando estimare que la trascendencia del contenido de las actuaciones pudieran perjudicar la investigación o el resultado final de la causa. También en casos donde pudieran tratarse cuestiones de discriminacion de cualquier tipo.
       ARTÍCULO {NUMBER}: El/la instructor/a podrá citar al imputado con el objeto de solicitar la ampliación o requerir aclaraciones sobre el descargo producido, a fin de perfeccionar el sumario.
       ARTÍCULO {NUMBER}: Producida la prueba ofrecida por el/los imputado/s que la instrucción hubiere considerado relevante y cumplimentadas las medidas ampliatorias necesarias que la misma hubiese ordenado, el/la instructor/a agregará un informe acerca de los antecedentes disciplinarios de la/las persona/s asociada/s involucrada/s y, luego de decretar el cierre de sumario, sugerirá la medida disciplinaria que a su buen entender y saber correspondería aplicar, elevando las actuaciones al Consejo de Administración para su resolución.
       ARTÍCULO {NUMBER}: En poder del Consejo de Administración, las actuaciones, este podrá, si lo estima conveniente a los fines de su resolución, solicitar al instructor una ampliación del sumario, caso contrario, resolverá en el estado que se encontrare.
       El Consejo de Administración expedirá su resolución en un término no mayor a cinco (5) días hábiles de recibido el sumario con su dictamen.
       ARTÍCULO {NUMBER}: Las resoluciones del Consejo, absolutorias o condenatorias, se notificarán por escrito, personalmente, mediante envío de telegrama colacionado,  carta documento o correo electrónico. Debiendo dejar debida constancia de las mismas en los legajos personales de los/las imputados/as."
    },
    %Question{
      chapter: :penalties,
      key: UUIDv7.generate(),
      question:
        "Sumario especial express para casos de ausencias sin aviso) ¿Regulamos el procedimiento?",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: Para los casos de ausentismo de más de tres días sin justificar el Consejo de Administración una vez cursada la intimación por carta documento o correo electrónico a/la asociado/a para que retome las tareas, sin que la misma tenga resultado positivo, deberá disponer directamente la exclusión del/la asociado/a sin necesidad de sumario previo."
    },
    %Question{
      chapter: :penalties,
      key: UUIDv7.generate(),
      question: "Resolución de los sumarios",
      answer_type: :exclusive,
      options: ["SI", "NO"],
      nested_questions: nil,
      result_template:
        "ARTÍCULO {NUMBER}: Las resoluciones definitivas del Consejo de Administración que se dictaren en los sumarios deberán ser siempre fundadas en el texto expreso de la normativa vigente. La parte dispositiva, en lo pertinente, deberá consignarse sucintamente en el libro de Actas de Consejo.
       ARTÍCULO {NUMBER}: Para graduar las sanciones a aplicar, el Consejo deberá considerar las circunstancias atenuantes y/o agravantes que concurrieran en cada caso. En particular se computará como atenuante la falta de antecedentes disciplinarios y el buen concepto general del que gozare la persona asociada. Se tendrá por agravante la condición de reincidente. Será considerado/a reincidente aquel/aquella que ya  hubiese sido objeto de sanción, aunque la/s falta/s anteriores no fueran del mismo tipo que las que dieron origen a las actuaciones en consideración.
       ARTÍCULO {NUMBER}: Si el/la imputado/a que fuere absuelto/a hubiese sido objeto de suspensión preventiva en relación con el mismo hecho por el que se lo exime de culpa, la resolución del Consejo al efecto deberá ordenar se le abonen las retribuciones (mesadas) correspondientes a todo el tiempo de la suspensión, excepto las propinas tal como si efectivamente hubiese trabajado durante ese lapso.
       ARTÍCULO {NUMBER}: Si la sanción aplicada fuere de suspensión pero por un término menor al de la suspensión preventiva, en la resolución del Consejo se ordenará efectivizar los anticipos de retorno correspondiente a la diferencia en tiempo, en forma similar a la contemplada en el artículo precedente.
       ARTÍCULO {NUMBER}: Cuando no se encontrara imputado alguno en el sumario, de modo que no se pudiera absolver o condenar a su respecto a persona humana alguna, el Consejo ordenará el sobreseimiento de las actuaciones, sin perjuicio de adoptar las medidas que, para su seguridad o resguardo del patrimonio y de las personas asociadas, pudiere establecer como su consecuencia.
       ARTÍCULO {NUMBER}: Una vez cumplida la notificación al/la imputado/a, se procederá al archivo de las actuaciones, dejando debida constancia de ellas en las mismas.
       ARTÍCULO {NUMBER}: La persona asociada disconforme con la sanción, de llamado de atención o apercibimiento, que se le haya aplicado podrá solicitar reconsideración de la misma ante el Consejo de Administración y por sanción de suspensión o exclusión podrá apelar ante la Asamblea."
    }
  ]

  def all, do: @all
end
